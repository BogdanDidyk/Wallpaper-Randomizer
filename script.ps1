# Change the path to the folder to your own:
#                |       |       |
#                V       V       V
$folderPath = "E:\Wallpapers\Static\"
$wallpaperExtensions = @("*.jpg", "*.png", "*.gif", "*.jpeg", "*.bmp", "*.tiff")

# Get all wallpaper files in the folder
$wallpaperFiles = Get-ChildItem -Path $folderPath -Depth 1 -File -Include $wallpaperExtensions

# Get the random wallpaper file path
$randomIndex = Get-Random -Minimum 0 -Maximum $wallpaperFiles.Count
$randomWallpaperPath = $wallpaperFiles[$randomIndex].FullName

# Load the User32.dll library and define the Wallpaper class with the SystemParametersInfo method
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
    
public class Wallpaper {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Set the random wallpaper as the desktop background
[Wallpaper]::SystemParametersInfo(20, 0, $randomWallpaperPath, 3)