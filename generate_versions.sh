#!/usr/bin/env bash

# Generate folder structure for all CPM versions

versions=("4.9.10" "4.9.11" "4.9.12" "4.9.13" "5.0.0" "5.1.0" "5.2.0" "5.3.0")
scripts=("money" "speed" "unlock" "gems" "noclip" "xp" "upgrades" "aim")

for version in "${versions[@]}"; do
    mkdir -p "scripts/$version"
    
    # Create version menu
    cat > "scripts/$version/menu.lua" << 'EOF'
-- XMB 420 - Script Download Menu
-- Car Parking Multiplayer vVERSION

local version = arg[1] or "VERSION"

local function clearScreen()
    os.execute("clear")
end

local function printHeader()
    local colors = {
        reset = "\27[0m",
        cyan = "\27[36m",
        yellow = "\27[33m",
        green = "\27[32m",
        blue = "\27[34m",
        red = "\27[31m",
        bold = "\27[1m"
    }
    
    clearScreen()
    print(colors.cyan .. colors.bold .. [[
    ╔══════════════════════════════════════════════╗
    ║   CPM SCRIPTS - Version VERSION             ║
    ╚══════════════════════════════════════════════╝
    ]] .. colors.reset)
    
    print(colors.yellow .. "  ────────────────────────────────────────" .. colors.reset)
end

local function downloadScript(scriptName)
    local colors = {
        green = "\27[32m",
        yellow = "\27[33m",
        red = "\27[31m",
        reset = "\27[0m"
    }
    
    local url = string.format(
        "https://raw.githubusercontent.com/YOUR_USERNAME/XMB-420/main/scripts/VERSION/%s.lua",
        scriptName
    )
    
    local output = os.getenv("HOME") .. "/.xmb420/downloads/" .. scriptName .. ".lua"
    
    print(colors.yellow .. "[*] Downloading " .. scriptName .. "...\27[0m")
    local cmd = string.format("curl -s '%s' -o '%s'", url, output)
    os.execute(cmd)
    
    local file = io.open(output, "r")
    if file then
        file:close()
        print(colors.green .. "[✓] Downloaded: " .. scriptName .. ".lua\27[0m")
        print(colors.green .. "[✓] Saved to