#!/bin/bash
set -x
# apply | create | delete
command=$1

# yml files starting with 3 digit number and an underscore
files=($(ls -d -- shtl-ink/ddns/[0-9][0-9][0-9]_*.yml))

case $command in
    apply | create)
        for file in ${files[@]};do
            kubectl $command -f $file
        done;;
    delete)
        for (( idx=${#files[@]}-1 ; idx>=0 ; idx-- ));do
            kubectl $command -f "${files[idx]}"
        done;;
    *)
        echo "$command is not a valid command";;
esac