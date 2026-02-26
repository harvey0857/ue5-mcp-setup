# UE5 MCP Server 安裝腳本 (Windows PowerShell)
$ErrorActionPreference = "Stop"

Write-Host "=== UE5 MCP Server 安裝腳本 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 檢查前置工具
function Check-Command($name, $installHint) {
    if (!(Get-Command $name -ErrorAction SilentlyContinue)) {
        Write-Host "❌ 找不到 $name，請先安裝" -ForegroundColor Red
        Write-Host "   $installHint"
        exit 1
    }
    Write-Host "✅ $name 已安裝" -ForegroundColor Green
}

Check-Command "git" "https://git-scm.com/"
Check-Command "uv" "powershell -ExecutionPolicy ByPass -c `"irm https://astral.sh/uv/install.ps1 | iex`""
Check-Command "claude" "npm install -g @anthropic-ai/claude-code"

Write-Host ""

# 2. Clone unreal-mcp
$InstallDir = "$env:USERPROFILE\unreal-mcp"
if (Test-Path $InstallDir) {
    Write-Host "📁 $InstallDir 已存在，跳過 clone"
} else {
    Write-Host "📥 Cloning unreal-mcp..."
    git clone https://github.com/chongdashu/unreal-mcp.git $InstallDir
}

# 3. 安裝 Python 依賴
Write-Host "📦 安裝 Python 依賴..."
Push-Location "$InstallDir\Python"
uv sync --python 3.12
Pop-Location

# 4. 設定 Claude Code MCP
Write-Host "🔧 設定 Claude Code MCP Server..."
claude mcp add ue5 -- uv --directory "$InstallDir\Python" run unreal_mcp_server.py

Write-Host ""
Write-Host "=== ✅ 安裝完成 ===" -ForegroundColor Green
Write-Host ""
Write-Host "接下來你需要手動完成："
Write-Host "1. 把 $InstallDir\MCPGameProject\Plugins\UnrealMCP"
Write-Host "   複製到你的 UE5 專案的 Plugins\ 資料夾"
Write-Host "2. 開啟 UE5 編輯器，確認 UnrealMCP 插件已啟用"
Write-Host "3. 啟動新的 Claude Code session 即可使用"
Write-Host ""
Write-Host "測試方式：在 Claude Code 中請 Claude 在場景中建立一個 Cube"
