# EXECUTE THIS SCRIPT FROM THE SDCARD or USB DRIVE CONTAINING THE UPDATED DATABASES


# Ask for the Garmin Trainer Database path or use the default
$defaultGarminTrainerDB = "C:\ProgramData\Garmin\Trainers\Databases"
$garminTrainerDB = Read-Host -Prompt "Enter the Garmin Trainer Database path (default: $defaultGarminTrainerDB)"
if (-not $garminTrainerDB) {
    $garminTrainerDB = $defaultGarminTrainerDB
}

# Ask for the path of the SD card or USB key and do not proceed until user has entered the drive
do {
    $garminCard = Read-Host -Prompt "Enter the drive letter of the SD card or USB key (e.g., I:)"
} while (-not (Test-Path $garminCard))

# Ensure paths are correct
$navDbSourceAviation = Join-Path -Path $garminCard -ChildPath "ldr_sys\nav_db2.bin"
$navDbSourceHeli = Join-Path -Path $garminCard -ChildPath "ldr_sys\nav_heli_db2.bin"
$terrainOdbSource = Join-Path -Path $garminCard -ChildPath "terrain.odb"
$safeTaxiSource = Join-Path -Path $garminCard -ChildPath "safetaxi.bin"

#Airplane Database
$navDbDestination1 = Join-Path -Path $garminTrainerDB -ChildPath "nav_db2.bin"
$navDbDestination2 = Join-Path -Path $garminTrainerDB -ChildPath "nav_db2_grm.bin"

#Helicopter Database
$navDbDestination3 = Join-Path -Path $garminTrainerDB -ChildPath "nav_heli_db2.bin"
$navDbDestination3 = Join-Path -Path $garminTrainerDB -ChildPath "nav_heli_db2_grm.bin"

$terrainOdbDestination = Join-Path -Path $garminTrainerDB -ChildPath "terrain.odb2"
$safeTaxiDestination = Join-Path -Path $garminTrainerDB -ChildPath "safetaxi.bin"

# NAVIGATION DATABASE
if (Test-Path $navDbSourceAviation) {
    Copy-Item -Path $navDbSourceAviation -Destination $navDbDestination1 -Force
    Copy-Item -Path $navDbSourceAviation -Destination $navDbDestination2 -Force
    Write-Host "Aircraft Navigation database copied successfully."
} else {
    Write-Host "Aircraft Navigation database file not found at $navDbSource."
}

if (Test-Path $navDbSourceHeli) {
    Copy-Item -Path $navDbSourceHeli -Destination $navDbDestination3 -Force
    Copy-Item -Path $navDbSourceHeli -Destination $navDbDestination4 -Force
    Write-Host "Helicopter Navigation database copied successfully."
} else {
    Write-Host "Helicopter Navigation database file not found at $navDbSourceHeli."
}

# OBST/HOT
if (Test-Path $terrainOdbSource) {
    Copy-Item -Path $terrainOdbSource -Destination $terrainOdbDestination -Force
    Write-Host "Terrain database copied successfully."
} else {
    Write-Host "Terrain database file not found at $terrainOdbSource."
}

# Safe Taxi
if (Test-Path $safeTaxiSource) {
    Copy-Item -Path $safeTaxiSource -Destination $safeTaxiDestination -Force
    Write-Host "Safe Taxi database copied successfully."
} else {
    Write-Host "Safe Taxi database file not found at $safeTaxiSource."
}
