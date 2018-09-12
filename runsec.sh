#!/bin/bash
PS3='Run on all folders containing Gemfile.lock: '
options=("brakeman" "bundler_audit" "hakiri_prime" "hakiri_scan" "Quit")

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
        "bundler_audit")
            echo "running BUNDLER AUDIT"
            cmd='bundler audit'
            break
            ;;
        "hakiri_prime")
            echo "generating DEFAULT manifest for HAKIRI"
            cmd='hakiri manifest:generate'
            break
            ;;
        "hakiri_scan")
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
