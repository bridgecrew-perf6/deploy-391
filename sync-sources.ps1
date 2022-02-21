Write-Output "`n:: Init Config:`n"

$sources_share = "\\pdc\sumologic"
$sources_local = "C:\Program Files\Sumo Logic Collector\Sources" #do not change unless required
$install_root  = "C:\sumologic"

# >>> Init

(New-Item -Path $sources_local -ItemType Directory) > $null 2> $null

$sources_arg = $sources_local.Replace('\','\\')  # As the Installation Path Needs  DOUBLE BACKSLASH ONLY OR INSTALL WILL FAIL

# Check Current System
Write-Output "`n:: System Check`n"
Write-Output " Sources: "

#Query for Active Directory
(sc.exe query NTDS) > $null
if ( $LASTEXITCODE -eq 0)
{
    Copy-Item -Path "$sources_share\sources\AD.json" -Destination $sources_local
    Write-Output "`tActive Directory Found"
}

Copy-Item -Path "$sources_share\sources\Windows.json" -Destination $sources_local
Write-Output "`tWindows Log Source"

# Query to see if Sumo Logic Collector is running:

(sc.exe query sumo-collector) > $null 2> $null
if ( $LASTEXITCODE -ne 0)
{
    (New-Item -Path $install_root -ItemType Directory) > $null 2> $null
    Copy-Item -Path "$sources_share\deploy-collector.ps1" -Destination $install_root
    (Start-Process "$install_root\deploy-collector.ps1" -verb runAs) > "$install_root\deploylog.log"
}