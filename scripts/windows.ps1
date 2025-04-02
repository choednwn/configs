$execpath = Get-Location
$version = "0.0.3a"
$date = "2025.03.31"

#=======================#
#       JCT ENTRY       #
#=======================#

function JCT-Execute {
    # Start of script
    if ("$execpath".EndsWith("\configs")) {
        JCT-Entry
    }
    else {
        Write-Host "Script must be run from the `"configs`" folder"
    }
}

function JCT-Entry {
    Write-Host "`nJustin's Configuration Tool (JCT)" -ForegroundColor DarkMagenta
    Write-Host "Platform: Windows" -ForegroundColor DarkGray
    Write-Host "Version $version ($date)`n" -ForegroundColor DarkGray 

    $opts = "Editors", "Lang", "OS", "Terminal"
    switch (Selector "Options" $opts) {
        0 { Select-Editor }
        1 { Select-Lang }
        2 { Select-OS }
        3 { Select-Terminal }
    }
}

#================================#
#       Utility Functions        #
#================================#

function Set-Files([string]$dest, [string]$origin, [string[]]$files) {
    foreach ($file in $files) {
        if ([System.IO.File]::Exists("$dest\$file.old")) {
            Write-Host "Backup files already exist."
            break
        }
        if ([System.IO.File]::Exists("$dest\$file")) {
            Rename-Item -Path "$dest\$file" -NewName "$dest\$file.old"
        }
        Copy-Item "$execpath\$origin\$file" -Destination "$dest\$file"
    }
}

function Selector([string]$msg, [string[]]$opts) {
    Write-Host -ForegroundColor Cyan "$msg".ToUpper()

    $idx = 0;    
    while ($idx -lt $opts.Length) {
        $opt = $opts[$idx]
        Write-Host "$idx) $opt"
        $idx++
    }
    Write-Host "$idx) Exit"

    $select = $(Write-Host "`nSelect: " -ForegroundColor Cyan -NoNewLine; Read-Host)
    if ($select -match "^\d+$") {
        Write-Host "`n"
        if ([int]$select -eq $idx) {
            exit
        }
        return [int]$select
    }
}

#===============================#
#       Editor Functions        #
#===============================#

function Select-Editor {
    $opts = "JetBrains", "Neovim", "VsCode"
    switch (Selector "Editor Options" $opts) {
        0 { # JetBrains
            $dest = $env:USERPROFILE
            $origin = "editors\jetbrains"
            $files = ".ideavimrc"
            Set-Files $dest $origin $files
            Write-Host "Successfully set JetBrains configurations" -ForegroundColor Cyan
        }
        1 { # Neovim
            Write-Host "Work-In-Progress"
        }
        2 { # VsCode
            $dest = "$env:APPDATA\Code\User"
            $origin = "editors\vscode"
            $files = "settings.json", "keybindings.json"
            Set-Files $dest $origin $files
            Write-Host "Successfully set VsCode configurations" -ForegroundColor Cyan
        }
    }
}

#===============================#
#       Language Functions      #
#===============================#

function Select-Lang {
    $opts = "Clang"
    switch (Selector "Language Options" $opts) {
        0 {
            $dest = $env:USERPROFILE
            $origin = "lang\clang"
            $files = ".clang-format"
            Set-Files $dest $origin $files
            Write-Host "Successfully set Clang configurations" -ForegroundColor Cyan
        }
    }
}

#===========================#
#       OS Functions        #
#===========================#

function Select-OS {
    $opts = "Chocolately"
    switch (Selector "OS Options" $opts) {
        0 {
            OS-Chocolately
        }
    }
}

function OS-Chocolately {
    $opts = "Install Chocolately", "Install Packages"
    switch (Selector "Chocolately Options" $opts) {
        0 { }
        1 { }
    }
}

#===============================#
#       Terminal Functions      #
#===============================#

function Select-Terminal {
    Write-Host "Work-In-Progress"
}

# Run Script
JCT-Execute

