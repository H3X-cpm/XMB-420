# Configuration settings for CPM Cheats
# XMB 420 Python Tools

import os
import json

CONFIG_DIR = os.path.expanduser("~/.xmb420")
CONFIG_FILE = os.path.join(CONFIG_DIR, "cpm_config.json")

DEFAULT_CONFIG = {
    "version": "1.0",
    "features": {
        "auto_update": True,
        "color_output": True,
        "backup_location": "~/storage/downloads",
        "auto_clean": False
    },
    "paths": {
        "cpm_data": "/storage/emulated/0/Android/data/com.gameloft.android.ANMP.GloftCPM/files",
        "backup_dir": "~/storage/downloads/cpm_backups"
    }
}

def load_config():
    """Load configuration from file"""
    os.makedirs(CONFIG_DIR, exist_ok=True)
    
    if os.path.exists(CONFIG_FILE):
        try:
            with open(CONFIG_FILE, 'r') as f:
                return json.load(f)
        except:
            pass
    
    # Create default config
    with open(CONFIG_FILE, 'w') as f:
        json.dump(DEFAULT_CONFIG, f, indent=4)
    
    return DEFAULT_CONFIG

def save_config(config):
    """Save configuration to file"""
    os.makedirs(CONFIG_DIR, exist_ok=True)
    with open(CONFIG_FILE, 'w') as f:
        json.dump(config, f, indent=4)

def get_config_value(key, default=None):
    """Get a specific config value"""
    config = load_config()
    keys = key.split('.')
    value = config
    for k in keys:
        if isinstance(value, dict) and k in value:
            value = value[k]
        else:
            return default
    return value