-- XMB 420 - Main Menu
-- Car Parking Multiplayer Script Manager
-- Version: v2.9
-- GitHub: H3X-cpm/XMB-420

local XMB_VERSION = "v2.9"

local function clearScreen()
    os.execute("clear")
end

local colors = {
    reset = "\27[0m",
    bold = "\27[1m",
    red = "\27[31m",
    green = "\27[32m",
    yellow = "\27[33m",
    blue = "\27[34m",
    purple = "\27[35m",
    cyan = "\27[36m",
    white = "\27[37m",
}

local function printHeader()
    clearScreen()
    
    print(colors.cyan .. colors.bold .. [[
  ╔══════════════════════════════════════════════╗
  ║   XMB 420 - SCRIPT MANAGER                  ║
  ║   Car Parking Multiplayer                   ║
  ╚══════════════════════════════════════════════╝
    ]] .. colors.reset)
    
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
end

local function listDownloadedScripts()
    print(colors.cyan .. "  📂 Downloaded Scripts:" .. colors.reset)
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
        print("  " .. colors.yellow .. "No scripts downloaded yet" .. colors.reset)
        print("  " .. colors.cyan .. "Select option 1 to download scripts" .. colors.reset)
    else
        for i, script in ipairs(scripts) do
            local name = script:match("([^/]+)%.lua$")
            print("  " .. colors.green .. string.format("%2d.", i) .. colors.reset .. " " .. name .. ".lua")
        end
        print("")
        print("  " .. colors.green .. "Total: " .. #scripts .. " scripts" .. colors.reset)
    end
    
    print("")
end

local function showMainMenu()
    printHeader()
    
    print(colors.bold .. colors.cyan .. "\n  📦 MAIN MENU" .. colors.reset)
    print("")
    print("  " .. colors.green .. "1." .. colors.reset .. " 📥 Download CPM Scripts")
    print("  " .. colors.green .. "2." .. colors.reset .. " 📂 View Downloaded Scripts")
    print("  " .. colors.green .. "3." .. colors.reset .. " 🔐 Encrypt Script")
    print("  " .. colors.green .. "4." .. colors.reset .. " 🔓 Decrypt Script")
    print("  " .. colors.green .. "5." .. colors.reset .. " 📁 View Encrypted Scripts")
    print("  " .. colors.green .. "6." .. colors.reset .. " ⚙️  Settings")
    print("  " .. colors.green .. "7." .. colors.reset .. " 🐍 CPM Cheats")
    print("  " .. colors.green .. "8." .. colors.reset .. " 💎 Premium Scripts")
    print("  " .. colors.green .. "9." .. colors.reset .. " ℹ️  About")
    print("  " .. colors.red .. "0." .. colors.reset .. " 🚪 Exit")
    print("")
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    
    listDownloadedScripts()
    
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    io.write(colors.blue .. "  ➜ Choose option: " .. colors.reset)
end

-- FUNCTION: Download Scripts
local function downloadScripts()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] DOWNLOAD CPM SCRIPTS" .. colors.reset .. "\n")
    
    print(colors.cyan .. "  Available Versions:" .. colors.reset)
    print("")
    print("  " .. colors.green .. "1." .. colors.reset .. " Version 4.9.10")
    print("  " .. colors.green .. "2." .. colors.reset .. " Version 4.9.11")
    print("  " .. colors.green .. "3." .. colors.reset .. " Version 4.9.12")
    print("  " .. colors.green .. "4." .. colors.reset .. " Version 4.9.13")
    print("  " .. colors.green .. "5." .. colors.reset .. " Version 5.0.0")
    print("  " .. colors.green .. "6." .. colors.reset .. " Version 5.1.0")
    print("  " .. colors.green .. "7." .. colors.reset .. " Version 5.2.0")
    print("  " .. colors.green .. "8." .. colors.reset .. " Version 5.3.0")
    print("  " .. colors.green .. "9." .. colors.reset .. " " .. colors.cyan .. "Custom" .. colors.reset)
    print("  " .. colors.red .. "0." .. colors.reset .. " Back")
    print("")
    io.write(colors.blue .. "  Select version: " .. colors.reset)
    
    local choice = io.read()
    local version = ""
    
    local versions = {"4.9.10", "4.9.11", "4.9.12", "4.9.13", "5.0.0", "5.1.0", "5.2.0", "5.3.0"}
    
    if tonumber(choice) and tonumber(choice) >= 1 and tonumber(choice) <= 8 then
        version = versions[tonumber(choice)]
    elseif choice == "9" then
        io.write(colors.cyan .. "  Enter version: " .. colors.reset)
        version = io.read()
    elseif choice == "0" then
        return
    else
        print(colors.red .. "[✗] Invalid choice!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    
    if version == "" then
        print(colors.red .. "[✗] Invalid version!" .. colors.reset)
        os.execute("sleep 1")
        return
    end
    
    print("\n" .. colors.yellow .. "[*] Downloading scripts for version " .. version .. "..." .. colors.reset)
    
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
        
        io.write("   " .. colors.cyan .. "⬇" .. colors.reset .. " Downloading " .. script .. ".lua...")
        local cmd = string.format("curl -s '%s' -o '%s'", url, output)
        os.execute(cmd)
        
        local file = io.open(output, "r")
        if file then
            file:close()
            print(" " .. colors.green .. "✓" .. colors.reset)
            count = count + 1
        else
            print(" " .. colors.red .. "✗" .. colors.reset)
        end
    end
    
    print("")
    print(colors.green .. "[✓] Downloaded " .. count .. " scripts for version " .. version .. colors.reset)
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: View Downloaded Scripts
local function viewDownloaded()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] DOWNLOADED SCRIPTS" .. colors.reset .. "\n")
    print(colors.cyan .. "  Location: ~/.xmb420/downloads/" .. colors.reset .. "\n")
    os.execute("ls -la ~/.xmb420/downloads/*.lua 2>/dev/null || echo '  No scripts found'")
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: View Encrypted Scripts
local function viewEncrypted()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] ENCRYPTED SCRIPTS" .. colors.reset .. "\n")
    print(colors.cyan .. "  Location: ~/.xmb420/encrypted/" .. colors.reset .. "\n")
    os.execute("ls -la ~/.xmb420/encrypted/*.enc 2>/dev/null || echo '  No encrypted files found'")
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Encrypt Script
local function encryptScript()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] ENCRYPT SCRIPT" .. colors.reset .. "\n")
    
    io.write("  Enter script name (e.g., money.lua): ")
    local script_name = io.read()
    
    if script_name == "" then
        return
    end
    
    local input = os.getenv("HOME") .. "/.xmb420/downloads/" .. script_name
    local output = os.getenv("HOME") .. "/.xmb420/encrypted/" .. script_name:gsub("%.lua$", "") .. ".enc"
    
    local file = io.open(input, "r")
    if not file then
        print(colors.red .. "[✗] Script not found!" .. colors.reset)
        print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        return
    end
    file:close()
    
    io.write("  Enter encryption key (or press Enter for default): ")
    local key = io.read()
    if key == "" then
        key = "XMB420_" .. os.date("%Y%m%d")
    end
    
    print("\n" .. colors.yellow .. "[*] Encrypting..." .. colors.reset)
    local cmd = string.format("openssl enc -aes-256-cbc -salt -in '%s' -out '%s' -k '%s'", input, output, key)
    os.execute(cmd)
    
    print(colors.green .. "[✓] Encrypted successfully!" .. colors.reset)
    print(colors.cyan .. "[!] Saved to: ~/.xmb420/encrypted/" .. output:match("([^/]+)$") .. colors.reset)
    print(colors.yellow .. "[!] Key: " .. key .. colors.reset)
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Decrypt Script
local function decryptScript()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] DECRYPT SCRIPT" .. colors.reset .. "\n")
    
    print(colors.cyan .. "  Encrypted files:" .. colors.reset)
    os.execute("ls -la ~/.xmb420/encrypted/*.enc 2>/dev/null || echo '  No encrypted files found'")
    print("")
    
    io.write("  Enter encrypted filename (e.g., script.enc): ")
    local enc_name = io.read()
    
    if enc_name == "" then
        return
    end
    
    local input = os.getenv("HOME") .. "/.xmb420/encrypted/" .. enc_name
    local output = os.getenv("HOME") .. "/.xmb420/downloads/" .. enc_name:gsub("%.enc$", "") .. "_decrypted.lua"
    
    local file = io.open(input, "r")
    if not file then
        print(colors.red .. "[✗] File not found!" .. colors.reset)
        print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        return
    end
    file:close()
    
    io.write("  Enter decryption key: ")
    local key = io.read()
    
    print("\n" .. colors.yellow .. "[*] Decrypting..." .. colors.reset)
    local cmd = string.format("openssl enc -aes-256-cbc -d -salt -in '%s' -out '%s' -k '%s'", input, output, key)
    local result = os.execute(cmd)
    
    if result then
        print(colors.green .. "[✓] Decrypted successfully!" .. colors.reset)
        print(colors.cyan .. "[!] Saved to: ~/.xmb420/downloads/" .. output:match("([^/]+)$") .. colors.reset)
    else
        print(colors.red .. "[✗] Decryption failed! Wrong key?" .. colors.reset)
    end
    
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Settings
local function settings()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] SETTINGS" .. colors.reset .. "\n")
    
    print("  " .. colors.green .. "1." .. colors.reset .. " Clear Downloaded Scripts")
    print("  " .. colors.green .. "2." .. colors.reset .. " Clear Encrypted Scripts")
    print("  " .. colors.green .. "3." .. colors.reset .. " Back")
    print("")
    io.write(colors.blue .. "  Choose: " .. colors.reset)
    
    local choice = io.read()
    
    if choice == "1" then
        print(colors.yellow .. "[*] Clearing downloaded scripts..." .. colors.reset)
        os.execute("rm -rf ~/.xmb420/downloads/*")
        print(colors.green .. "[✓] Cleared!" .. colors.reset)
    elseif choice == "2" then
        print(colors.yellow .. "[*] Clearing encrypted scripts..." .. colors.reset)
        os.execute("rm -rf ~/.xmb420/encrypted/*")
        print(colors.green .. "[✓] Cleared!" .. colors.reset)
    end
    
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: CPM Cheats
local function cpmCheats()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] CPM CHEATS" .. colors.reset)
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    local python_check = os.execute("command -v python3 >/dev/null 2>&1")
    if python_check ~= 0 then
        print(colors.red .. "[✗] Python3 is not installed!" .. colors.reset)
        print("")
        print(colors.yellow .. "[*] Install with: pkg install python python-pip -y" .. colors.reset)
        print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
        return
    end
    
    print(colors.green .. "[✓] Python3 is installed" .. colors.reset)
    print("")
    
    os.execute("mkdir -p ~/.xmb420/tools")
    local local_path = os.getenv("HOME") .. "/.xmb420/tools/cpmcheats.py"
    
    if not io.open(local_path, "r") then
        print(colors.yellow .. "[*] Downloading CPM Cheats..." .. colors.reset)
        local url = "https://raw.githubusercontent.com/Rickdevsolutions/cpm2/main/cpmcheats.py"
        os.execute(string.format("curl -s '%s' -o '%s'", url, local_path))
        os.execute("chmod +x " .. local_path)
        print(colors.green .. "[✓] Downloaded!" .. colors.reset)
        print("")
    end
    
    print(colors.green .. "[✓] Launching CPM Cheats..." .. colors.reset)
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    os.execute("python3 " .. local_path)
    
    print("")
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print(colors.green .. "[✓] CPM Cheats finished" .. colors.reset)
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: Premium Scripts
local function premiumScripts()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] 💎 PREMIUM SCRIPTS" .. colors.reset)
    print(colors.cyan .. "  ───────────────────────────────────────────────────────" .. colors.reset)
    print("")
    
    print(colors.bold .. colors.yellow .. "  ╔═══════════════════════════════════════════════════╗" .. colors.reset)
    print(colors.bold .. colors.yellow .. "  ║" .. colors.reset .. colors.bold .. colors.white .. "           💎 PREMIUM SCRIPTS AVAILABLE           " .. colors.bold .. colors.yellow .. "║" .. colors.reset)
    print(colors.bold .. colors.yellow .. "  ╚═══════════════════════════════════════════════════╝" .. colors.reset)
    print("")
    
    print(colors.cyan .. "  Available Premium Scripts:" .. colors.reset)
    print("")
    print("  " .. colors.yellow .. "1." .. colors.reset .. " 💰 Premium Money Script")
    print("  " .. colors.yellow .. "2." .. colors.reset .. " 🚀 Premium Speed Script")
    print("  " .. colors.yellow .. "3." .. colors.reset .. " 🔓 Premium Unlock Script")
    print("  " .. colors.yellow .. "4." .. colors.reset .. " 🔥 Premium All-in-One")
    print("")
    print(colors.purple .. "  ╔═══════════════════════════════════════════════════╗" .. colors.reset)
    print(colors.purple .. "  ║" .. colors.reset .. colors.bold .. colors.white .. "        📱 HOW TO GET PREMIUM SCRIPTS           " .. colors.purple .. "║" .. colors.reset)
    print(colors.purple .. "  ╚═══════════════════════════════════════════════════╝" .. colors.reset)
    print("")
    print(colors.yellow .. "  Contact me on Telegram: @H3X_cpm" .. colors.reset)
    print("  " .. colors.cyan .. "Link: https://t.me/H3X_cpm" .. colors.reset)
    print("")
    print(colors.green .. "  Pricing:" .. colors.reset)
    print("  • Single Script: $5")
    print("  • Script Pack: $20")
    print("  • VIP Lifetime: $50")
    print("")
    print(colors.cyan .. "  Press Enter to continue..." .. colors.reset)
    io.read()
end

-- FUNCTION: About
local function about()
    clearScreen()
    printHeader()
    print("\n" .. colors.yellow .. "[!] ABOUT XMB 420" .. colors.reset)
    print("\n  " .. colors.cyan .. "Version:" .. colors.reset .. " " .. XMB_VERSION)
    print("  " .. colors.cyan .. "Author:" .. colors.reset .. " H3X-cpm")
    print("  " .. colors.cyan .. "GitHub:" .. colors.reset .. " https://github.com/H3X-cpm/XMB-420")
    print("\n  " .. colors.cyan .. "Description:" .. colors.reset)
    print("  Car Parking Multiplayer Script Manager")
    print("  Download scripts, encrypt, decrypt, and more")
    print("\n  " .. colors.cyan .. "Features:" .. colors.reset)
    print("  • Download CPM scripts by version")
    print("  • AES-256-CBC Encryption")
    print("  • Decrypt scripts")
    print("  • CPM Cheats integration")
    print("  • Premium scripts available")
    print("\n  " .. colors.cyan .. "Socials:" .. colors.reset)
    print("  • Telegram: https://t.me/H3X_cpm")
    print("  • GitHub: https://github.com/H3X-cpm")
    print("\n" .. colors.cyan .. "Press Enter to continue..." .. colors.reset)
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
        premiumScripts()
    elseif choice == "9" then
        about()
    elseif choice == "0" then
        clearScreen()
        print(colors.cyan .. "[!] Goodbye from XMB 420!" .. colors.reset .. "\n")
        os.exit(0)
    else
        print("\n" .. colors.red .. "[✗] Invalid option!" .. colors.reset)
        print(colors.cyan .. "Press Enter to continue..." .. colors.reset)
        io.read()
    end
end
