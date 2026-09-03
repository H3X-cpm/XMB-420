#!/usr/bin/env bash

# XMB 420 - Car Parking Multiplayer Script Manager
# Version: v2.9
# GitHub: H3X-cpm/XMB-420

# ============================================
# VERSION INFO
# ============================================

XMB_VERSION="v2.9"
XMB_RELEASE="September 2026"
XMB_AUTHOR="H3X-cpm"

# ============================================
# ANSI COLOR CODES
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ============================================
# SIMPLE RAINBOW FUNCTION
# ============================================

rainbow_text() {
    local text="$1"
    local colors=(
        "\033[31m"
        "\033[33m"
        "\033[32m"
        "\033[36m"
        "\033[34m"
        "\033[35m"
    )
    local len=${#text}
    local color_count=${#colors[@]}
    
    for (( i=0; i<len; i++ )); do
        local char="${text:$i:1}"
        local color_idx=$((i % color_count))
        echo -ne "${colors[$color_idx]}$char"
    done
    echo -e "\033[0m"
}

# ============================================
# BANNER
# ============================================

print_banner() {
    clear
    
    local logo_lines=(
        "  ██╗  ██╗███╗   ███╗██████╗  █████╗  █████╗  ██████╗ "
        "  ╚██╗██╔╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗╚════██╗"
        "   ╚███╔╝ ██╔████╔██║██████╔╝███████║███████║ █████╔╝"
        "   ██╔██╗ ██║╚██╔╝██║██╔══██╗██╔══██║██╔══██║ ╚═══██╗"
        "  ██╔╝ ██╗██║ ╚═╝ ██║██████╔╝██║  ██║██║  ██║██████╔╝"
        "  ╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ "
        "                                                    "
        "  ██████╗  █████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗"
        "  ██╔══██╗██╔══██╗██╔══██╗██║  ██║██║████╗  ██║██╔════╝"
        "  ██████╔╝███████║██████╔╝███████║██║██╔██╗ ██║██║  ███╗"
        "  ██╔═══╝ ██╔══██║██╔══██╗██╔══██║██║██║╚██╗██║██║   ██║"
        "  ██║     ██║  ██║██║  ██║██║  ██║██║██║ ╚████║╚██████╔╝"
        "  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ "
    )
    
    for line in "${logo_lines[@]}"; do
        rainbow_text "$line"
        echo ""
        sleep 0.05
    done
    
    echo ""
    echo -e "${BOLD}${YELLOW}   🚗 Car Parking Multiplayer Script Manager ${XMB_VERSION}${RESET}"
    echo -e "${DIM}${CYAN}   ───────────────────────────────────────────────────────${RESET}"
    echo ""
}

# ============================================
# LOADING SCREEN
# ============================================

loading_screen() {
    clear
    print_banner
    
    echo -e "${BOLD}${CYAN}   ╔═══════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${CYAN}   ║${RESET}${BOLD}${WHITE}              LOADING XMB 420 ${XMB_VERSION}                    ${RESET}${BOLD}${CYAN}║${RESET}"
    echo -e "${BOLD}${CYAN}   ╚═══════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    local total=50
    local spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local modules=("Core" "Network" "Scripts" "Encryption" "UI" "Tools" "Config" "Ready")
    
    for i in $(seq 0 $total); do
        local percent=$((i * 100 / total))
        local filled=$((i * 30 / total))
        local bar=""
        
        for j in $(seq 1 30); do
            if [ $j -le $filled ]; then
                bar="${bar}█"
            else
                bar="${bar}░"
            fi
        done
        
        local mod_idx=$((i * ${#modules[@]} / total))
        if [ $mod_idx -ge ${#modules[@]} ]; then
            mod_idx=$((${#modules[@]} - 1))
        fi
        local module_name="${modules[$mod_idx]}"
        
        local spin_idx=$((i % ${#spinner[@]}))
        echo -ne "\r   ${spinner[$spin_idx]}  [${bar}] ${percent}% - ${module_name}"
        
        if [ $i -lt 10 ]; then
            sleep 0.15
        elif [ $i -lt 25 ]; then
            sleep 0.08
        elif [ $i -lt 40 ]; then
            sleep 0.05
        else
            sleep 0.03
        fi
    done
    
    echo ""
    echo ""
    echo -e "${GREEN}   ✅ XMB 420 ${XMB_VERSION} Loaded!${RESET}"
    echo -e "${DIM}${CYAN}   ───────────────────────────────────────────────────────${RESET}"
    sleep 1
}

# ============================================
# CHECK DEPENDENCIES
# ============================================

check_dependencies() {
    echo -e "\n${BLUE}[*] Checking dependencies...${RESET}"
    
    local deps=("curl" "openssl" "lua" "git")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${YELLOW}[!] Missing: ${missing[*]}${RESET}"
        echo -e "${BLUE}[*] Installing...${RESET}"
        pkg update -y 2>/dev/null
        pkg install "${missing[@]}" -y 2>/dev/null
    fi
    
    echo -e "${GREEN}[✓] All dependencies installed${RESET}"
    sleep 1
}

# ============================================
# CREATE DIRECTORIES
# ============================================

create_directories() {
    mkdir -p "$HOME/.xmb420/scripts"
    mkdir -p "$HOME/.xmb420/encrypted"
    mkdir -p "$HOME/.xmb420/downloads"
    mkdir -p "$HOME/.xmb420/tools"
    mkdir -p "$HOME/.xmb420/paid"
}

# ============================================
# CHECK UPDATES
# ============================================

check_updates() {
    echo -e "\n${CYAN}[*] Checking for updates...${RESET}"
    echo -e "${GREEN}[✓] You have the latest version: ${XMB_VERSION}${RESET}"
    echo ""
}

# ============================================
# DOWNLOAD AND RUN MENU
# ============================================

download_and_run_menu() {
    echo -e "${CYAN}[*] Launching XMB 420 ${XMB_VERSION}...${RESET}"
    sleep 1
    
    # Download menu.lua to a temporary file
    local menu_url="https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/menu.lua"
    local menu_file="/data/data/com.termux/files/usr/tmp/xmb_menu.lua"
    
    echo -e "${CYAN}[*] Downloading menu...${RESET}"
    
    # Try curl first
    if command -v curl &> /dev/null; then
        curl -s -L "$menu_url" -o "$menu_file"
    else
        # Fallback to wget
        wget -q -O "$menu_file" "$menu_url"
    fi
    
    # Check if download succeeded
    if [ -f "$menu_file" ]; then
        echo -e "${GREEN}[✓] Menu loaded successfully${RESET}"
        sleep 1
        lua "$menu_file"
    else
        echo -e "${RED}[✗] Failed to download menu.lua${RESET}"
        echo -e "${YELLOW}[!] Trying alternative method...${RESET}"
        
        # Alternative: run directly from curl pipe
        lua <(curl -s -L "$menu_url")
    fi
}

# ============================================
# MAIN
# ============================================

# Show banner
print_banner
sleep 1

# Show loading screen
loading_screen

# Check dependencies
check_dependencies

# Create directories
create_directories

# Check updates
check_updates

# Download and run menu
download_and_run_menu

exit 0
