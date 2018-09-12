#!/bin/bash
PS3='Run on all folders containing Gemfile.lock: '
options=("brakeman" "bundler audit" "hakiri prime" "hakiri scan" "Quit")

run_command () {
    for i in `ls -d */Gemfile.lock`
    do
        folder=${i::${#i}-12}
        cd $folder
        echo ""
        echo "Running $cmd in $folder"
        echo ""
        $cmd
        cd ..
    done
}

select opt in "${options[@]}"
do
    case $opt in
        "brakeman")
            echo "running BRAKEMAN, see brakeman.report in each folder"
            cmd='brakeman -A -o brakeman.report'
            break
            ;;
        "bundler audit")
            echo "running BUNDLER AUDIT"
            cmd='bundler audit'
            break
            ;;
        "hakiri priming")
            echo "generating DEFAULT manifest for HAKIRI"
            cmd='hakiri manifest:generate'
            break
            ;;
        "hakiri scan")
            echo "running HAKIRI"
            cmd='hakiri system:scan'
            break
            ;;
        "Quit")
            echo "Leaving..."
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
run_command
