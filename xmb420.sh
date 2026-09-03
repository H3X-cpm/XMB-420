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
# ANSI COLOR CODES WITH RGB SUPPORT
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

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
RGB_CORAL='\033[38;2;255;127;80m'

BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
RESET='\033[0m'

# ============================================
# ANIMATED RGB FUNCTIONS
# ============================================

get_term_size() {
    local cols=$(tput cols 2>/dev/null || echo 80)
    local lines=$(tput lines 2>/dev/null || echo 24)
    echo "$cols $lines"
}

animate_rainbow() {
    local text="$1"
    local delay="${2:-0.02}"
    local cycles="${2:-2}"
    
    local colors=(
        "38;2;255;0;0" "38;2;255;50;0" "38;2;255;100;0" "38;2;255;150;0"
        "38;2;255;200;0" "38;2;255;255;0" "38;2;200;255;0" "38;2;150;255;0"
        "38;2;100;255;0" "38;2;50;255;0" "38;2;0;255;0" "38;2;0;255;50"
        "38;2;0;255;100" "38;2;0;255;150" "38;2;0;255;200" "38;2;0;255;255"
        "38;2;0;200;255" "38;2;0;150;255" "38;2;0;100;255" "38;2;0;50;255"
        "38;2;0;0;255" "38;2;50;0;255" "38;2;100;0;255" "38;2;150;0;255"
        "38;2;200;0;255" "38;2;255;0;255" "38;2;255;0;200" "38;2;255;0;150"
        "38;2;255;0;100" "38;2;255;0;50"
    )
    
    local len=${#text}
    local color_count=${#colors[@]}
    
    for (( cycle=0; cycle<cycles; cycle++ )); do
        for (( start=0; start<len; start++ )); do
            echo -ne "\r\033[K"
            for (( i=0; i<len; i++ )); do
                local char="${text:$i:1}"
                local color_idx=$(((i + start + cycle * 5) % color_count))
                echo -ne "\033[${colors[$color_idx]}m$char"
            done
            echo -ne "\033[0m"
            sleep "$delay"
        done
    done
}

breathing_glow() {
    local text="$1"
    local cycles="${2:-3}"
    
    for (( i=0; i<cycles; i++ )); do
        echo -ne "\r\033[K"
        echo -e "\033[38;2;255;215;0m${text}\033[0m"
        sleep 0.3
        echo -ne "\r\033[K"
        echo -e "\033[38;2;100;80;0m${text}\033[0m"
        sleep 0.3
    done
}

# ============================================
# RESPONSIVE LOGO
# ============================================

print_xmb_logo() {
    local cols=$(tput cols 2>/dev/null || echo 80)
    local lines=$(tput lines 2>/dev/null || echo 24)
    
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
        animate_rainbow "$line" 0.01 1
        echo ""
        sleep 0.05
    done
    
    echo -e ""
    breathing_glow "   🚗 Car Parking Multiplayer Script Manager ${XMB_VERSION}" 3
    echo -e "${DIM}${RGB_CYAN}   ───────────────────────────────────────────────────────${RESET}"
    echo -e ""
}

# ============================================
# ADVANCED LOADING SCREEN
# ============================================

advanced_loading() {
    clear
    print_xmb_logo
    
    local cols=$(tput cols 2>/dev/null || echo 80)
    local center_pad=$(( (cols - 50) / 2 ))
    
    echo -e "${BOLD}${RGB_CYAN}"
    printf "%${center_pad}s" ""
    echo "  ╔══════════════════════════════════════════════════════╗"
    printf "%${center_pad}s" ""
    echo "  ║${BOLD}${RGB_WHITE}              LOADING XMB 420 ${XMB_VERSION}                    ${BOLD}${RGB_CYAN}║"
    printf "%${center_pad}s" ""
    echo "  ╚══════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""
    
    local total=60
    local spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local modules=("Core" "Network" "Scripts" "Encryption" "UI" "Tools" "Config" "Social" "Premium" "Ready")
    
    for i in $(seq 0 $total); do
        local percent=$((i * 100 / total))
        local filled=$((i * 35 / total))
        local bar=""
        
        local hue=$((i * 6))
        local r=$((128 + 127 * (1 + 0.5 * (hue / 360))))
        local g=$((128 + 127 * (1 + 0.5 * ((hue + 120) / 360))))
        local b=$((128 + 127 * (1 + 0.5 * ((hue + 240) / 360))))
        
        for j in $(seq 1 35); do
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
        printf "\r   ${spinner[$spin_idx]}  \033[38;2;${r};${g};${b}m[${bar}] ${percent}%% - ${module_name}\033[0m"
        
        if [ $i -lt 10 ]; then
            sleep 0.15
        elif [ $i -lt 25 ]; then
            sleep 0.08
        elif [ $i -lt 45 ]; then
            sleep 0.05
        else
            sleep 0.03
        fi
    done
    
    echo -e ""
    echo -e ""
    echo -e "${BOLD}${RGB_GREEN}   ✅ XMB 420 ${XMB_VERSION} Successfully Loaded!${RESET}"
    echo -e ""
    
    echo -e "${BOLD}${RGB_GOLD}   ──── CONNECT WITH US ────${RESET}"
    echo -e ""
    echo -e "   ${RGB_CYAN}📱 GitHub:${RESET}   https://github.com/H3X-cpm/XMB-420"
    echo -e "   ${RGB_PINK}🐦 Twitter:${RESET}   https://twitter.com/H3X_cpm"
    echo -e "   ${RGB_PURPLE}📺 YouTube:${RESET}  https://youtube.com/@H3X-cpm"
    echo -e "   ${RGB_ORANGE}💬 Discord:${RESET}  https://discord.gg/H3X-cpm"
    echo -e "   ${RGB_RED}📱 Telegram:${RESET}  https://t.me/H3X_cpm"
    echo -e "   ${RGB_GREEN}☕ Donate:${RESET}    https://ko-fi.com/H3X-cpm"
    echo -e "   ${RGB_CORAL}❤️ Patreon:${RESET}  https://patreon.com/H3X-cpm"
    echo -e "   ${RGB_GOLD}💎 Premium:${RESET}   Contact @H3X_cpm on Telegram"
    
    echo -e ""
    echo -e "${DIM}${RGB_CYAN}   ───────────────────────────────────────────────────────${RESET}"
    sleep 2
}

# ============================================
# DOWNLOAD SCRIPTS FROM GITHUB
# ============================================

download_scripts_from_github() {
    echo -e "\n${RGB_CYAN}[*] Checking for available scripts on GitHub...${RESET}"
    echo ""
    
    local versions=("4.9.10" "4.9.11" "4.9.12" "4.9.13" "5.0.0" "5.1.0" "5.2.0" "5.3.0")
    local script_names=("money" "speed" "unlock" "gems" "noclip" "xp" "upgrades" "aim" "SeKoPrimeCP1-2")
    
    local script_dir="$HOME/.xmb420/downloads"
    mkdir -p "$script_dir"
    
    local total_downloaded=0
    local total_skipped=0
    
    for version in "${versions[@]}"; do
        for script in "${script_names[@]}"; do
            local url="https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/scripts/${version}/${script}.lua"
            local output="${script_dir}/${script}.lua"
            
            if curl -s --head "$url" | head -n 1 | grep -q "200"; then
                if [ ! -f "$output" ]; then
                    echo -e "   ${RGB_YELLOW}⬇${RESET} Downloading ${script}.lua for v${version}..."
                    curl -s "$url" -o "$output"
                    ((total_downloaded++))
                else
                    ((total_skipped++))
                fi
            fi
        done
    done
    
    if [ $total_downloaded -gt 0 ]; then
        echo -e ""
        echo -e "   ${RGB_GREEN}✅ Downloaded ${total_downloaded} new scripts${RESET}"
    fi
    if [ $total_skipped -gt 0 ]; then
        echo -e "   ${RGB_CYAN}ℹ${RESET} ${total_skipped} scripts already exist (skipped)"
    fi
    if [ $total_downloaded -eq 0 ] && [ $total_skipped -eq 0 ]; then
        echo -e "   ${RGB_YELLOW}!${RESET} No scripts found on GitHub"
    fi
    
    echo ""
}

# ============================================
# LIST AVAILABLE SCRIPTS
# ============================================

list_available_scripts() {
    echo -e "\n${RGB_CYAN}[*] Available scripts in downloads folder:${RESET}"
    echo ""
    
    local script_dir="$HOME/.xmb420/downloads"
    if [ -d "$script_dir" ]; then
        local count=0
        for file in "$script_dir"/*.lua; do
            if [ -f "$file" ]; then
                local name=$(basename "$file" .lua)
                echo -e "   ${RGB_GREEN}✓${RESET} $name.lua"
                ((count++))
            fi
        done
        if [ $count -eq 0 ]; then
            echo -e "   ${RGB_YELLOW}!${RESET} No scripts downloaded yet"
            echo -e "   ${RGB_CYAN}ℹ${RESET} Scripts will be downloaded from GitHub when you select option 1"
        else
            echo -e ""
            echo -e "   ${RGB_GREEN}Total: $count scripts${RESET}"
        fi
    else
        echo -e "   ${RGB_YELLOW}!${RESET} Downloads folder not found"
    fi
    
    echo ""
}

# ============================================
# CHECK FOR UPDATES
# ============================================

check_for_updates() {
    echo -e "\n${RGB_CYAN}[*] Checking for XMB 420 updates...${RESET}"
    
    local current_version="${XMB_VERSION}"
    local latest_version=$(curl -s https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/version.txt 2>/dev/null)
    
    if [ -n "$latest_version" ] && [ "$latest_version" != "$current_version" ]; then
        echo -e "   ${RGB_YELLOW}!${RESET} New version available: ${latest_version}"
        echo -e "   ${RGB_CYAN}ℹ${RESET} Current version: ${current_version}"
        echo -e "   ${RGB_GREEN}➜${RESET} Run: bash <(curl -s https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/xmb420.sh)"
    else
        echo -e "   ${RGB_GREEN}✓${RESET} You have the latest version: ${current_version}"
    fi
    
    echo ""
}

# ============================================
# MAIN EXECUTION
# ============================================

# Print version info
echo -e "${BOLD}${RGB_CYAN}XMB 420 ${XMB_VERSION} - ${XMB_RELEASE}${RESET}"
echo -e "${DIM}${RGB_CYAN}Author: ${XMB_AUTHOR}${RESET}"
echo -e ""

print_xmb_logo
sleep 1

advanced_loading

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
mkdir -p "$HOME/.xmb420/paid"

# ============================================
# CHECK FOR UPDATES
# ============================================

check_for_updates

# ============================================
# DOWNLOAD SCRIPTS FROM GITHUB
# ============================================

download_scripts_from_github

# ============================================
# LIST AVAILABLE SCRIPTS
# ============================================

list_available_scripts

# ============================================
# LAUNCH MAIN MENU
# ============================================

echo -e "${RGB_CYAN}[*] Launching XMB 420 ${XMB_VERSION}...${RESET}"
sleep 1

lua <(curl -s https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/menu.lua)

exit 0