-- XMB 420 - Script Download Menu
-- Car Parking Multiplayer v4.9.10

local version = arg[1] or "4.9.10"

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
    ║   CPM SCRIPTS - Version ]] .. version .. [[           ║
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
        "https://raw.githubusercontent.com/YOUR_USERNAME/XMB-420/main/scripts/%s/%s.lua",
        version, scriptName
    )
    
    local output = os.getenv("HOME") .. "/.xmb420/downloads/" .. scriptName .. ".lua"
    
    print(colors.yellow .. "[*] Downloading " .. scriptName .. "...\27[0m")
    local cmd = string.format("curl -s '%s' -o '%s'", url, output)
    os.execute(cmd)
    
    -- Check if download succeeded
    local file = io.open(output, "r")
    if file then
        file:close()
        print(colors.green .. "[✓] Downloaded: " .. scriptName .. ".lua\27[0m")
        print(colors.green .. "[✓] Saved to: ~/.xmb420/downloads/\27[0m")
        return true
    else
        print(colors.red .. "[✗] Failed to download: " .. scriptName .. "\27[0m")
        return false
    end
end

local function downloadAllScripts()
    local scripts = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim"}
    
    print("\n" .. "\27[33m[*] Downloading all scripts...\27[0m\n")
    for _, script in ipairs(scripts) do
        downloadScript(script)
        os.execute("sleep 0.2")
    end
    print("\n" .. "\27[32m[✓] All scripts downloaded!\27[0m")
end

local function showVersionMenu()
    local colors = {
        reset = "\27[0m",
        green = "\27[32m",
        yellow = "\27[33m",
        blue = "\27[34m",
        cyan = "\27[36m",
        red = "\27[31m",
        bold = "\27[1m"
    }
    
    printHeader()
    
    print(colors.cyan .. "\n  📌 AVAILABLE SCRIPTS" .. colors.reset)
    print("")
    print("  " .. colors.green .. "1." .. colors.reset .. " 💰 Money Script")
    print("  " .. colors.green .. "2." .. colors.reset .. " 🚀 Speed Script")
    print("  " .. colors.green .. "3." .. colors.reset .. " 🔓 Unlock Script")
    print("  " .. colors.green .. "4." .. colors.reset .. " 💎 Gems Script")
    print("  " .. colors.green .. "5." .. colors.reset .. " 🏎️  No Clip Script")
    print("  " .. colors.green .. "6." .. colors.reset .. " 📈 XP Script")
    print("  " .. colors.green .. "7." .. colors.reset .. " 🔧 Upgrades Script")
    print("  " .. colors.green .. "8." .. colors.reset .. " 🎯 Aim Script")
    print("")
    print(colors.cyan .. "  📦 BATCH ACTIONS" .. colors.reset)
    print("")
    print("  " .. colors.green .. "9." .. colors.reset .. " ⬇️  Download All Scripts")
    print("  " .. colors.green .. "10." .. colors.reset .. " 🔐 Encrypt All Downloaded Scripts")
    print("")
    print(colors.yellow .. "  🔙 BACK" .. colors.reset)
    print("  " .. colors.red .. "0." .. colors.reset .. " Return to Main Menu")
    print("")
    print(colors.yellow .. "  ────────────────────────────────────────" .. colors.reset)
    io.write(colors.blue .. "  ➜ Choose script: " .. colors.reset)
end

-- Main loop for version menu
while true do
    showVersionMenu()
    local choice = io.read()
    
    local scripts = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim"}
    
    if tonumber(choice) and tonumber(choice) >= 1 and tonumber(choice) <= 8 then
        local script = scripts[tonumber(choice)]
        clearScreen()
        printHeader()
        print("\n" .. "\27[36m[!] Selected: " .. script .. "\27[0m\n")
        
        print("  " .. "\27[32m1.\27[0m Download Script")
        print("  " .. "\27[32m2.\27[0m Download & Encrypt")
        print("  " .. "\27[31m0.\27[0m Back")
        io.write("\n\27[34m  ➜ Choose action: \27[0m")
        
        local action = io.read()
        if action == "1" then
            downloadScript(script)
        elseif action == "2" then
            if downloadScript(script) then
                local key = "XMB420_" .. os.date("%Y%m%d")
                local input = os.getenv("HOME") .. "/.xmb420/downloads/" .. script .. ".lua"
                local output = os.getenv("HOME") .. "/.xmb420/encrypted/" .. script .. ".enc"
                local cmd = string.format(
                    "openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s'",
                    input, output, key
                )
                os.execute(cmd)
                print("\27[32m[✓] Encrypted: " .. script .. ".enc\27[0m")
                print("\27[33m[!] Key: " .. key .. "\27[0m")
            end
        end
        
        print("\n\27[36mPress Enter to continue...\27[0m")
        io.read()
        
    elseif choice == "9" then
        downloadAllScripts()
        print("\n\27[36mPress Enter to continue...\27[0m")
        io.read()
        
    elseif choice == "10" then
        print("\n" .. "\27[33m[*] Encrypting all downloaded scripts...\27[0m\n")
        local home = os.getenv("HOME")
        local cmd = string.format(
            "for f in ~/.xmb420/downloads/*.lua; do "
            .. "openssl enc -aes-256-cbc -salt -in \"$f\" -out \"~/.xmb420/encrypted/$(basename $f .lua).enc\" -k 'XMB420_%s'; "
            .. "done",
            os.date("%Y%m%d")
        )
        os.execute(cmd)
        print("\27[32m[✓] All scripts encrypted!\27[0m")
        print("\n\27[36mPress Enter to continue...\27[0m")
        io.read()
        
    elseif choice == "0" then
        clearScreen()
        break
        
    else
        print("\n" .. "\27[31m[✗] Invalid option!\27[0m")
        print("\27[36mPress Enter to continue...\27[0m")
        io.read()
    end
end