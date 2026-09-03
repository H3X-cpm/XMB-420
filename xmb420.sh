#!/usr/bin/env bash

# XMB 420 - Car Parking Multiplayer Script Manager
# GitHub: YOUR_USERNAME/XMB-420

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

clear

# Big Banner
echo -e "${CYAN}"
cat << "EOF"
  ██╗  ██╗███╗   ███╗██████╗  █████╗  █████╗  ██████╗ 
  ╚██╗██╔╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗╚════██╗
   ╚███╔╝ ██╔████╔██║██████╔╝███████║███████║ █████╔╝
   ██╔██╗ ██║╚██╔╝██║██╔══██╗██╔══██║██╔══██║ ╚═══██╗
  ██╔╝ ██╗██║ ╚═╝ ██║██████╔╝██║  ██║██║  ██║██████╔╝
  ╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ 
                                                         
  ██████╗  █████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
  ██╔══██╗██╔══██╗██╔══██╗██║  ██║██║████╗  ██║██╔════╝
  ██████╔╝███████║██████╔╝███████║██║██╔██╗ ██║██║  ███╗
  ██╔═══╝ ██╔══██║██╔══██╗██╔══██║██║██║╚██╗██║██║   ██║
  ██║     ██║  ██║██║  ██║██║  ██║██║██║ ╚████║╚██████╔╝
  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
EOF
echo -e "${WHITE}Car Parking Multiplayer Script Manager v1.0${NC}"
echo -e "${YELLOW}================================================${NC}"
sleep 2

# Loading screen
bash <(curl -s https://raw.githubusercontent.com/YOUR_USERNAME/XMB-420/main/loader.sh)

# Check dependencies
echo -e "\n${BLUE}[*] Checking dependencies...${NC}"
deps=("curl" "openssl" "lua" "luajit" "git")
missing=()
for dep in "${deps[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo -e "${YELLOW}[!] Missing: ${missing[*]}${NC}"
    echo -e "${BLUE}[*] Installing...${NC}"
    pkg update -y
    pkg install "${missing[@]}" -y
fi

echo -e "${GREEN}[✓] All dependencies installed${NC}"
sleep 1

# Create local directories
mkdir -p "$HOME/.xmb420/scripts"
mkdir -p "$HOME/.xmb420/encrypted"
mkdir -p "$HOME/.xmb420/downloads"

# Launch main menu
lua <(curl -s https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/menu.lua)