-- XMB 420 - Main Menu
-- Car Parking Multiplayer Script Manager
-- Version: v2.9
-- GitHub: H3X-cpm/XMB-420

local XMB_VERSION = "v2.9"
local XMB_RELEASE = "September 2026"
local XMB_AUTHOR = "H3X-cpm"

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
    rgb_lavender = "\27[38;2;230;230;250m",
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
        "  ██╗  ██╗███╗   ███╗██████╗  █████╗  █████╗  ██████╗ ",
        "  ╚██╗██╔╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗╚════██╗",
        "   ╚███╔╝ ██╔████╔██║██████╔╝███████║███████║ █████╔╝",
        "   ██╔██╗ ██║╚██╔╝██║██╔══██╗██╔══██║██╔══██║ ╚═══██╗",
        "  ██╔╝ ██╗██║ ╚═╝ ██║██████╔╝██║  ██║██║  ██║██████╔╝",
        "  ╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ",
        "                                                    ",
        "  ██████╗  █████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗",
        "  ██╔══██╗██╔══██╗██╔══██╗██║  ██║██║████╗  ██║██╔════╝",
        "  ██████╔╝███████║██████╔╝███████║██║██╔██╗ ██║██║  ███╗",
        "  ██╔═══╝ ██╔══██║██╔══██╗██╔══██║██║██║╚██╗██║██║   ██║",
        "  ██║     ██║  ██║██║  ██║██║  ██║██║██║ ╚████║╚██████╔╝",
        "  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ",
    }
    
    for _, line in ipairs(logo_lines) do
        printRainbow(line)
        print("")
    end
    
    print("")
    print(colors.bold .. colors.rgb_gold .. "   🚗 Car Parking Multiplayer Script Manager " .. XMB_VERSION .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "   ───────────────────────────────────────────────────────" .. colors.reset)
    print(colors.dim .. colors.rgb_teal .. "   Release: " .. XMB_RELEASE .. " | Author: " .. XMB_AUTHOR .. colors.reset)
    print("")
end

local function listDownloadedScripts()
    print(colors.rgb_cyan .. "\n  📂 Downloaded Scripts:" .. colors.reset)
    print("")
    
    local home = os.getenv("HOME")
    local script_dir = home .. "/.xmb420/downloads/"
    local cmd = "ls -1 " .. script_dir .. "*.lua 2>/dev/null"
    local handle = io.popen(cmd)
    local scripts = {}
    
    if handle then
        for line in handle:lines() do
            table.insert(scripts, line)
        end
        handle:close()
    end
    
    if #scripts == 0 then
        print("  " .. colors.rgb_yellow .. "No scripts found in downloads folder" .. colors.reset)
        print("  " .. colors.dim .. "Scripts will download from GitHub when you select option 1" .. colors.reset)
    else
        for i, script in ipairs(scripts) do
            local name = script:match("([^/]+)%.lua$")
            print("  " .. colors.rgb_green .. string.format("%2d.", i) .. colors.reset .. " " .. name .. ".lua")
        end
        print("")
        print("  " .. colors.rgb_green .. "Total: " .. #scripts .. " scripts" .. colors.reset)
    end
    
    print("")
end

local function showMainMenu()
    printHeader()
    
    print(colors.bold .. colors.rgb_cyan .. "\n  📦 MAIN MENU" .. colors.reset)
    print("")
    print("  " .. colors.rgb_green .. "1." .. colors.reset .. " 📥 Download CPM Scripts from GitHub")
    print("  " .. colors.rgb_green .. "2." .. colors.reset .. " 📂 View Downloaded Scripts")
    print("  " .. colors.rgb_green .. "3." .. colors.reset .. " 🔐 Encrypt Your Own Lua Script")
    print("  " .. colors.rgb_green .. "4." .. colors.reset .. " 🔓 Decrypt Lua Script")
    print("  " .. colors.rgb_green .. "5." .. colors.reset .. " 📁 View Encrypted Scripts")
    print("  " .. colors.rgb_green .. "6." .. colors.reset .. " ⚙️  Settings")
    print("  " .. colors.rgb_gold .. "7." .. colors.reset .. " 🐍 CPM Cheats (Python)")
    print("  " .. colors.rgb_pink .. "8." .. colors.reset .. " 🔥 Modded CPM APKs (Coming Soon)")
    print("  " .. colors.rgb_gold .. "9." .. colors.reset .. " 💎 Premium Scripts")
    print("  " .. colors.rgb_green .. "10." .. colors.reset .. " ℹ️  About")
    print("  " .. colors.rgb_red .. "0." .. colors.reset .. " 🚪 Exit")
    print("")
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    
    listDownloadedScripts()
    
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    io.write(colors.bold .. colors.rgb_blue .. "  ➜ Choose option: " .. colors.reset)
end

-- FUNCTION: Download CPM Scripts from GitHub
local function downloadScripts()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] DOWNLOAD CPM SCRIPTS FROM GITHUB" .. colors.reset .. "\n")
    
    print(colors.rgb_cyan .. "  Available Versions:" .. colors.reset)
    print("")
    print("  " .. colors.rgb_green .. "1." .. colors.reset .. " Version 4.9.10")
    print("  " .. colors.rgb_green .. "2." .. colors.reset .. " Version 4.9.11")
    print("  " .. colors.rgb_green .. "3." .. colors.reset .. " Version 4.9.12")
    print("  " .. colors.rgb_green .. "4." .. colors.reset .. " Version 4.9.13")
    print("  " .. colors.rgb_green .. "5." .. colors.reset .. " Version 5.0.0")
    print("  " .. colors.rgb_green .. "6." .. colors.reset .. " Version 5.1.0")
    print("  " .. colors.rgb_green .. "7." .. colors.reset .. " Version 5.2.0")
    print("  " .. colors.rgb_green .. "8." .. colors.reset .. " Version 5.3.0")
    print("  " .. colors.rgb_green .. "9." .. colors.reset .. " " .. colors.rgb_cyan .. "Custom Version" .. colors.reset)
    print("  " .. colors.rgb_red .. "0." .. colors.reset .. " Back")
    print("")
    io.write(colors.rgb_blue .. "  Select version: " .. colors.reset)
    
    local choice = io.read()
    local version = ""
    
    local versions = {
        "4.9.10", "4.9.11", "4.9.12", "4.9.13",
        "5.0.0", "5.1.0", "5.2.0", "5.3.0"
    }
    
    if tonumber(choice) and tonumber(choice) >= 1 and tonumber(choice) <= 8 then
        version = versions[tonumber(choice)]
    elseif choice == "9" then
        io.write(colors.rgb_cyan .. "  Enter version (e.g., 4.9.10): " .. colors.reset)
        version = io.read()
    elseif choice == "0" then
        return
    else
        print(colors.rgb_red .. "[✗] Invalid choice!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    
    if version == "" then
        print(colors.rgb_red .. "[✗] Invalid version!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    
    print("\n" .. colors.rgb_yellow .. "[*] Downloading scripts for version " .. version .. "..." .. colors.reset)
    
    local script_names = {"money", "speed", "unlock", "gems", "noclip", "xp", "upgrades", "aim", "SeKoPrimeCP1-2"}
    local home = os.getenv("HOME")
    local download_dir = home .. "/.xmb420/downloads/"
    local count = 0
    
    for _, script in ipairs(script_names) do
        local url = string.format(
            "https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/scripts/%s/%s.lua",
            version, script
        )
        local output = download_dir .. script .. ".lua"
        
        print("   " .. colors.rgb_cyan .. "⬇" .. colors.reset .. " Downloading " .. script .. ".lua...")
        local cmd = string.format("curl -s '%s' -o '%s'", url, output)
        os.execute(cmd)
        
        local file = io.open(output, "r")
        if file then
            file:close()
            print("   " .. colors.rgb_green .. "✓" .. colors.reset .. " Downloaded: " .. script .. ".lua")
            count = count + 1
        else
            print("   " .. colors.rgb_red .. "✗" .. colors.reset .. " Failed: " .. script .. ".lua")
        end
        os.execute("sleep 0.1")
    end
    
    print("")
    print(colors.rgb_green .. "[✓] Downloaded " .. count .. " scripts for version " .. version .. colors.reset)
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: View Downloaded Scripts
local function viewDownloaded()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] DOWNLOADED SCRIPTS" .. colors.reset .. "\n")
    print(colors.rgb_cyan .. "  Location: ~/.xmb420/downloads/" .. colors.reset .. "\n")
    
    local home = os.getenv("HOME")
    local script_dir = home .. "/.xmb420/downloads/"
    
    local cmd = "ls -la " .. script_dir .. "*.lua 2>/dev/null || echo '  No scripts found'"
    os.execute(cmd)
    
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: View Encrypted Scripts
local function viewEncrypted()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] ENCRYPTED SCRIPTS" .. colors.reset .. "\n")
    print(colors.rgb_cyan .. "  Location: ~/.xmb420/encrypted/" .. colors.reset .. "\n")
    
    local home = os.getenv("HOME")
    local script_dir = home .. "/.xmb420/encrypted/"
    
    local cmd = "ls -la " .. script_dir .. "*.enc 2>/dev/null || echo '  No encrypted files found'"
    os.execute(cmd)
    
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Encrypt Lua Script
local function encryptScript()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] ENCRYPT LUA SCRIPT" .. colors.reset .. "\n")
    
    print(colors.rgb_cyan .. "  Options:" .. colors.reset)
    print("  " .. colors.rgb_green .. "1." .. colors.reset .. " Encrypt local script")
    print("  " .. colors.rgb_green .. "2." .. colors.reset .. " Encrypt downloaded script")
    print("  " .. colors.rgb_green .. "3." .. colors.reset .. " Encrypt SeKoPrimeCP1-2 script")
    print("  " .. colors.rgb_red .. "0." .. colors.reset .. " Back")
    print("")
    io.write(colors.rgb_blue .. "  Choose: " .. colors.reset)
    
    local choice = io.read()
    local input_file = ""
    
    if choice == "1" then
        io.write("\n  Enter Lua file path: ")
        input_file = io.read()
    elseif choice == "2" then
        print("\n  " .. colors.rgb_cyan .. "Downloaded scripts:" .. colors.reset)
        os.execute("ls -la ~/.xmb420/downloads/*.lua 2>/dev/null || echo '  No scripts found'")
        print("")
        io.write("  Enter filename (e.g., money.lua): ")
        input_file = os.getenv("HOME") .. "/.xmb420/downloads/" .. io.read()
    elseif choice == "3" then
        input_file = os.getenv("HOME") .. "/.xmb420/downloads/SeKoPrimeCP1-2.lua"
        print("\n  " .. colors.rgb_cyan .. "Encrypting SeKoPrimeCP1-2.lua" .. colors.reset)
        local file = io.open(input_file, "r")
        if not file then
            print(colors.rgb_red .. "[✗] SeKoPrimeCP1-2.lua not found! Download it first." .. colors.reset)
            print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
            io.read()
            return
        end
        file:close()
    elseif choice == "0" then
        return
    else
        print(colors.rgb_red .. "[✗] Invalid choice!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    
    local file = io.open(input_file, "r")
    if not file then
        print(colors.rgb_red .. "[✗] File not found: " .. input_file .. colors.reset)
        print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        return
    end
    file:close()
    
    io.write("  Enter output name (e.g., script.enc): ")
    local output_file = io.read()
    if output_file == "" then
        output_file = input_file:gsub("%.lua$", "") .. ".enc"
    end
    
    io.write("  Enter encryption key (or press Enter for default): ")
    local key = io.read()
    if key == "" then
        key = "XMB420_" .. os.date("%Y%m%d")
    end
    
    print("\n" .. colors.rgb_yellow .. "[*] Encrypting..." .. colors.reset)
    local cmd = string.format(
        "openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s'",
        input_file, output_file, key
    )
    os.execute(cmd)
    
    local home = os.getenv("HOME")
    os.execute(string.format("mv '%s' '%s/.xmb420/encrypted/' 2>/dev/null", output_file, home))
    
    print(colors.rgb_green .. "[✓] Encrypted successfully!" .. colors.reset)
    print(colors.rgb_cyan .. "[!] File saved to: ~/.xmb420/encrypted/" .. output_file .. colors.reset)
    print(colors.rgb_gold .. "[!] Key: " .. key .. colors.reset)
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Decrypt Script
local function decryptScript()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] DECRYPT LUA SCRIPT" .. colors.reset .. "\n")
    
    print(colors.rgb_cyan .. "  Encrypted files:" .. colors.reset)
    os.execute("ls -la ~/.xmb420/encrypted/*.enc 2>/dev/null || echo '  No encrypted files found'")
    print("")
    
    io.write("  Enter encrypted file path: ")
    local input_file = io.read()
    
    if input_file == "" then
        return
    end
    
    local file = io.open(input_file, "r")
    if not file then
        print(colors.rgb_red .. "[✗] File not found!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    file:close()
    
    io.write("  Enter output name (e.g., decrypted.lua): ")
    local output_file = io.read()
    if output_file == "" then
        output_file = input_file:gsub("%.enc$", "") .. "_decrypted.lua"
    end
    
    io.write("  Enter decryption key: ")
    local key = io.read()
    
    print("\n" .. colors.rgb_yellow .. "[*] Decrypting..." .. colors.reset)
    local cmd = string.format(
        "openssl enc -aes-256-cbc -d -salt -in '%s' -out '%s' -k '%s'",
        input_file, output_file, key
    )
    local result = os.execute(cmd)
    
    if result then
        print(colors.rgb_green .. "[✓] Decrypted successfully!" .. colors.reset)
        print(colors.rgb_cyan .. "[!] File saved to: " .. output_file .. colors.reset)
    else
        print(colors.rgb_red .. "[✗] Decryption failed! Wrong key?" .. colors.reset)
    end
    
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Settings
local function settings()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] SETTINGS" .. colors.reset .. "\n")
    
    print("  " .. colors.rgb_green .. "1." .. colors.reset .. " Change Default Encryption Key")
    print("  " .. colors.rgb_green .. "2." .. colors.reset .. " Set GitHub Username")
    print("  " .. colors.rgb_green .. "3." .. colors.reset .. " Clear Downloaded Scripts")
    print("  " .. colors.rgb_green .. "4." .. colors.reset .. " Back")
    print("")
    io.write(colors.rgb_blue .. "  Choose: " .. colors.reset)
    
    local choice = io.read()
    
    if choice == "1" then
        io.write("  Enter new default key: ")
        local key = io.read()
        local file = io.open(os.getenv("HOME") .. "/.xmb420_config.lua", "w")
        if file then
            file:write("return { default_key = '" .. key .. "' }\n")
            file:close()
            print(colors.rgb_green .. "[✓] Key saved!" .. colors.reset)
        end
    elseif choice == "2" then
        io.write("  Enter GitHub username: ")
        local user = io.read()
        local file = io.open(os.getenv("HOME") .. "/.xmb420_config.lua", "a")
        if file then
            file:write("  github_user = '" .. user .. "',\n")
            file:close()
            print(colors.rgb_green .. "[✓] Username saved!" .. colors.reset)
        end
    elseif choice == "3" then
        print(colors.rgb_yellow .. "[*] Clearing downloaded scripts..." .. colors.reset)
        os.execute("rm -rf ~/.xmb420/downloads/*")
        print(colors.rgb_green .. "[✓] Cleared!" .. colors.reset)
    end
    
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: CPM Cheats (Python Tools)
local function cpmCheats()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_gold .. "[!] CPM CHEATS (PYTHON)" .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    print(colors.rgb_yellow .. "[*] Checking Python installation..." .. colors.reset)
    local python_check = os.execute("command -v python3 >/dev/null 2>&1")
    if python_check ~= 0 then
        print(colors.rgb_red .. "[✗] Python3 is not installed!" .. colors.reset)
        print("")
        print(colors.rgb_yellow .. "[*] Install Python with:" .. colors.reset)
        print("  pkg install python python-pip -y")
        print("")
        print(colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        return
    end
    print(colors.rgb_green .. "[✓] Python3 is installed" .. colors.reset)
    
    print(colors.rgb_yellow .. "[*] Installing Python dependencies..." .. colors.reset)
    os.execute("pip3 install requests colorama > /dev/null 2>&1")
    print(colors.rgb_green .. "[✓] Dependencies installed" .. colors.reset)
    print("")
    
    os.execute("mkdir -p ~/.xmb420/tools")
    
    local local_path = os.getenv("HOME") .. "/.xmb420/tools/cpmcheats.py"
    local file_check = io.open(local_path, "r")
    
    if not file_check then
        print(colors.rgb_yellow .. "[*] Downloading CPM Cheats from GitHub..." .. colors.reset)
        print("  Source: Rickdevsolutions/cpm2")
        print("")
        
        local url = "https://raw.githubusercontent.com/Rickdevsolutions/cpm2/main/cpmcheats.py"
        local cmd = string.format("curl -s -L '%s' -o '%s'", url, local_path)
        os.execute(cmd)
        
        local new_check = io.open(local_path, "r")
        if new_check then
            new_check:close()
            print(colors.rgb_green .. "[✓] CPM Cheats downloaded successfully!" .. colors.reset)
            os.execute("chmod +x " .. local_path)
        else
            print(colors.rgb_red .. "[✗] Failed to download CPM Cheats!" .. colors.reset)
            print(colors.rgb_yellow .. "[*] Check your internet connection" .. colors.reset)
            print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
            io.read()
            return
        end
    else
        file_check:close()
        print(colors.rgb_green .. "[✓] CPM Cheats already downloaded!" .. colors.reset)
        
        print(colors.rgb_yellow .. "[*] Checking for updates..." .. colors.reset)
        local url = "https://raw.githubusercontent.com/Rickdevsolutions/cpm2/main/cpmcheats.py"
        local temp_path = os.getenv("HOME") .. "/.xmb420/tools/cpmcheats_temp.py"
        local cmd = string.format("curl -s -L '%s' -o '%s'", url, temp_path)
        os.execute(cmd)
        
        local temp_check = io.open(temp_path, "r")
        if temp_check then
            temp_check:close()
            os.execute(string.format("mv '%s' '%s'", temp_path, local_path))
            print(colors.rgb_green .. "[✓] Updated to latest version!" .. colors.reset)
        end
    end
    
    print("")
    print(colors.rgb_green .. "[✓] Ready to launch CPM Cheats!" .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    print(colors.rgb_yellow .. "[*] Launching CPM Cheats..." .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    os.execute("python3 " .. local_path)
    
    print("")
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print(colors.rgb_green .. "[✓] CPM Cheats finished" .. colors.reset)
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Premium Scripts
local function premiumScripts()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_gold .. "[!] 💎 PREMIUM SCRIPTS" .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    print(colors.rgb_gold .. "  ╔══════════════════════════════════════════════════════╗" .. colors.reset)
    print(colors.rgb_gold .. "  ║" .. colors.reset .. colors.bold .. colors.rgb_white .. "              💎 PREMIUM FEATURES                     " .. colors.rgb_gold .. "║" .. colors.reset)
    print(colors.rgb_gold .. "  ╚══════════════════════════════════════════════════════╝" .. colors.reset)
    print("")
    
    print(colors.rgb_cyan .. "  Premium Scripts Available:" .. colors.reset)
    print("")
    print("  " .. colors.rgb_gold .. "1." .. colors.reset .. " 💰 Premium Money Script")
    print("  " .. colors.rgb_gold .. "2." .. colors.reset .. " 🚀 Premium Speed Script")
    print("  " .. colors.rgb_gold .. "3." .. colors.reset .. " 🔓 Premium Unlock Script")
    print("  " .. colors.rgb_gold .. "4." .. colors.reset .. " 🔥 Premium All-in-One Script")
    print("  " .. colors.rgb_gold .. "5." .. colors.reset .. " 🌟 Premium VIP Features")
    print("")
    print(colors.rgb_pink .. "  ╔══════════════════════════════════════════════════════╗" .. colors.reset)
    print(colors.rgb_pink .. "  ║" .. colors.reset .. colors.bold .. colors.rgb_white .. "         📱 HOW TO GET PREMIUM SCRIPTS              " .. colors.rgb_pink .. "║" .. colors.reset)
    print(colors.rgb_pink .. "  ╚══════════════════════════════════════════════════════╝" .. colors.reset)
    print("")
    print(colors.rgb_yellow .. "  To get premium scripts, contact me on Telegram:" .. colors.reset)
    print("")
    print(colors.rgb_cyan .. "  📱 Telegram: @H3X_cpm" .. colors.reset)
    print("  " .. colors.rgb_cyan .. "🔗 Link:" .. colors.reset .. " https://t.me/H3X_cpm")
    print("")
    print(colors.rgb_gold .. "  💰 Pricing:" .. colors.reset)
    print("  • Single Script: $5")
    print("  • Script Pack (5 scripts): $20")
    print("  • VIP Lifetime Access: $50")
    print("")
    print(colors.rgb_green .. "  Payment Methods:" .. colors.reset)
    print("  • PayPal")
    print("  • Crypto (BTC, ETH, USDT)")
    print("  • Gift Cards")
    print("")
    print(colors.rgb_orange .. "  ╔══════════════════════════════════════════════════════╗" .. colors.reset)
    print(colors.rgb_orange .. "  ║" .. colors.reset .. colors.bold .. colors.rgb_white .. "            ⚠️ IMPORTANT NOTICE                      " .. colors.rgb_orange .. "║" .. colors.reset)
    print(colors.rgb_orange .. "  ╚══════════════════════════════════════════════════════╝" .. colors.reset)
    print("")
    print(colors.rgb_red .. "  ❗ Premium scripts are for personal use only" .. colors.reset)
    print(colors.rgb_red .. "  ❗ Do not share or redistribute" .. colors.reset)
    print(colors.rgb_red .. "  ❗ Lifetime updates included" .. colors.reset)
    print(colors.rgb_red .. "  ❗ Support included" .. colors.reset)
    print("")
    print(colors.rgb_cyan .. "  Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Modded CPM APKs
local function moddedAPKs()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_pink .. "[!] MODDED CPM APKs" .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    print(colors.rgb_yellow .. "[!] Coming Soon in Version 3.0!" .. colors.reset)
    print("")
    print(colors.rgb_cyan .. "  Planned Features:" .. colors.reset)
    print("  • Modded CPM 1 APKs")
    print("  • Modded CPM 2 APKs")
    print("  • Auto-Install Support")
    print("  • Version Selection")
    print("  • OBB Download")
    print("  • Unlimited Money Mods")
    print("  • All Cars Unlocked")
    print("")
    print(colors.rgb_gold .. "  Stay tuned for updates!" .. colors.reset)
    print("")
    print(colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: About
local function about()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_gold .. "[!] ABOUT XMB 420" .. colors.reset)
    print("\n  " .. colors.rgb_cyan .. "Version:" .. colors.reset .. " " .. XMB_VERSION)
    print("  " .. colors.rgb_cyan .. "Release:" .. colors.reset .. " " .. XMB_RELEASE)
    print("  " .. colors.rgb_cyan .. "Author:" .. colors.reset .. " " .. XMB_AUTHOR)
    print("  " .. colors.rgb_cyan .. "GitHub:" .. colors.reset .. " https://github.com/H3X-cpm/XMB-420")
    print("\n  " .. colors.rgb_cyan .. "Description:" .. colors.reset)
    print("  Car Parking Multiplayer Script Manager")
    print("  Download pre-made scripts or encrypt your own")
    print("\n  " .. colors.rgb_cyan .. "Features:" .. colors.reset)
    print("  • Download CPM scripts by version from GitHub")
    print("  • AES-256-CBC Encryption")
    print("  • Decrypt your own scripts")
    print("  • Organize scripts by game version")
    print("  • 9 scripts per version including SeKoPrimeCP1-2")
    print("  • CPM Cheats integration (Python)")
    print("  • RGB Animated TUI interface")
    print("  • Social links and donate options")
    print("  • 💎 Premium scripts available via Telegram")
    print("  • Modded CPM APKs (Coming Soon v3.0)")
    print("")
    print("  " .. colors.rgb_cyan .. "CPM Cheats Source:" .. colors.reset)
    print("  https://github.com/Rickdevsolutions/cpm2")
    print("\n  " .. colors.rgb_cyan .. "Social Links:" .. colors.reset)
    print("  • GitHub: https://github.com/H3X-cpm")
    print("  • Twitter: https://twitter.com/H3X_cpm")
    print("  • YouTube: https://youtube.com/@H3X-cpm")
    print("  • Discord: https://discord.gg/H3X-cpm")
    print("  • Telegram: https://t.me/H3X_cpm")
    print("  • Ko-Fi: https://ko-fi.com/H3X-cpm")
    print("  • Patreon: https://patreon.com/H3X-cpm")
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- MAIN LOOP
while true do
    showMainMenu()
    local choice = io.read()
    
    if choice == "1" then
        downloadScripts()
    elseif choice == "2" then
        viewDownloaded()
    elseif choice == "3" then
        encryptScript()
    elseif choice == "4" then
        decryptScript()
    elseif choice == "5" then
        viewEncrypted()
    elseif choice == "6" then
        settings()
    elseif choice == "7" then
        cpmCheats()
    elseif choice == "8" then
        moddedAPKs()
    elseif choice == "9" then
        premiumScripts()
    elseif choice == "10" then
        about()
    elseif choice == "0" then
        clearScreen()
        print(colors.rgb_cyan .. "[!] Goodbye from XMB 420 " .. XMB_VERSION .. "!" .. colors.reset .. "\n")
        os.exit(0)
    else
        print("\n" .. colors.rgb_red .. "[✗] Invalid option!" .. colors.reset)
        print(colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
    end
end