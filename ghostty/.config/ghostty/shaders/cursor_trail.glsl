// Cursor trail shader — ported from kitty config:
//   cursor_trail 10              → DURATION 0.35s
//   cursor_trail_start_threshold 0 → no movement threshold, fires immediately
//   cursor_trail_decay 0.01 0.05   → exponential fade, slow start / fast end
//   cursor_shape block

// ─── Tunables ────────────────────────────────────────────────────────────────
const float DURATION      = 0.35;   // total trail lifetime (cursor_trail 10)
const float DECAY_MIN     = 0.01;   // min decay rate (start of trail)
const float DECAY_MAX     = 0.05;   // max decay rate (end of trail)
const float SAT_BOOST     = 1.8;    // colour saturation multiplier
// ─────────────────────────────────────────────────────────────────────────────

void processEdge(vec2 p, vec2 a, vec2 b, inout float minDist, inout float inside) {
    vec2 edge    = b - a;
    vec2 pa      = p - a;
    float invLen = 1.0 / dot(edge, edge);
    float t      = clamp(dot(pa, edge) * invLen, 0.0, 1.0);
    vec2 diff    = pa - edge * t;
    minDist      = min(minDist, dot(diff, diff));
    float cross  = edge.x * pa.y - edge.y * pa.x;
    inside       = min(inside, step(0.0, cross));
}

float sdHexagon(in vec2 p,
                in vec2 v0, in vec2 v1, in vec2 v2,
                in vec2 v3, in vec2 v4, in vec2 v5) {
    float minDist = 1e20;
    float inside  = 1.0;
    processEdge(p, v0, v1, minDist, inside);
    processEdge(p, v1, v2, minDist, inside);
    processEdge(p, v2, v3, minDist, inside);
    processEdge(p, v3, v4, minDist, inside);
    processEdge(p, v4, v5, minDist, inside);
    processEdge(p, v5, v0, minDist, inside);
    float dist = sqrt(max(minDist, 0.0));
    return mix(dist, -dist, inside);
}

float sdRectangle(in vec2 p, in vec2 center, in vec2 halfSize) {
    vec2 d = abs(p - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

struct Quad { vec2 topLeft, topRight, bottomLeft, bottomRight; };

Quad getQuad(vec2 pos, vec2 size) {
    Quad q;
    q.topLeft     = pos;
    q.topRight    = pos + vec2(size.x, 0.0);
    q.bottomLeft  = pos - vec2(0.0, size.y);
    q.bottomRight = pos + vec2(size.x, -size.y);
    return q;
}

void selectTrailCorners(Quad q, vec2 sel, out vec2 p1, out vec2 p2, out vec2 p3) {
    p1 = mix(mix(q.topRight,    q.topLeft,    sel.x), mix(q.bottomRight, q.bottomLeft, sel.x), sel.y);
    p2 = mix(mix(q.topLeft,     q.bottomLeft, sel.x), mix(q.topRight,    q.bottomRight,sel.x), sel.y);
    p3 = mix(mix(q.bottomRight, q.topRight,   sel.x), mix(q.bottomLeft,  q.topLeft,   sel.x), sel.y);
}

void selectCorners(Quad q, vec2 sel,
                   out vec2 p1, out vec2 p2, out vec2 p3, out vec2 p4) {
    selectTrailCorners(q, sel, p1, p2, p3);
    p4 = mix(mix(q.bottomLeft, q.bottomRight, sel.x), mix(q.topLeft, q.topRight, sel.x), sel.y);
}

float easeCubicOut(float x) {
    float t = 1.0 - x;
    return 1.0 - t * t * t;
}

// Simulates cursor_trail_decay: exponential fade whose rate interpolates
// from DECAY_MIN (fresh trail) to DECAY_MAX (end of trail), matching
// kitty's slow-start / fast-end feel.
float decayAlpha(float progress) {
    float rate = mix(DECAY_MIN, DECAY_MAX, progress);
    // integrate: alpha = exp(-rate * 60 * t) approximated over [0,1]
    float k = mix(DECAY_MIN, DECAY_MAX, 0.5) * 60.0 * DURATION;
    return clamp(1.0 - pow(progress, 1.0 / (1.0 - k * 0.01 + 0.5)), 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    float baseProgress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    vec2  uv           = fragCoord / iResolution.xy;
    vec4  background   = texture(iChannel0, uv);

    if (baseProgress >= 1.0) { fragColor = background; return; }

    fragColor = background;

    float invResY  = 1.0 / iResolution.y;
    float scale    = 2.0 * invResY;
    float aaWidth  = scale;
    vec2  normOff  = iResolution.xy * invResY;

    vec2 currentPos  = iCurrentCursor.xy  * scale - normOff;
    vec2 previousPos = iPreviousCursor.xy * scale - normOff;
    vec2 currentSize = iCurrentCursor.zw  * scale;
    vec2 deltaPos    = currentPos - previousPos;

    // cursor_trail_start_threshold 0 → always draw, no minimum delta guard
    Quad currentCursor  = getQuad(currentPos,  currentSize);
    Quad previousCursor = getQuad(previousPos, iPreviousCursor.zw * scale);
    vec2 selector       = step(vec2(0.0), deltaPos);

    vec2 currP1, currP2, currP3, currP4;
    vec2 prevP1, prevP2, prevP3;
    selectCorners     (currentCursor,  selector, currP1, currP2, currP3, currP4);
    selectTrailCorners(previousCursor, selector, prevP1, prevP2, prevP3);

    float easedProgress       = easeCubicOut(baseProgress);
    float easedProgressDouble = easeCubicOut(min(baseProgress * 2.0, 1.0));

    vec2 trailP1 = mix(prevP1, currP1, easedProgress);
    vec2 trailP2 = mix(prevP2, currP2, easedProgressDouble);
    vec2 trailP3 = mix(prevP3, currP3, easedProgressDouble);

    vec2  normCoord = fragCoord * scale - normOff;
    float sdfHex    = sdHexagon(normCoord, trailP1, trailP2, currP2, currP4, currP3, trailP3);
    float shapeAlpha = 1.0 - smoothstep(-aaWidth, aaWidth, sdfHex);

    // Apply decay fade (cursor_trail_decay 0.01 0.05)
    float fade  = 1.0 - pow(baseProgress, 0.35);   // fast drop matches max_decay 0.05
    float alpha = shapeAlpha * fade;

    // Saturate cursor colour
    float gray = dot(iCurrentCursorColor.rgb, vec3(0.299, 0.587, 0.114));
    vec4 enhanced = clamp(
        mix(vec4(vec3(gray), iCurrentCursorColor.a), iCurrentCursorColor, SAT_BOOST),
        0.0, 1.0
    );

    vec4 original = fragColor;
    fragColor.rgb  = mix(fragColor.rgb, enhanced.rgb, alpha);

    // Punch out where actual cursor sits (block shape)
    vec2 halfSize     = currentSize * 0.5;
    vec2 currentCenter = currentPos + vec2(halfSize.x, -halfSize.y);
    float sdfCursor   = sdRectangle(normCoord, currentCenter, halfSize);
    fragColor.rgb     = mix(fragColor.rgb, original.rgb, step(sdfCursor, 0.0));
}
