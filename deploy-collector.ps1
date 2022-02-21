Write-Output "`n:: Init Config:`n"

$sources_share = "\\pdc\sumologic"
$sources_local = "C:\Program Files\Sumo Logic Collector\Sources" #do not change unless required
$installation_token = "teststring"

Write-Output " Sources Network Share `t`t: $sources_share `n Local Source Directory `t: $sources_local `n Installation Token `t`t: $installation_token"

# Download Sumo Logic Agent from Static Url.
Write-Output "`n:: Deploy SumoLogic Agent..`n"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(get -usebasicparsing -Uri https://collectors.eu.sumologic.com/rest/download/win64 -OutFile sumologic.exe) > $null 2> $null

.\sumologic.exe -console -q "-Vsumo.token_and_url=$installation_token" "-Vsources=$sources_arg"