echo "Welcome to the KDE Plasma installer!"
echo "This script is for Arch Linux based systems only."
echo ""

echo "Starting install..."
echo ""
# Change paru and syntax to the AUR helper of your choice
paru -S plasma plasma-wayland-session kget kdevelop telepathy-kde-desktop-applets kde-network-meta kdevelop-meta kdevelop-php krfb telepathy-k
de-meta umbrello kde-applications-meta xdg-desktop-portal
echo ""

echo "Installation complete!"
