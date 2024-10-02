# Define the GitHub URL for the MSI file
$msiUrl = "https://github.com/GoodwayGroup/IT-Deployment/blob/0296b650339ef29614be351368d112cd45be9477/fs-windows-agent-3.5.0.msi"

# Get the default temp folder path
$tempFolder = [System.IO.Path]::GetTempPath()

# Create path for the MSI file
$msiFileName = "fs-windows-agent-3.5.0.msi"
$msiPath = Join-Path -Path $tempFolder -ChildPath $msiFileName

# Download the MSI file
try {
    Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath
    Write-Host "MSI file downloaded successfully to: $msiPath"
} catch {
    Write-Error "Failed to download MSI file: $_"
    exit 1
}

# Silently install the MSI
try {
    $arguments = "/i `"$msiPath`" /qn /norestart"
    Start-Process "msiexec.exe" -ArgumentList $arguments -Wait -NoNewWindow
    Write-Host "MSI installed successfully"
} catch {
    Write-Error "Failed to install MSI: $_"
    exit 1
}
