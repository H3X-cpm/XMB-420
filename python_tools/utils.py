# Utility functions for CPM Cheats
# XMB 420 Python Tools

import os
import sys
import subprocess
import shutil
from datetime import datetime

def get_storage_path():
    """Get the primary storage path"""
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

def get_cpm_path():
    """Get CPM game data path"""
    storage = get_storage_path()
    paths = [
        os.path.join(storage, "Android/data/com.gameloft.android.ANMP.GloftCPM/files"),
        os.path.join(storage, "Android/data/com.gameloft.cpm/files"),
        os.path.join(storage, "data/com.gameloft.cpm/files")
    ]
    
    for path in paths:
        if os.path.exists(path):
            return path
    
    return None

def is_termux():
    """Check if running in Termux"""
    return 'ANDROID_ROOT' in os.environ or os.path.exists('/data/data/com.termux')

def get_file_size(path):
    """Get file size in human readable format"""
    if os.path.exists(path):
        size = os.path.getsize(path)
        if size < 1024:
            return f"{size} B"
        elif size < 1024 * 1024:
            return f"{size / 1024:.1f} KB"
        elif size < 1024 * 1024 * 1024:
            return f"{size / (1024 * 1024):.1f} MB"
        else:
            return f"{size / (1024 * 1024 * 1024):.1f} GB"
    return "0 B"

def get_dir_size(path):
    """Get directory size in human readable format"""
    if not os.path.exists(path):
        return "0 B"
    
    total = 0
    for root, dirs, files in os.walk(path):
        for f in files:
            fp = os.path.join(root, f)
            if os.path.exists(fp):
                total += os.path.getsize(fp)
    
    if total < 1024:
        return f"{total} B"
    elif total < 1024 * 1024:
        return f"{total / 1024:.1f} KB"
    elif total < 1024 * 1024 * 1024:
        return f"{total / (1024 * 1024):.1f} MB"
    else:
        return f"{total / (1024 * 1024 * 1024):.1f} GB"

def run_command(cmd):
    """Run a command and return output"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout.strip(), result.stderr.strip(), result.returncode
    except:
        return "", "", 1

def backup_file(src, dst):
    """Backup a file"""
    try:
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy2(src, dst)
        return True
    except:
        return False

def backup_directory(src, dst):
    """Backup a directory"""
    try:
        if os.path.exists(dst):
            shutil.rmtree(dst)
        shutil.copytree(src, dst)
        return True
    except:
        return False

def clean_directory(path):
    """Clean a directory"""
    try:
        if os.path.exists(path):
            shutil.rmtree(path)
            os.makedirs(path, exist_ok=True)
        return True
    except:
        return False

def create_timestamp():
    """Create a timestamp string"""
    return datetime.now().strftime("%Y%m%d_%H%M%S")

def get_backup_name():
    """Generate a backup name"""
    return f"cpm_backup_{create_timestamp()}"

def check_internet():
    """Check if internet is available"""
    try:
        import requests
        requests.get("https://github.com", timeout=3)
        return True
    except:
        return False