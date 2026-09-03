#!/usr/bin/env bash

# XMB 420 - Loading Screen
# Version: v2.9

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'

clear

echo -e "${CYAN}${BOLD}"
cat << "EOF"
  ╔══════════════════════════════════════════════╗
  ║   🚗 XMB 420 - CPM SCRIPT MANAGER           ║
  ║   Loading...                                ║
  ╚══════════════════════════════════════════════╝
EOF
echo -e "${RESET}"

echo ""
echo -e "${CYAN}   Initializing...${RESET}"
echo ""

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
    
    echo -ne "\r   [${bar}] ${percent}%"
    
    if [ $i -lt 10 ]; then
        sleep 0.12
    elif [ $i -lt 25 ]; then
        sleep 0.07
    elif [ $i -lt 40 ]; then
        sleep 0.05
    else
        sleep 0.03
    fi
done

echo -e "\n"
echo -e "${GREEN}   ✅ XMB 420 Ready!${RESET}"
sleep 1
