$ErrorActionPreference = 'Stop'

$projectDirectory = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Push-Location -LiteralPath $projectDirectory
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao obter dependências.' }

    flutter analyze
    if ($LASTEXITCODE -ne 0) { throw 'A análise do projeto falhou.' }

    flutter build apk --release
    if ($LASTEXITCODE -ne 0) { throw 'A compilação do APK falhou.' }

    $apkSource = Join-Path $projectDirectory 'build\app\outputs\flutter-apk\app-release.apk'
    if (-not (Test-Path -LiteralPath $apkSource -PathType Leaf)) {
        throw 'O APK compilado não foi encontrado.'
    }
    $apkDestinationDirectory = Join-Path $projectDirectory 'apk'
    $apkDestination = Join-Path $apkDestinationDirectory 'brick-breaker.apk'
    New-Item -ItemType Directory -Force -Path $apkDestinationDirectory | Out-Null
    Copy-Item -LiteralPath $apkSource -Destination $apkDestination -Force
    Write-Host "APK pronto em: $apkDestination"
} finally {
    Pop-Location
}
