# Make Python virtual environment
# and install the required packages

# How to create updated requirements.txt:
# pip freeze > requirements.txt

$venvPath = './Python/venv'

Write-Host "Removing old venv..."
if (Test-Path -Path $venvPath) {
    Remove-Item $venvPath -Recurse -Force
}

Write-Host "Adding new venv..."
python -m venv $venvPath

Write-Host "Activating new venv..."
Invoke-Expression (Join-Path -Path $venvPath -ChildPath 'Scripts/Activate.ps1')

Write-Host "Installing dependencies..."
pip install -r ./Python/requirements.txt

Write-Host "`nRun 'deactivate' to quit venv`n"