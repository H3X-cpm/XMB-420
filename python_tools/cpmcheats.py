#!/usr/bin/env python3
# CPM Cheats - Car Parking Multiplayer Toolkit
# XMB 420 Integration
# Version: 1.0

import os
import sys
import subprocess
import json
from datetime import datetime

try:
    import requests
    import colorama
    from colorama import Fore, Back, Style
    colorama.init()
except ImportError:
    # Fallback if colorama not installed
    class Fore:
        RED = '\033[91m'
        GREEN = '\033[92m'
        YELLOW = '\033[93m'
        BLUE = '\033[94m'
        MAGENTA = '\033[95m'
        CYAN = '\033[96m'
        WHITE = '\033[97m'
        RESET = '\033[0m'
    
    class Back:
        RED = '\033[101m'
        GREEN = '\033[102m'
        YELLOW = '\033[103m'
        BLUE = '\033[104m'
        MAGENTA = '\033[105m'
        CYAN = '\033[106m'
        WHITE = '\033[107m'
        RESET = '\033[0m'
    
    class Style:
        BRIGHT = '\033[1m'
        DIM = '\033[2m'
        NORMAL = '\033[22m'
        RESET_ALL = '\033[0m'

# ============================================
# CONFIGURATION
# ============================================

CONFIG_FILE = os.path.expanduser("~/.xmb420/cpm_config.json")

def load_config():
    """Load configuration from file"""
    if os.path.exists(CONFIG_FILE):
        try:
            with open(CONFIG_FILE, 'r') as f:
                return json.load(f)
        except:
            pass
    return {
        "version": "1.0",
        "features": {
            "auto_update": True,
            "color_output": True
        }
    }

def save_config(config):
    """Save configuration to file"""
    os.makedirs(os.path.dirname(CONFIG_FILE), exist_ok=True)
    with open(CONFIG_FILE, 'w') as f:
        json.dump(config, f, indent=4)

config = load_config()

# ============================================
# UTILITY FUNCTIONS
# ============================================

def clear_screen():
    """Clear terminal screen"""
    os.system('clear' if os.name == 'posix' else 'cls')

def print_banner():
    """Print CPM Cheats banner"""
    clear_screen()
    print(Fore.CYAN + Style.BRIGHT)
    print("  ╔══════════════════════════════════════════════╗")
    print("  ║  🐍 CPM CHEATS - Car Parking Multiplayer   ║")
    print("  ║  XMB 420 Integration                       ║")
    print("  ╚══════════════════════════════════════════════╝")
    print(Fore.RESET + Style.NORMAL)
    print(Fore.YELLOW + "  ────────────────────────────────────────" + Fore.RESET)
    print("")

def check_phone():
    """Check if device is compatible"""
    print(Fore.CYAN + "[*] Checking device compatibility..." + Fore.RESET)
    
    # Check for Android
    is_android = os.path.exists("/sdcard") or os.path.exists("/storage/emulated/0")
    
    if is_android:
        print(Fore.GREEN + "[✓] Android device detected" + Fore.RESET)
    else:
        print(Fore.YELLOW + "[!] Non-Android device detected" + Fore.RESET)
    
    return is_android

def get_termux_path():
    """Get Termux storage path"""
    paths = [
        "/storage/emulated/0",
        "/sdcard",
        os.path.expanduser("~/storage/shared"),
        os.path.expanduser("~/storage/downloads")
    ]
    
    for path in paths:
        if os.path.exists(path):
            return path
    
    return os.path.expanduser("~")

# ============================================
# FEATURE FUNCTIONS
# ============================================

def feature_backup():
    """Backup CPM game files"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] BACKUP GAME FILES" + Fore.RESET)
    print("")
    
    storage_path = get_termux_path()
    cpm_path = os.path.join(storage_path, "Android/data/com.gameloft.android.ANMP.GloftCPM/files")
    
    if not os.path.exists(cpm_path):
        print(Fore.RED + "[✗] CPM game folder not found!" + Fore.RESET)
        print(Fore.YELLOW + "[!] Make sure the game is installed" + Fore.RESET)
        input("\nPress Enter to continue...")
        return
    
    backup_name = f"cpm_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    backup_path = os.path.join(storage_path, "Download", backup_name)
    
    print(Fore.CYAN + f"[*] Backing up to: {backup_path}" + Fore.RESET)
    os.system(f"cp -r '{cpm_path}' '{backup_path}'")
    
    if os.path.exists(backup_path):
        print(Fore.GREEN + f"[✓] Backup created: {backup_name}" + Fore.RESET)
    else:
        print(Fore.RED + "[✗] Backup failed!" + Fore.RESET)
    
    input("\nPress Enter to continue...")

def feature_restore():
    """Restore CPM game files from backup"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] RESTORE GAME FILES" + Fore.RESET)
    print("")
    
    storage_path = get_termux_path()
    backup_dir = os.path.join(storage_path, "Download")
    
    backups = []
    for item in os.listdir(backup_dir):
        if item.startswith("cpm_backup_"):
            backups.append(item)
    
    if not backups:
        print(Fore.RED + "[✗] No backups found!" + Fore.RESET)
        input("\nPress Enter to continue...")
        return
    
    print(Fore.CYAN + "  Available backups:" + Fore.RESET)
    print("")
    for i, backup in enumerate(backups):
        backup_path = os.path.join(backup_dir, backup)
        size = os.path.getsize(backup_path) // 1024  # KB
        print(f"  {Fore.GREEN}{i+1}.{Fore.RESET} {backup} ({size} KB)")
    
    print("")
    print(f"  {Fore.RED}0.{Fore.RESET} Back")
    print("")
    
    choice = input(Fore.BLUE + "  Select backup to restore: " + Fore.RESET)
    
    if choice == "0":
        return
    
    try:
        idx = int(choice) - 1
        if 0 <= idx < len(backups):
            backup_name = backups[idx]
            backup_path = os.path.join(backup_dir, backup_name)
            
            cpm_path = os.path.join(storage_path, "Android/data/com.gameloft.android.ANMP.GloftCPM/files")
            
            print(Fore.CYAN + f"[*] Restoring from: {backup_name}" + Fore.RESET)
            os.system(f"cp -r '{backup_path}/*' '{cpm_path}/'")
            
            print(Fore.GREEN + "[✓] Restore completed!" + Fore.RESET)
        else:
            print(Fore.RED + "[✗] Invalid selection!" + Fore.RESET)
    except:
        print(Fore.RED + "[✗] Invalid input!" + Fore.RESET)
    
    input("\nPress Enter to continue...")

def feature_clean():
    """Clean temporary files"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] CLEAN TEMPORARY FILES" + Fore.RESET)
    print("")
    
    print(Fore.CYAN + "[*] Cleaning cache files..." + Fore.RESET)
    os.system("rm -rf ~/.xmb420/cache/* 2>/dev/null")
    os.system("rm -rf /tmp/*xmb420* 2>/dev/null")
    
    print(Fore.CYAN + "[*] Cleaning logs..." + Fore.RESET)
    os.system("rm -rf ~/.xmb420/*.log 2>/dev/null")
    
    print(Fore.GREEN + "[✓] Clean completed!" + Fore.RESET)
    input("\nPress Enter to continue...")

def feature_info():
    """Display system information"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] SYSTEM INFORMATION" + Fore.RESET)
    print("")
    
    # Device info
    print(Fore.CYAN + "  Device Information:" + Fore.RESET)
    
    is_android = os.path.exists("/sdcard")
    if is_android:
        print(f"    Platform: {Fore.GREEN}Android{Fore.RESET}")
    else:
        print(f"    Platform: {Fore.YELLOW}Non-Android{Fore.RESET}")
    
    # Storage info
    storage_path = get_termux_path()
    print(f"    Storage: {storage_path}")
    
    # XMB 420 info
    xmb_path = os.path.expanduser("~/.xmb420")
    if os.path.exists(xmb_path):
        print(f"    XMB 420: {Fore.GREEN}Installed{Fore.RESET}")
    else:
        print(f"    XMB 420: {Fore.YELLOW}Not installed{Fore.RESET}")
    
    # Python info
    print(f"    Python: {sys.version.split()[0]}")
    
    # CPM info
    cpm_path = os.path.join(storage_path, "Android/data/com.gameloft.android.ANMP.GloftCPM")
    if os.path.exists(cpm_path):
        print(f"    CPM: {Fore.GREEN}Installed{Fore.RESET}")
    else:
        print(f"    CPM: {Fore.YELLOW}Not found{Fore.RESET}")
    
    print("")
    print(Fore.CYAN + "  Directory Sizes:" + Fore.RESET)
    os.system("du -sh ~/.xmb420 2>/dev/null || echo '    ~/.xmb420: N/A'")
    os.system("du -sh ~/XMB-420 2>/dev/null || echo '    ~/XMB-420: N/A'")
    
    input("\nPress Enter to continue...")

def feature_update():
    """Update CPM Cheats from GitHub"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] UPDATE CPM CHEATS" + Fore.RESET)
    print("")
    
    print(Fore.CYAN + "[*] Checking for updates..." + Fore.RESET)
    
    # Get current version
    current_version = config.get("version", "1.0")
    print(f"    Current version: {current_version}")
    
    # Check GitHub for updates
    try:
        repo = "YOUR_USERNAME/XMB-420"
        url = f"https://api.github.com/repos/{repo}/contents/python_tools/cpmcheats.py"
        response = requests.get(url)
        
        if response.status_code == 200:
            print(Fore.GREEN + "[✓] Update check completed!" + Fore.RESET)
            print(Fore.YELLOW + "[!] Update available? Check GitHub" + Fore.RESET)
        else:
            print(Fore.YELLOW + "[!] Could not check for updates" + Fore.RESET)
    except:
        print(Fore.YELLOW + "[!] Internet connection required" + Fore.RESET)
    
    print("")
    print(Fore.CYAN + "[*] Updating from GitHub..." + Fore.RESET)
    
    script_path = os.path.realpath(__file__)
    url = f"https://raw.githubusercontent.com/YOUR_USERNAME/XMB-420/main/python_tools/cpmcheats.py"
    cmd = f"curl -s '{url}' -o '{script_path}'"
    os.system(cmd)
    
    print(Fore.GREEN + "[✓] Update completed!" + Fore.RESET)
    input("\nPress Enter to continue...")

def feature_settings():
    """Configure CPM Cheats settings"""
    clear_screen()
    print_banner()
    print(Fore.YELLOW + "[!] SETTINGS" + Fore.RESET)
    print("")
    
    print(f"  1. Auto-Update: {Fore.GREEN if config['features']['auto_update'] else Fore.RED}{config['features']['auto_update']}{Fore.RESET}")
    print(f"  2. Color Output: {Fore.GREEN if config['features']['color_output'] else Fore.RED}{config['features']['color_output']}{Fore.RESET}")
    print("  3. Reset to Defaults")
    print("  0. Back")
    print("")
    
    choice = input(Fore.BLUE + "  Select setting: " + Fore.RESET)
    
    if choice == "1":
        config['features']['auto_update'] = not config['features']['auto_update']
        save_config(config)
        print(Fore.GREEN + "[✓] Updated!" + Fore.RESET)
    elif choice == "2":
        config['features']['color_output'] = not config['features']['color_output']
        save_config(config)
        print(Fore.GREEN + "[✓] Updated!" + Fore.RESET)
    elif choice == "3":
        config = {
            "version": "1.0",
            "features": {
                "auto_update": True,
                "color_output": True
            }
        }
        save_config(config)
        print(Fore.GREEN + "[✓] Reset to defaults!" + Fore.RESET)
    
    input("\nPress Enter to continue...")

# ============================================
# MAIN MENU
# ============================================

def main():
    """Main menu loop"""
    while True:
        clear_screen()
        print_banner()
        
        print(Fore.CYAN + "  📦 CPM CHEATS MENU" + Fore.RESET)
        print("")
        print("  " + Fore.GREEN + "1." + Fore.RESET + " 📦 Backup Game Files")
        print("  " + Fore.GREEN + "2." + Fore.RESET + " 📂 Restore Game Files")
        print("  " + Fore.GREEN + "3." + Fore.RESET + " 🧹 Clean Temporary Files")
        print("  " + Fore.GREEN + "4." + Fore.RESET + " ℹ️  System Information")
        print("  " + Fore.GREEN + "5." + Fore.RESET + " 🔄 Update CPM Cheats")
        print("  " + Fore.GREEN + "6." + Fore.RESET + " ⚙️  Settings")
        print("  " + Fore.RED + "0." + Fore.RESET + " 🚪 Exit")
        print("")
        print(Fore.YELLOW + "  ────────────────────────────────────────" + Fore.RESET)
        
        choice = input(Fore.BLUE + "  ➜ Choose option: " + Fore.RESET)
        
        if choice == "1":
            feature_backup()
        elif choice == "2":
            feature_restore()
        elif choice == "3":
            feature_clean()
        elif choice == "4":
            feature_info()
        elif choice == "5":
            feature_update()
        elif choice == "6":
            feature_settings()
        elif choice == "0":
            print(Fore.CYAN + "\n[!] Goodbye from CPM Cheats!" + Fore.RESET)
            sys.exit(0)
        else:
            print(Fore.RED + "[✗] Invalid option!" + Fore.RESET)
            input("\nPress Enter to continue...")

if __name__ == "__main__":
    main()