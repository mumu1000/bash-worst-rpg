#!/bin/bash

#Prompts user for an int value between min and max included (can be ommitted)
#Usage int prompt_int (opt)int min (opt)int max (opt)str prompt

prompt_int() {
    read -p "${3} " inp
    while [[ ! $inp =~ ^-?[0-9]+$ ]] || ( [[ $1 != "" ]] && (( $inp < $1 )) ) || ( [[ $2 != "" ]] && (( inp > $2 )) )
        do read -p "${3} " inp
    done
    echo "$inp"
}

