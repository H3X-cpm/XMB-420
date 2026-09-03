#!/usr/bin/env bash

# XMB 420 - RGB Loading Screen
# GitHub: H3X-cpm/XMB-420

# ============================================
# RGB Colors
# ============================================

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
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
RESET='\033[0m'

clear

# ============================================
# RGB RAINBOW BANNER
# ============================================

rainbow_text() {
    local text="$1"
    local colors=(
        "38;2;255;0;0"
        "38;2;255;165;0"
        "38;2;255;255;0"
        "38;2;0;255;0"
        "38;2;0;255;255"
        "38;2;0;0;255"
        "38;2;255;0;255"
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

# Print animated banner
echo -e "${BOLD}${RGB_CYAN}"
cat << "EOF" | while IFS= read -r line; do
    rainbow_text "$line"
    sleep 0.05
done
  ╔══════════════════════════════════════════════╗
  ║   🚗 XMB 420 - CPM SCRIPT MANAGER           ║
  ║   Loading...                                ║
  ╚══════════════════════════════════════════════╝
EOF

echo -e "${RESET}"

# ============================================
# PROGRESS BAR WITH RGB GRADIENT
# ============================================

echo ""
echo -e "${DIM}${RGB_CYAN}   Initializing modules...${RESET}"
echo ""

total=50
spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
modules=("Core" "Network" "Scripts" "Encryption" "UI" "Tools" "Config" "Ready")

for i in $(seq 0 $total); do
    percent=$((i * 100 / total))
    filled=$((i * 30 / total))
    bar=""
    
    # RGB gradient (red -> yellow -> green -> cyan)
    if [ $percent -lt 25 ]; then
        r=255
        g=$((percent * 10))
        b=0
    elif [ $percent -lt 50 ]; then
        r=$((255 - (percent - 25) * 10))
        g=255
        b=0
    elif [ $percent -lt 75 ]; then
        r=0
        g=255
        b=$(((percent - 50) * 10))
    else
        r=0
        g=$((255 - (percent - 75) * 10))
        b=255
    fi
    
    # Build bar
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
    
    # Spinner
    local spin_idx=$((i % ${#spinner[@]}))
    echo -ne "\r   ${spinner[$spin_idx]}  \033[38;2;${r};${g};${b}m[${bar}] ${percent}% - ${module_name}\033[0m"
    
    # Speed
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
echo -e "${BOLD}${RGB_GREEN}   ✅ XMB 420 Ready!${RESET}"
echo -e "${DIM}${RGB_CYAN}   ────────────────────────────────────────${RESET}"
sleep 1