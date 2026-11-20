$ErrorActionPreference = "Stop"

$nodeVersion = "v20.12.2"
$nodeZip = "node-$nodeVersion-win-x64.zip"
$nodeUrl = "https://nodejs.org/dist/$nodeVersion/$nodeZip"
$nodeDir = "C:\Users\vh142\.gemini\antigravity\scratch\node"
$nodePath = "$nodeDir\node-$nodeVersion-win-x64"

if (!(Test-Path -Path $nodePath\node.exe)) {
    Write-Host "Baixando o Node.js ($nodeVersion)..."
    Invoke-WebRequest -Uri $nodeUrl -OutFile "$PWD\$nodeZip"
    
    Write-Host "Extraindo o Node.js..."
    if (!(Test-Path -Path $nodeDir)) {
        New-Item -ItemType Directory -Path $nodeDir | Out-Null
    }
    Expand-Archive -Path "$PWD\$nodeZip" -DestinationPath $nodeDir -Force
    
    Write-Host "Limpando arquivos temporarios..."
    Remove-Item "$PWD\$nodeZip"
}

Write-Host "Configurando ambiente..."
$env:PATH = "$nodePath;" + $env:PATH

Write-Host "Verificando Node.js:"
node -v
npm -v

Write-Host "Instalando dependencias (npm install)..."
npm install

Write-Host "Iniciando servidor de desenvolvimento..."
npm run dev
