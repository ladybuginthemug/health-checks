#!/bin/bash


run_cmd() {
    echo "--- running $cmd ---"
    cmd="$1"
    retries="$2"
    n=0

    while ! $cmd && [ $n -lt $retries ]; do
    	echo " "
    	echo "--- [Running command]: $cmd ---"
    	$cmd
        sleep $n
        ((n=n+1))
        echo " "
        echo "--- [Retry #$n]: $cmd failed ---"
    done

    if [ $n -eq $retries ]; then
    	echo " "
        echo "--- [Command failed] after $retries retries: $cmd  ---"
        
        return 1
    else
    	echo " "
        echo "--- [Command succeeded]:  $cmd ---"
        succeeded_cmds[${#succeeded_cmds[@]}]="$cmd"
        return 0
    fi

}


if [ $# -eq 0 ]; then
    echo "Usage: $0 <command-1:retries> <command-2:retries> ..."
    exit 1
fi


for cmd_arg in "$@"; do
    IFS=':' read -r cmd retries <<< "$cmd_arg"
    run_cmd "$cmd" "$retries" &
done


wait

    
echo "--- All commands have completed ---"


