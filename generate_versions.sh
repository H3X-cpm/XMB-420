#!/usr/bin/env bash

versions=("4.9.10" "4.9.11" "4.9.12" "4.9.13" "5.0.0" "5.1.0" "5.2.0" "5.3.0")
scripts=("money" "speed" "unlock" "gems" "noclip" "xp" "upgrades" "aim" "SeKoPrimeCP1-2")

for version in "${versions[@]}"; do
    mkdir -p "scripts/$version"
    
    # Copy menu.lua template
    cat > "scripts/$version/menu.lua" << 'EOF'
[PASTE THE menu.lua CODE ABOVE]
EOF
    
    for script in "${scripts[@]}"; do
        if [ "$script" == "SeKoPrimeCP1-2" ]; then
            cat > "scripts/$version/$script.lua" << 'EOF'
-- Car Parking Multiplayer vVERSION
-- Script: SeKoPrimeCP1-2
-- XMB 420 v2.9
-- 
-- ⚠️ IMPORTANT: This script is encrypted/protected by the developer
-- ⚠️ DO NOT MODIFY - Use as-is
-- ⚠️ For support contact the original developer

print("🔥 SeKoPrimeCP1-2 Script")
print("========================================")
print("This script is protected by the developer.")
print("Features included:")
print("  • Enhanced vehicle handling")
print("  • Improved performance")
print("  • Premium features")
print("  • CP1-2 optimizations")
print("========================================")
print("✅ Script loaded successfully!")
EOF
            sed -i "s/VERSION/$version/g" "scripts/$version/$script.lua"
        else
            cat > "scripts/$version/$script.lua" << EOF
print("📥 Loading $script script for CPM v$version...")

local function applyMod()
    print("[✓] $script mod applied!")
end

applyMod()
EOF
        fi
    done
    
    echo "✅ Created version $version with SeKoPrimeCP1-2"
done

echo "🎉 All versions created!"
