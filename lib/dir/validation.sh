#!/bin/bash

validate_dir_exist(){
    local file="$1"
    if [ -d "$file" ]; then
        echo "Directory $file does exist."
        return 1
    fi

    return 0

}