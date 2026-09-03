-- XMB 420 - CPM Script Manager
-- Car Parking Multiplayer 1 - Version 4.9.10
-- GitHub: H3X-cpm/XMB-420
-- Version: v2.9

local version = arg[1] or "4.9.10"
local XMB_VERSION = "v2.9"

local function clearScreen()
    os.execute("clear")
end

-- RGB Color definitions
local colors = {
    reset = "\27[0m",
    bold = "\27[1m",
    dim = "\27[2m",
    blink = "\27[5m",
    
    red = "\27[31m",
    green = "\27[32m",
    yellow = "\27[33m",
    blue = "\27[34m",
    purple = "\27[35m",
    cyan = "\27[36m",
    white = "\27[37m",
    
    rgb_red = "\27[38;2;255;0;0m",
    rgb_green = "\27[38;2;0;255;0m",
    rgb_blue = "\27[38;2;0;0;255m",
    rgb_yellow = "\27[38;2;255;255;0m",
    rgb_purple = "\27[38;2;255;0;255m",
    rgb_cyan = "\27[38;2;0;255;255m",
    rgb_orange = "\27[38;2;255;165;0m",
    rgb_pink = "\27[38;2;255;105;180m",
    rgb_gold = "\27[38;2;255;215;0m",
    rgb_white = "\27[38;2;255;255;255m",
    rgb_lime = "\27[38;2;50;205;50m",
    rgb_teal = "\27[38;2;0;128;128m",
    rgb_coral = "\27[38;2;255;127;80m",
}

local function printRainbow(text)
    local rainbow_colors = {
        "\27[38;2;255;0;0m",
        "\27[38;2;255;165;0m",
        "\27[38;2;255;255;0m",
        "\27[38;2;0;255;0m",
        "\27[38;2;0;255;255m",
        "\27[38;2;0;0;255m",
        "\27[38;2;255;0;255m",
    }
    
    for i = 1, #text do
        local char = text:sub(i, i)
        local color_idx = ((i - 1) % #rainbow_colors) + 1
        io.write(rainbow_colors[color_idx] .. char)
    end
    io.write(colors.reset)
end

local function printHeader()
    clearScreen()
    
    local logo_lines = {
        "  ╔══════════════════════════════════════════════╗",
        "  ║   CPM SCRIPTS - Version " .. version .. "           ║",
        "  ╚══════════════════════════════════════════════╝",
    }
    
    for _, line in ipairs(logo_lines) do
        printRainbow(line)
        print("")
    end
    
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
end

-- Function to download any script
local function downloadScript(scriptName)
    local colors = {
        green = "\27[32m",
        yellow = "\27[33m",
        red = "\27[31m",
        cyan = "\27[36m",
        gold = "\27[38;2;255;215;0m",
        reset = "\27[0m"
    }
    
    local url = string.format("https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/scripts/%s/%s.lua", version, scriptName)
    local output = os.getenv("HOME") .. "/.xmb420/downloads/" .. scriptName .. ".lua"
    
    print(colors.yellow .. "[*] Downloading " .. scriptName .. "...\27[0m")
    local cmd = string.format("curl -s '%s' -o '%s'", url, output)
    os.execute(cmd)
    
    local file = io.open(output, "r")
    if file then
        file:close()
        print(colors.green .. "[✓] Downloaded: " .. scriptName .. ".lua\27[0m")
        print(colors.cyan .. "[✓] Saved to: ~/.xmb420/downloads/\27[0m")
        
        -- Special message for encrypted scripts
        if scriptName == "SeKoPrimeCP1-2" then
            print(colors.gold .. "[!] This script is encrypted (protected by developer)\27[0m")
            print(colors.gold .. "[!] Use as-is - do not modify\27[0m")
        end
        return true
    else
        print(colors.red .. "[✗] Failed to download: " .. scriptName .. "\27[0m")
        return false
    end
end

-- Function to check if script is downloaded
local function isScriptDownloaded(scriptName)
    local path = os.getenv("HOME") .. "/.xmb420/downloads/" .. scriptName .. ".lua"
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Function to get script info
local function getScriptInfo(scriptName)
    local info = {
        money = { name = "Money Script", icon = "💰", desc = "Unlimited currency" },
        speed = { name = "Speed Script", icon = "🚀", desc = "Boost vehicle speed" },
        unlock = { name = "Unlock Script", icon = "🔓", desc = "Unlock all cars" },
        gems = { name = "Gems Script", icon = "💎", desc = "Unlimited gems" },
        noclip = { name = "No Clip Script", icon = "🏎️", desc = "Drive through walls" },
        xp = { name = "XP Script", icon = "📈", desc = "XP multiplier" },
        upgrades = { name = "Upgrades Script", icon = "🔧", desc = "All upgrades" },
        aim = { name = "Aim Script", icon = "🎯", desc = "Auto-aim assist" },
        SeKoPrimeCP1-2 = { name = "SeKoPrimeCP1-2", icon = "🔥", desc = "Encrypted - Premium features" },
    }
    return info[scriptName] or { name = scriptName, icon = "📄", desc = "" }
end

local function downloadAllScripts()
    local scripts = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim", "SeKoPrimeCP1-2"}
    
    print("\n" .. "\27[33m[*] Downloading all scripts...\27[0m\n")
    for _, script in ipairs(scripts) do
        downloadScript(script)
        os.execute("sleep 0.2")
    end
    print("\n" .. "\27[32m[✓] All scripts downloaded!\27[0m")
end

local function showVersionMenu()
    printHeader()
    print(colors.rgb_cyan .. "\n  📌 AVAILABLE SCRIPTS" .. colors.reset)
    print("")
    
    local scripts = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim", "SeKoPrimeCP1-2"}
    
    for i, script in ipairs(scripts) do
        local info = getScriptInfo(script)
        local status = ""
        if isScriptDownloaded(script) then
            status = colors.rgb_green .. "✅" .. colors.reset
        else
            status = colors.rgb_red .. "❌" .. colors.reset
        end
        print("  " .. colors.rgb_green .. string.format("%2d.", i) .. colors.reset .. " " .. info.icon .. " " .. info.name)
        print("      " .. colors.dim .. info.desc .. " " .. status .. colors.reset)
    end
    
    print("")
    print(colors.rgb_cyan .. "  📦 BATCH ACTIONS" .. colors.reset)
    print("")
    print("  " .. colors.rgb_green .. "10." .. colors.reset .. " ⬇️  Download All Scripts")
    print("  " .. colors.rgb_green .. "11." .. colors.reset .. " 🔐 Encrypt Downloaded Scripts")
    print("  " .. colors.rgb_green .. "12." .. colors.reset .. " 📂 View Downloaded Scripts")
    print("")
    print(colors.rgb_yellow .. "  🔙 BACK" .. colors.reset)
    print("  " .. colors.rgb_red .. "0." .. colors.reset .. " Return to Main Menu")
    print("")
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    -- Show download status
    print(colors.rgb_cyan .. "  📊 Download Status:" .. colors.reset)
    local downloaded_count = 0
    for _, script in ipairs(scripts) do
        if isScriptDownloaded(script) then
            print("    " .. colors.rgb_green .. "✅" .. colors.reset .. " " .. script .. ".lua")
            downloaded_count = downloaded_count + 1
        else
            print("    " .. colors.rgb_red .. "❌" .. colors.reset .. " " .. script .. ".lua")
        end
    end
    print("")
    print("    " .. colors.rgb_green .. "Downloaded: " .. downloaded_count .. "/9 scripts" .. colors.reset)
    if downloaded_count == 9 then
        print("    " .. colors.rgb_gold .. "🎉 All scripts downloaded!\27[0m")
    end
    print("")
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    io.write(colors.rgb_blue .. "  ➜ Choose option: " .. colors.reset)
end

local scripts = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim", "SeKoPrimeCP1-2"}

while true do
    showVersionMenu()
    local choice = io.read()
    
    if tonumber(choice) and tonumber(choice) >= 1 and tonumber(choice) <= 9 then
        local script = scripts[tonumber(choice)]
        local info = getScriptInfo(script)
        clearScreen()
        printHeader()
        print("\n" .. colors.rgb_cyan .. "[!] Selected: " .. info.icon .. " " .. info.name .. "\27[0m")
        print("    " .. colors.dim .. info.desc .. "\27[0m\n")
        
        local isDownloaded = isScriptDownloaded(script)
        
        if isDownloaded then
            print(colors.rgb_green .. "[✓] Already downloaded!\27[0m")
            print("")
            print("  " .. colors.rgb_green .. "1." .. colors.reset .. " Re-download Script")
            print("  " .. colors.rgb_green .. "2." .. colors.reset .. " Encrypt Script")
            
            -- Only show view for non-encrypted scripts
            if script ~= "SeKoPrimeCP1-2" then
                print("  " .. colors.rgb_green .. "3." .. colors.reset .. " View Script Content")
            else
                print("  " .. colors.rgb_gold .. "   (Script is encrypted - cannot view)\27[0m")
            end
            
            print("  " .. colors.rgb_red .. "0." .. colors.reset .. " Back")
        else
            print(colors.rgb_yellow .. "[!] Not downloaded yet\27[0m")
            print("")
            print("  " .. colors.rgb_green .. "1." .. colors.reset .. " Download Script")
            print("  " .. colors.rgb_green .. "2." .. colors.reset .. " Download & Encrypt")
            print("  " .. colors.rgb_red .. "0." .. colors.reset .. " Back")
        end
        
        io.write("\n" .. colors.rgb_blue .. "  ➜ Choose action: " .. colors.reset)
        
        local action = io.read()
        if action == "1" then
            if downloadScript(script) then
                print(colors.rgb_green .. "[✓] Script ready!\27[0m")
            end
        elseif action == "2" then
            if downloadScript(script) then
                local key = "XMB420_" .. os.date("%Y%m%d")
                local input = os.getenv("HOME") .. "/.xmb420/downloads/" .. script .. ".lua"
                local output = os.getenv("HOME") .. "/.xmb420/encrypted/" .. script .. ".enc"
                local cmd = string.format("openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s'", input, output, key)
                os.execute(cmd)
                print(colors.rgb_green .. "[✓] Encrypted: " .. script .. ".enc\27[0m")
                print(colors.rgb_gold .. "[!] Key: " .. key .. "\27[0m")
            end
        elseif action == "3" and script ~= "SeKoPrimeCP1-2" then
            local path = os.getenv("HOME") .. "/.xmb420/downloads/" .. script .. ".lua"
            print("\n" .. colors.rgb_cyan .. "[!] Script contents:\27[0m\n")
            print(colors.dim .. string.rep("─", 40) .. colors.reset)
            os.execute("cat " .. path .. " 2>/dev/null || echo '  File not found'")
            print(colors.dim .. string.rep("─", 40) .. colors.reset)
        end
        
        print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        
    elseif choice == "10" then
        downloadAllScripts()
        print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        
    elseif choice == "11" then
        print("\n" .. "\27[33m[*] Encrypting downloaded scripts...\27[0m\n")
        local home = os.getenv("HOME")
        local encrypted_count = 0
        for _, script in ipairs(scripts) do
            if isScriptDownloaded(script) then
                local input = home .. "/.xmb420/downloads/" .. script .. ".lua"
                local output = home .. "/.xmb420/encrypted/" .. script .. ".enc"
                local key = "XMB420_" .. os.date("%Y%m%d")
                local cmd = string.format("openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s' 2>/dev/null", input, output, key)
                os.execute(cmd)
                print(colors.rgb_green .. "[✓] Encrypted: " .. script .. "\27[0m")
                encrypted_count = encrypted_count + 1
            else
                print(colors.rgb_yellow .. "[!] Skipped: " .. script .. " (not downloaded)\27[0m")
            end
        end
        print("\n" .. colors.rgb_green .. "[✓] Encrypted " .. encrypted_count .. " scripts!\27[0m")
        print(colors.rgb_gold .. "[!] Keys: XMB420_" .. os.date("%Y%m%d") .. "\27[0m")
        print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        
    elseif choice == "12" then
        clearScreen()
        printHeader()
        print("\n" .. colors.rgb_yellow .. "[!] DOWNLOADED SCRIPTS\27[0m\n")
        print(colors.rgb_cyan .. "  Location: ~/.xmb420/downloads/\27[0m\n")
        os.execute("ls -la ~/.xmb420/downloads/ | grep -E '\\.(lua)$' || echo '  No scripts found'")
        print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        
    elseif choice == "0" then
        clearScreen()
        break
        
    else
        print("\n" .. colors.rgb_red .. "[✗] Invalid option!\27[0m")
        print(colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
    end
end
