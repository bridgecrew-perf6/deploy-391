wget -usebasicparsing -Uri https://collectors.eu.sumologic.com/rest/download/win64 -OutFile sumologic.exe
.\sumologic.exe -console -q "-Vsumo.token_and_url=U1VNT1RXRUhjVEVVVE5zMWRLdlQ5dWJ1N0ZSSGNTbGJodHRwczovL2NvbGxlY3RvcnMuZGUuc3Vtb2xvZ2ljLmNvbQ==" "-Vsources=sources.json"
