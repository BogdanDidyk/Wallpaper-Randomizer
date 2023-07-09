# Change the path to the folder to your own:
#                |       |       |
#                V       V       V
$folderPath = "E:\Wallpapers\Static\"
$wallpaperExtensions = @("*.jpg", "*.png", "*.gif", "*.jpeg", "*.bmp", "*.tiff")

# If the folder does not exist, stop script execution
if (-not (Test-Path -Path $folderPath))
{
    Write-Host "Folder does not exist!" -ForegroundColor Red
    Exit 1
}

# Get all wallpaper files and its count
$wallpaperFiles = Get-ChildItem -Path $folderPath -Depth 1 -File -Include $wallpaperExtensions
$wallpapersCount = $wallpaperFiles.Count

# If the folder does not contain wallpapers, stop script execution
if ($wallpapersCount -eq 0)
{
    Write-Host "The folder does not contain a wallpaper!" -ForegroundColor Red
    Exit 1
}

# Get the random wallpaper file path
$randomIndex = Get-Random -Minimum 0 -Maximum $wallpaperFiles.Count
$randomWallpaperPath = $wallpaperFiles[$randomIndex].FullName

try
{
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
}
catch
{
    Write-Host $_.Exception.Message -ForegroundColor Red
    Exit 1
}