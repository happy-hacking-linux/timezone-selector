tzOptionsByRegion () {
    options=$(cd /usr/share/zoneinfo/$1 && find . | sed "s|^\./||" | sed "s/^\.//" | sed '/^$/d')
}

tzRegions () {
    regions=$(find /usr/share/zoneinfo/. -maxdepth 1 -type d | cut -d "/" -f6 | sed '/^$/d')
}

tzSelectionMenu () {
    tzRegions
    regionsArray=()
    while read i name; do
        regionsArray+=($i "$name")
    done <<< "$regions"

    region=$(dialog --stdout \
                      --title "Timezones" \
                      --backtitle "$1" \
                      --ok-label "Next" \
                      --no-cancel \
                      --menu "Select a continent or ocean from the menu:" \
                      20 30 30 \
                      "${regionsArray[@]}")

    tzOptionsByRegion $region

    optionsArray=()
    while read i name; do
        optionsArray+=($i "$name")
    done <<< "$options"

    tz=$(dialog --stdout \
                    --title "Timezones" \
                    --backtitle "$1" \
                    --ok-label "Next" \
                    --cancel-label "Back to Regions" \
                    --menu "Select your timezone in ${region}:" \
                    20 40 30 \
                    "${optionsArray[@]}")

    if [[ -z "${tz// }" ]]; then
        tzSelectionMenu
    else
        $selected="/usr/share/zoneinfo/$region/$tz"
    fi
}

tzSelectionMenu "Happy Hacking Linux"
