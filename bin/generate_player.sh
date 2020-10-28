#!/bin/bash

#Generates a player using config + save files and prompts to the player
#Depends on config.cfg for the save path folder
#Usage void generate_player

generate_player() {
    local saves_path=$(get_property "saveFolderPath" config.cfg)
    local curr_save_path="${saves_path}/"$(get_property "current_save" ${saves_path}/current_data)
    rm -r "${curr_save_path}/player/" 2>/dev/null
    mkdir -p "${curr_save_path}/player/"
    read -p 'Name your player : ' pname
    set_property "player_name" "${pname}" ${curr_save_path}/player/player_properties
    for a in $(cat ../data/attributes_types) ; do
        set_property "${a}" "1" ${curr_save_path}/player/player_stats
    done
    set_property "experience" "0" ${curr_save_path}/player/player_stats
    set_property "level" "1" ${curr_save_path}/player/player_stats
}