#!/bin/bash
SESSION=$1
INDEX=$2
WINDOW=$3

case $SESSION in
    ice)         NAMES=(init frost blizzard tundra glacier avalanche snowdrift permafrost sleet hailstorm whiteout flurry icepack snowfall crevasse iceberg frostbite powder slush coldsnap) ;;
    notes)       NAMES=(init parchment quill inkwell scroll codex folio tome cipher glyph rune script ledger memoir draft verse stanza prose anthology excerpt) ;;
    ghostty)     NAMES=(init phantom specter wraith shade apparition poltergeist revenant banshee shadow omen haunt mirage echo wisp veil shroud dusk gloom mist) ;;
    tmux)        NAMES=(init pane split tile grid mosaic layout frame canvas window viewport region sector zone cluster block cell matrix panel partition) ;;
    sesh)        NAMES=(init burrow den lair nest hollow cavern alcove refuge shelter retreat hideout sanctuary haven nook grotto recess cove vault chamber) ;;
    fish)        NAMES=(init coral reef kelp tide current shoal brine depths abyss lagoon harbor swell surge drift wake crest foam ripple eddy) ;;
    blockchain)  NAMES=(init ledger cipher block hash node chain wallet token mint forge stake vault relay bridge shard epoch slot beacon sync) ;;
    kernel)      NAMES=(init core pulse root seed stem branch thread fork daemon socket buffer heap stack trace patch module driver signal interrupt) ;;
    radware)     NAMES=(init probe signal trace route beacon packet relay gateway bridge subnet firewall tunnel vlan proxy sniffer scanner monitor filter audit) ;;
    malware)     NAMES=(init venom fang claw barb spike talon viper cobra python adder mamba serpent hydra scorpion hornet wasp locust plague swarm) ;;
    home)        NAMES=(init hearth ember glow warmth haven solace shelter comfort refuge peace haven tranquil serene bloom meadow grove vale dusk twilight) ;;
    downloads)   NAMES=(init cache fetch pull grab stash sync queue buffer stream batch harvest scrape gather collect import extract archive retrieve deposit) ;;
    aerospace)   NAMES=(init orbit launch dock glide soar thrust ascent payload fairing booster apogee perigee zenith nadir vector trajectory azimuth declination) ;;
    nvim)        NAMES=(init buffer motion yank mark jump macro register command mode visual insert normal operator plugin keymap autocmd highlight snippet fold) ;;
    dotfiles)    NAMES=(init config hook alias patch tweak script module profile bashrc zshrc toml yaml json env source symlink stow dotenv) ;;
    *)           NAMES=(init wanderer drifter nomad cipher phantom relic ember static void pulse flicker remnant hollow specter trace anchor fragment signal echo) ;;
esac

if [ "$INDEX" -lt "${#NAMES[@]}" ]; then
    tmux rename-window -t "$WINDOW" "${NAMES[$INDEX]}"
else
    tmux command-prompt -I "" -p "Window name:" "rename-window -t $WINDOW %%"
fi
