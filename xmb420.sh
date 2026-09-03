#!/usr/bin/env bash

# XMB 420 - Car Parking Multiplayer Script Manager
# GitHub: H3X-cpm/XMB-420

# ============================================
# ANSI COLOR CODES WITH RGB SUPPORT
# ============================================

# Standard colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# RGB 24-bit colors (for true color terminals)
RGB_RED='\033[38;2;255;0;0m'
RGB_GREEN='\033[38;2;0;255;0m'
RGB_BLUE='\033[38;2;0;0;255m'
RGB_YELLOW='\033[38;2;255;255;0m'
RGB_PURPLE='\033[38;2;255;0;255m'
RGB_CYAN='\033[38;2;0;255;255m'
RGB_ORANGE='\033[38;2;255;165;0m'
RGB_PINK='\033[38;2;255;105;180m'
RGB_GOLD='\033[38;2;255;215;0m'
RGB_WHITE='\033[38;2;255;255;255m'
RGB_LIME='\033[38;2;50;205;50m'
RGB_TEAL='\033[38;2;0;128;128m'

# Bold variants
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
RESET='\033[0m'

# ============================================
# RGB RAINBOW FUNCTION
# ============================================

rainbow_text() {
    local text="$1"
    local colors=(
        "38;2;255;0;0"      # Red
        "38;2;255;165;0"    # Orange
        "38;2;255;255;0"    # Yellow
        "38;2;0;255;0"      # Green
        "38;2;0;255;255"    # Cyan
        "38;2;0;0;255"      # Blue
        "38;2;255;0;255"    # Purple
    )
    local len=${#text}
    local color_count=${#colors[@]}
    
    for (( i=0; i<len; i++ )); do
        local char="${text:$i:1}"
        local color_idx=$((i % color_count))
        echo -ne "\033[${colors[$color_idx]}m$char"
    done
    echo -e "\033[0m"
}

# ============================================
# BANNER WITH RGB EFFECTS
# ============================================

print_rgb_banner() {
    clear
    
    # RGB animated logo
    local logo=(
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
    
    # Animate each line with rainbow effect
    for line in "${logo[@]}"; do
        rainbow_text "$line"
        echo ""
        sleep 0.08
    done
    
    # Subtitle with glowing effect
    echo -e ""
    echo -e "${BOLD}${RGB_GOLD}   🚗 Car Parking Multiplayer Script Manager v1.0${RESET}"
    echo -e "${DIM}${RGB_CYAN}   ───────────────────────────────────────────────────────${RESET}"
    echo -e ""
}

# ============================================
# LOADING SCREEN WITH PROGRESS BAR
# ============================================

loading_screen() {
    clear
    
    # Animated spinner
    local spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    # Print banner with rainbow
    print_rgb_banner
    
    echo -e "${BOLD}${RGB_CYAN}   ╔═══════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${RGB_CYAN}   ║${RESET}${BOLD}${RGB_WHITE}              INITIALIZING XMB 420...              ${RESET}${BOLD}${RGB_CYAN}║${RESET}"
    echo -e "${BOLD}${RGB_CYAN}   ╚═══════════════════════════════════════════════════╝${RESET}"
    echo -e ""
    
    # Progress bar with RGB gradient
    local total=50
    local modules=("Core" "Network" "Scripts" "Encryption" "UI" "Tools" "Config" "Ready")
    
    for i in $(seq 0 $total); do
        local percent=$((i * 100 / total))
        local filled=$((i * 30 / total))
        local bar=""
        
        # Calculate RGB gradient (red -> yellow -> green -> cyan)
        local r=$((255 - (percent * 255 / 100)))
        local g=$((percent * 255 / 100))
        local b=$((50 - (percent * 50 / 100)))
        if [ $b -lt 0 ]; then b=0; fi
        
        # Build progress bar
        for j in $(seq 1 30); do
            if [ $j -le $filled ]; then
                bar="${bar}█"
            else
                bar="${bar}░"
            fi
        done
        
        # Module name
        local mod_idx=$((i * ${#modules[@]} / total))
        if [ $mod_idx -ge ${#modules[@]} ]; then
            mod_idx=$((${#modules[@]} - 1))
        fi
        local module_name="${modules[$mod_idx]}"
        
        # Spinner animation
        local spin_idx=$((i % ${#spinner[@]}))
        echo -ne "\r   ${spinner[$spin_idx]}  \033[38;2;${r};${g};${b}m[${bar}] ${percent}% - ${module_name}\033[0m"
        
        # Variable speed for realism
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
    
    echo -e ""
    echo -e ""
    echo -e "${BOLD}${RGB_GREEN}   ✅ XMB 420 Ready!${RESET}"
    echo -e "${DIM}${RGB_CYAN}   ───────────────────────────────────────────────────────${RESET}"
    sleep 1
}

# ============================================
# MAIN EXECUTION
# ============================================

# Print banner with RGB animation
print_rgb_banner
sleep 1.5

# Show loading screen with progress
loading_screen

# ============================================
# DEPENDENCY CHECK
# ============================================

echo -e "\n${RGB_BLUE}[*] Checking dependencies...${RESET}"
deps=("curl" "openssl" "lua" "luajit" "git")
missing=()
for dep in "${deps[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo -e "${RGB_YELLOW}[!] Missing: ${missing[*]}${RESET}"
    echo -e "${RGB_BLUE}[*] Installing...${RESET}"
    pkg update -y
    pkg install "${missing[@]}" -y
fi

echo -e "${RGB_GREEN}[✓] All dependencies installed${RESET}"
sleep 1

# ============================================
# CREATE DIRECTORIES
# ============================================

mkdir -p "$HOME/.xmb420/scripts"
mkdir -p "$HOME/.xmb420/encrypted"
mkdir -p "$HOME/.xmb420/downloads"
mkdir -p "$HOME/.xmb420/tools"

# ============================================
# LAUNCH MAIN MENU
# ============================================

echo -e "\n${RGB_CYAN}[*] Launching XMB 420...${RESET}"
sleep 1

lua <(curl -s https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/menu.lua)

exit 0