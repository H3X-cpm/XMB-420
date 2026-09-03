-- XMB 420 - Main Menu
-- Car Parking Multiplayer Script Manager

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
        purple = "\27[35m",
        red = "\27[31m",
        bold = "\27[1m"
    }
    
    clearScreen()
    print(colors.cyan .. colors.bold .. [[
    ╔══════════════════════════════════════════════╗
    ║   XMB 420 - SCRIPT MANAGER                  ║
    ║   Car Parking Multiplayer                   ║
    ╚══════════════════════════════════════════════╝
    ]] .. colors.reset)
    
    print(colors.yellow .. "  ────────────────────────────────────────" .. colors.reset)
end

local function showMainMenu()
    local colors = {
        reset = "\27[0m",
        green = "\27[32m",
        yellow = "\27[33m",
        blue = "\27[34m",
        cyan = "\27[36m",
        red = "\27[31m",
        bold = "\27[1m",
        purple = "\27[35m"
    }
    
    printHeader()
    
    print(colors.cyan .. "\n  📦 MAIN MENU" .. colors.reset)
    print("")
    print("  " .. colors.green .. "1." .. colors.reset .. " 📥 Download CPM Scripts from GitHub")
    print("  " .. colors.green .. "2." .. colors.reset .. " 🔐 Encrypt Your Own Lua Script")
    print("  " .. colors.green .. "3." .. colors.reset .. " 🔓 Decrypt Lua Script")
    print("  " .. colors.green .. "4." .. colors.reset .. " 📂 View Downloaded Scripts")
    print("  " .. colors.green .. "5." .. colors.reset .. " 📁 View Encrypted Scripts")
    print("  " .. colors.green .. "6." .. colors.reset .. " ⚙️  Settings")
    print("  " .. colors.green .. "7." .. colors.reset .. " ℹ️  About")
    print("  " .. colors.red .. "0." .. colors.reset .. " 🚪 Exit")
    print("")
    print(colors.yellow .. "  ────────────────────────────────────────" .. colors.reset)
    io.write(colors.blue .. "  ➜ Choose option: " .. colors.reset)
end

-- FUNCTION: Download CPM Scripts
local function downloadScripts()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] DOWNLOAD CPM SCRIPTS FROM GITHUB\27[0m\n")
    
    print("\27[36m  Available Versions:\27[0m")
    print("")
    print("  " .. "\27[32m1.\27[0m Version 4.9.10")
    print("  " .. "\27[32m2.\27[0m Version 4.9.11")
    print("  " .. "\27[32m3.\27[0m Version 4.9.12")
    print("  " .. "\27[32m4.\27[0m Version 4.9.13")
    print("  " .. "\27[32m5.\27[0m Version 5.0.0")
    print("  " .. "\27[32m6.\27[0m Version 5.1.0")
    print("  " .. "\27[32m7.\27[0m Version 5.2.0")
    print("  " .. "\27[32m8.\27[0m Version 5.3.0")
    print("  " .. "\27[32m9.\27[0m " .. "\27[36mCustom Version\27[0m")
    print("  " .. "\27[31m0.\27[0m Back")
    print("")
    io.write("\27[34m  Select version: \27[0m")
    
    local choice = io.read()
    local version = ""
    
    local versions = {
        "4.9.10", "4.9.11", "4.9.12", "4.9.13",
        "5.0.0", "5.1.0", "5.2.0", "5.3.0"
    }
    
    if tonumber(choice) and tonumber(choice) >= 1 and tonumber(choice) <= 8 then
        version = versions[tonumber(choice)]
    elseif choice == "9" then
        io.write("\27[36m  Enter version (e.g., 4.9.10): \27[0m")
        version = io.read()
    elseif choice == "0" then
        return
    else
        print("\27[31m[✗] Invalid choice!\27[0m")
        os.execute("sleep 1")
        return
    end
    
    if version == "" then
        print("\27[31m[✗] Invalid version!\27[0m")
        os.execute("sleep 1")
        return
    end
    
    -- Download version-specific menu
    local url = string.format(
        "https://raw.githubusercontent.com/YOUR_USERNAME/XMB-420/main/scripts/%s/menu.lua",
        version
    )
    
    print("\n" .. "\27[33m[*] Loading scripts for version " .. version .. "...\27[0m")
    os.execute("sleep 1")
    
    -- Run the version menu
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
    print("\n" .. "\27[33m[!] ENCRYPT LUA SCRIPT\27[0m\n")
    
    print("\27[36m  Options:\27[0m")
    print("  " .. "\27[32m1.\27[0m Encrypt local script")
    print("  " .. "\27[32m2.\27[0m Encrypt downloaded script")
    print("  " .. "\27[31m0.\27[0m Back")
    print("")
    io.write("\27[34m  Choose: \27[0m")
    
    local choice = io.read()
    local input_file = ""
    
    if choice == "1" then
        io.write("\n  Enter Lua file path: ")
        input_file = io.read()
    elseif choice == "2" then
        print("\n  " .. "\27[36mDownloaded scripts:\27[0m")
        os.execute("ls -la ~/.xmb420/downloads/*.lua 2>/dev/null || echo '  No scripts found'")
        print("")
        io.write("  Enter filename (e.g., money.lua): ")
        input_file = os.getenv("HOME") .. "/.xmb420/downloads/" .. io.read()
    elseif choice == "0" then
        return
    else
        print("\27[31m[✗] Invalid choice!\27[0m")
        os.execute("sleep 1")
        return
    end
    
    -- Check if file exists
    local file = io.open(input_file, "r")
    if not file then
        print("\27[31m[✗] File not found: " .. input_file .. "\27[0m")
        print("\27[36mPress Enter to continue...\27[0m")
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
    
    print("\n" .. "\27[33m[*] Encrypting...\27[0m")
    local cmd = string.format(
        "openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s'",
        input_file, output_file, key
    )
    os.execute(cmd)
    
    -- Move to encrypted folder
    local home = os.getenv("HOME")
    os.execute(string.format("mv '%s' '%s/.xmb420/encrypted/' 2>/dev/null", output_file, home))
    
    print("\27[32m[✓] Encrypted successfully!\27[0m")
    print("\27[36m[!] File saved to: ~/.xmb420/encrypted/" .. output_file .. "\27[0m")
    print("\27[33m[!] Key: " .. key .. "\27[0m")
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- FUNCTION: Decrypt Script
local function decryptScript()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] DECRYPT LUA SCRIPT\27[0m\n")
    
    print("\27[36m  Encrypted files:\27[0m")
    os.execute("ls -la ~/.xmb420/encrypted/*.enc 2>/dev/null || echo '  No encrypted files found'")
    print("")
    
    io.write("  Enter encrypted file path: ")
    local input_file = io.read()
    
    if input_file == "" then
        return
    end
    
    local file = io.open(input_file, "r")
    if not file then
        print("\27[31m[✗] File not found!\27[0m")
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
    
    print("\n" .. "\27[33m[*] Decrypting...\27[0m")
    local cmd = string.format(
        "openssl enc -aes-256-cbc -d -salt -in '%s' -out '%s' -k '%s'",
        input_file, output_file, key
    )
    local result = os.execute(cmd)
    
    if result then
        print("\27[32m[✓] Decrypted successfully!\27[0m")
        print("\27[36m[!] File saved to: " .. output_file .. "\27[0m")
    else
        print("\27[31m[✗] Decryption failed! Wrong key?\27[0m")
    end
    
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- FUNCTION: View Downloaded Scripts
local function viewDownloaded()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] DOWNLOADED SCRIPTS\27[0m\n")
    print("\27[36m  Location: ~/.xmb420/downloads/\27[0m\n")
    os.execute("ls -la ~/.xmb420/downloads/ | grep -E '\\.(lua|enc)$' || echo '  No scripts found'")
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- FUNCTION: View Encrypted Scripts
local function viewEncrypted()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] ENCRYPTED SCRIPTS\27[0m\n")
    print("\27[36m  Location: ~/.xmb420/encrypted/\27[0m\n")
    os.execute("ls -la ~/.xmb420/encrypted/ | grep '\\.enc$' || echo '  No encrypted files found'")
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- FUNCTION: Settings
local function settings()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] SETTINGS\27[0m\n")
    
    print("  " .. "\27[32m1.\27[0m Change Default Encryption Key")
    print("  " .. "\27[32m2.\27[0m Set GitHub Username")
    print("  " .. "\27[32m3.\27[0m Clear Downloaded Scripts")
    print("  " .. "\27[32m4.\27[0m Back")
    print("")
    io.write("\27[34m  Choose: \27[0m")
    
    local choice = io.read()
    
    if choice == "1" then
        io.write("  Enter new default key: ")
        local key = io.read()
        local file = io.open(os.getenv("HOME") .. "/.xmb420_config.lua", "w")
        if file then
            file:write("return { default_key = '" .. key .. "' }\n")
            file:close()
            print("\27[32m[✓] Key saved!\27[0m")
        end
    elseif choice == "2" then
        io.write("  Enter GitHub username: ")
        local user = io.read()
        local file = io.open(os.getenv("HOME") .. "/.xmb420_config.lua", "a")
        if file then
            file:write("  github_user = '" .. user .. "',\n")
            file:close()
            print("\27[32m[✓] Username saved!\27[0m")
        end
    elseif choice == "3" then
        print("\27[33m[*] Clearing downloaded scripts...\27[0m")
        os.execute("rm -rf ~/.xmb420/downloads/*")
        print("\27[32m[✓] Cleared!\27[0m")
    end
    
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- FUNCTION: About
local function about()
    clearScreen()
    printHeader()
    print("\n" .. "\27[33m[!] ABOUT XMB 420\27[0m")
    print("\n  " .. "\27[36mVersion:\27[0m 1.0")
    print("  " .. "\27[36mAuthor:\27[0m Your Name")
    print("  " .. "\27[36mGitHub:\27[0m https://github.com/YOUR_USERNAME/XMB-420")
    print("\n  " .. "\27[36mDescription:\27[0m")
    print("  Car Parking Multiplayer Script Manager")
    print("  Download pre-made scripts or encrypt your own")
    print("\n  " .. "\27[36mFeatures:\27[0m")
    print("  • Download CPM scripts by version")
    print("  • AES-256-CBC Encryption")
    print("  • Decrypt your own scripts")
    print("  • Organize scripts by game version")
    print("  • TUI interface")
    print("\n\27[36mPress Enter to continue...\27[0m")
    io.read()
end

-- MAIN LOOP
while true do
    showMainMenu()
    local choice = io.read()
    
    if choice == "1" then
        downloadScripts()
    elseif choice == "2" then
        encryptScript()
    elseif choice == "3" then
        decryptScript()
    elseif choice == "4" then
        viewDownloaded()
    elseif choice == "5" then
        viewEncrypted()
    elseif choice == "6" then
        settings()
    elseif choice == "7" then
        about()
    elseif choice == "0" then
        clearScreen()
        print("\27[36m[!] Goodbye from XMB 420!\27[0m\n")
        os.exit(0)
    else
        print("\n" .. "\27[31m[✗] Invalid option!\27[0m")
        print("\27[36mPress Enter to continue...\27[0m")
        io.read()
    end
end