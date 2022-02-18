Write-Output "`n:: Init Config:`n"

$sources_share = "\\pdc\sumologic"
$sources_local = "C:\Program Files\Sumo Logic Collector\Sources" #do not change unless required
$installation_token = "teststring"

Write-Output " Sources Network Share `t`t: $sources_share `n Local Source Directory `t: $sources_local `n Installation Token `t`t: $installation_token"

# >>> Init

New-Item -Path $sources_local -ItemType Directory
$sources_arg = $sources_local.Replace('\','\\')  # As the Installation Path Needs  DOUBLE BACKSLASH ONLY OR INSTALL WILL FAIL

# Check Current System
Write-Output "`n:: System Check`n"
Write-Output "Sources: "

#Query for Active Directory
(sc.exe query NTDS) > $null
if ( $LASTEXITCODE -eq 0)
{
    Copy-Item -Path "$sources_share\AD.json" -Destination
    Write-Output "Active Directory Found"
}

Copy-Item -Path "$sources_share\Windows.json" -Destination
Write-Output "Windows Log Source"

# Download Sumo Logic Agent from Static Url.
Write-Output "`n:: Deploy SumoLogic Agent..`n"
wget -usebasicparsing -Uri https://collectors.eu.sumologic.com/rest/download/win64 -OutFile sumologic.exe
.\sumologic.exe -console -q "-Vsumo.token_and_url=$installation_token" "-Vsources=$sources_arg"