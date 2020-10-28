#!/bin/bash

#Generates the base savegame skeleton
#Depends on config.cfg for the save path folder
#Usage void init_game

init_game() {
    local saves_path=$(get_property "saveFolderPath" config.cfg)
    local curr_save_path="${saves_path}/"$(get_property "current_save" ${saves_path}/current_data)
    rm -r "${curr_save_path}/map" 2>/dev/null
    mkdir -p "${curr_save_path}/map"
    generate_map "${curr_save_path}/map"

    local node="${curr_save_path}/map/$(take_location_random ${curr_save_path}/map)"
    generate_if_needed "${node}" "continent"

    node="${node}/$(take_location_random ${node})"
    generate_if_needed "${node}" "country"

    node="${node}/$(take_location_random ${node})"
    generate_if_needed "${node}" "region"
    node=$( generate_locality_in "${node}" "starting_area" )

    generate_player
    set_property "player_position" "${node}" ${curr_save_path}/player/player_properties

    
}