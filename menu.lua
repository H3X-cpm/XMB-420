-- XMB 420 - Main Menu
-- Car Parking Multiplayer Script Manager
-- GitHub: H3X-cpm/XMB-420
-- With RGB Color Support

local function clearScreen()
    os.execute("clear")
end

-- RGB Color definitions
local colors = {
    reset = "\27[0m",
    bold = "\27[1m",
    dim = "\27[2m",
    blink = "\27[5m",
    
    -- Standard colors
    red = "\27[31m",
    green = "\27[32m",
    yellow = "\27[33m",
    blue = "\27[34m",
    purple = "\27[35m",
    cyan = "\27[36m",
    white = "\27[37m",
    
    -- RGB 24-bit colors
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
        "\27[38;2;255;0;0m",      -- Red
        "\27[38;2;255;165;0m",    -- Orange
        "\27[38;2;255;255;0m",    -- Yellow
        "\27[38;2;0;255;0m",      -- Green
        "\27[38;2;0;255;255m",    -- Cyan
        "\27[38;2;0;0;255m",      -- Blue
        "\27[38;2;255;0;255m",    -- Purple
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
    
    -- ASCII Art with RGB colors
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
    print(colors.bold .. colors.rgb_gold .. "   🚗 Car Parking Multiplayer Script Manager v1.0" .. colors.reset)
    print(colors.dim .. colors.rgb_cyan .. "   ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
end

local function showMainMenu()
    printHeader()
    
    print(colors.bold .. colors.rgb_cyan .. "\n  📦 MAIN MENU" .. colors.reset)
    print("")
    print("  " .. colors.rgb_green .. "1." .. colors.reset .. " 📥 Download CPM Scripts from GitHub")
    print("  " .. colors.rgb_green .. "2." .. colors.reset .. " 🔐 Encrypt Your Own Lua Script")
    print("  " .. colors.rgb_green .. "3." .. colors.reset .. " 🔓 Decrypt Lua Script")
    print("  " .. colors.rgb_green .. "4." .. colors.reset .. " 📂 View Downloaded Scripts")
    print("  " .. colors.rgb_green .. "5." .. colors.reset .. " 📁 View Encrypted Scripts")
    print("  " .. colors.rgb_green .. "6." .. colors.reset .. " ⚙️  Settings")
    print("  " .. colors.rgb_gold .. "7." .. colors.reset .. " 🐍 CPM Cheats (Python)")
    print("  " .. colors.rgb_green .. "8." .. colors.reset .. " ℹ️  About")
    print("  " .. colors.rgb_red .. "0." .. colors.reset .. " 🚪 Exit")
    print("")
    print(colors.dim .. colors.rgb_cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    io.write(colors.bold .. colors.rgb_blue .. "  ➜ Choose option: " .. colors.reset)
end

-- FUNCTION: Download CPM Scripts
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
    
    local url = string.format(
        "https://raw.githubusercontent.com/H3X-cpm/XMB-420/main/scripts/%s/menu.lua",
        version
    )
    
    print("\n" .. colors.rgb_yellow .. "[*] Loading scripts for version " .. version .. "..." .. colors.reset)
    os.execute("sleep 1")
    
    local cmd = string.format(
        "lua <(curl -s '%s') '%s'",
        url, version
    )
    os.execute(cmd)
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

-- FUNCTION: View Downloaded Scripts
local function viewDownloaded()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] DOWNLOADED SCRIPTS" .. colors.reset .. "\n")
    print(colors.rgb_cyan .. "  Location: ~/.xmb420/downloads/" .. colors.reset .. "\n")
    os.execute("ls -la ~/.xmb420/downloads/ | grep -E '\\.(lua|enc)$' || echo '  No scripts found'")
    print("\n" .. colors.rgb_cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: View Encrypted Scripts
local function viewEncrypted()
    clearScreen()
    printHeader()
    print("\n" .. colors.rgb_yellow .. "[!] ENCRYPTED SCRIPTS" .. colors.reset .. "\n")
    print(colors.rgb_cyan .. "  Location: ~/.xmb420/encrypted/" .. colors.reset .. "\n")
    os.execute("ls -la ~/.xmb420/encrypted/ | grep '\\.enc