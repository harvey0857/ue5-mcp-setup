# UE5 MCP Server Setup Script (Windows PowerShell)
$ErrorActionPreference = "Stop"

Write-Host "=== UE5 MCP Server Setup ===" -ForegroundColor Cyan
Write-Host ""

# 1. Check prerequisites
function Check-Command {
    param([string]$name, [string]$installHint)
    if (!(Get-Command $name -ErrorAction SilentlyContinue)) {
        Write-Host "[X] $name not found. Please install: $installHint" -ForegroundColor Red
        exit 1
    }
    Write-Host "[OK] $name installed" -ForegroundColor Green
}

Check-Command "git" "https://git-scm.com/"
Check-Command "uv" "https://docs.astral.sh/uv/"
Check-Command "claude" "npm install -g @anthropic-ai/claude-code"

Write-Host ""

# 2. Clone unreal-mcp
$InstallDir = Join-Path $env:USERPROFILE "unreal-mcp"
if (Test-Path $InstallDir) {
    Write-Host "[SKIP] $InstallDir already exists"
} else {
    Write-Host "[INFO] Cloning unreal-mcp..."
    git clone https://github.com/chongdashu/unreal-mcp.git $InstallDir
}

# 3. Install Python dependencies
Write-Host "[INFO] Installing Python dependencies..."
$PythonDir = Join-Path $InstallDir "Python"
Push-Location $PythonDir
uv sync --python 3.12
Pop-Location

# 4. Configure Claude Code MCP
Write-Host "[INFO] Configuring Claude Code MCP Server..."
claude mcp add ue5 -- uv --directory $PythonDir run unreal_mcp_server.py

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps (manual):"
Write-Host "1. Copy $InstallDir\MCPGameProject\Plugins\UnrealMCP"
Write-Host "   to your UE5 project's Plugins\ folder"
Write-Host "2. Open UE5 Editor, enable UnrealMCP plugin"
Write-Host "3. Start a new Claude Code session to use it"
Write-Host ""
Write-Host "Test: Ask Claude to create a Cube in the scene"
