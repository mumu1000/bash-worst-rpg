#!/bin/bash

#Prompts user for an int value between min and max included (can be ommitted)
#Usage int prompt_int (opt)int min (opt)int max (opt)str prompt

prompt_int() {
    read -p "${3} " inp
    while [[ ! $inp =~ ^[a-zA-Z0-9_]+$ ]]
        do read -p "${3} " inp
    done
    echo "$inp"
}