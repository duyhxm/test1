param(
    [Parameter(Mandatory=$true)]
    [string]$sourcePath,
    [Parameter(Mandatory=$true)]
    [string]$destinationPath
)

if (-not (Test-Path -Path $sourcePath)) {
    Write-Host "Source path does not exist."
    exit
}

if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
}

if ((Get-Item $sourcePath).Extension -eq '.zip') {
    Expand-Archive -Path $sourcePath -DestinationPath $destinationPath -Force
    Write-Host "Extracted contents from $sourcePath to $destinationPath"
} elseif ((Get-Item $sourcePath).PSIsContainer) {
    Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
    Write-Host "Copied folder $sourcePath to $destinationPath"
} else {
    Write-Host "Unsupported file type. Only ZIP files and folders are supported."
}
