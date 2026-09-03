#!/usr/bin/env bash

# XMB 420 Loader Screen

clear
echo -e "\033[36m"
cat << "EOF"
  ╔══════════════════════════════════════════════╗
  ║   🚗 XMB 420 - CPM SCRIPT MANAGER           ║
  ║   Loading...                                ║
  ╚══════════════════════════════════════════════╝
EOF
echo -e "\033[0m"

# Progress bar
total=50
for i in $(seq 0 $total); do
    percent=$((i * 100 / total))
    filled=$((i * 30 / total))
    bar=""
    
    for j in $(seq 1 30); do
        if [ $j -le $filled ]; then
            bar="${bar}█"
        else
            bar="${bar}░"
        fi
    done
    
    if [ $percent -lt 33 ]; then
        color="\033[36m"
    elif [ $percent -lt 66 ]; then
        color="\033[33m"
    else
        color="\033[32m"
    fi
    
    echo -ne "\r${color}[${bar}] ${percent}% - Loading scripts...\033[0m"
    sleep 0.05
done

echo -e "\n\033[32m[✓] XMB 420 Ready!\033[0m"
sleep 1