#!/usr/bin/env bash

# Verify whether wlogout is already running
if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Set variables
scr_dir=$(dirname "$(realpath "$0")")
w_layout="$XDG_CONFIG_HOME/wlogout/layout"
w_style="$XDG_CONFIG_HOME/wlogout/style.css"
curr_w_style="$XDG_CONFIG_HOME/wlogout/curr_style.css"

echo "wlogout layout: ${w_layout}"
echo "wlogout style: ${w_style}"

# Detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Scale config layout and style
menu_column=6
export mgn=$((y_mon * 28 / hypr_scale))
export hvr=$((y_mon * 23 / hypr_scale))

# scale font size

export font_size=$((y_mon * 2 / 200))

#// detect wallpaper brightness

# cacheDir="${HYDE_CACHE_HOME}"
# dcol_mode="${dcol_mode:-dark}"
# shellcheck disable=SC1091
# [ -f "${cacheDir}/wall.dcol" ] && source "${cacheDir}/wall.dcol"

#  Theme mode: detects the color-scheme set in hypr.theme and falls back if nothing is parsed.
# enableWallDcol="${enableWallDcol:-1}"
# if [ "${enableWallDcol}" -eq 0 ]; then
#     HYDE_THEME_DIR="${HYDE_THEME_DIR:-$confDir/hyde/themes/$HYDE_THEME}"
#     dcol_mode=$(get_hyprConf "COLOR_SCHEME")
#     dcol_mode=${dcol_mode#prefer-}
#     # shellcheck disable=SC1091
#     [ -f "${HYDE_THEME_DIR}/theme.dcol" ] && source "${HYDE_THEME_DIR}/theme.dcol"
# fi
# { [ "${dcol_mode}" == "dark" ] && export BtnCol="white"; } || export BtnCol="black"

export BtnCol="white"

# eval hypr border radius

hypr_border="${hypr_border:-10}"
export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 5))

# Replace variables in style.css
envsubst < $w_style > $curr_w_style

# curr_w_style="$(envsubst < $w_style)"
#
# echo $curr_w_style

# Launch wlogout
# wlogout -b "${menu_column}" -c -1 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${curr_w_style}") --protocol layer-shell
wlogout -b "${menu_column}" -c -1 -r 0 -m 0 --layout "${w_layout}" --css "${curr_w_style}" --protocol layer-shell
