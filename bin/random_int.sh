#!/bin/bash

#Gets a random int between bound1 and bound2
#Usage int randomint int bound1 int bound2

random_int() {
    local rand=$(openssl rand 4 | od -DAn)
    echo $((($1<$2?$1:$2) + ( rand % (1 + ($1<$2?$2:$1) - ($1<$2?$1:$2) ) ) ))
}
