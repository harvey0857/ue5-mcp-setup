#!/bin/bash
set -e

echo "=== UE5 MCP Server 安裝腳本 ==="
echo ""

# 1. 檢查前置工具
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ 找不到 $1，請先安裝"
        echo "   $2"
        exit 1
    fi
    echo "✅ $1 已安裝"
}

check_command "git" "https://git-scm.com/"
check_command "uv" "curl -LsSf https://astral.sh/uv/install.sh | sh"
check_command "claude" "npm install -g @anthropic-ai/claude-code"

echo ""

# 2. Clone unreal-mcp
INSTALL_DIR="$HOME/unreal-mcp"
if [ -d "$INSTALL_DIR" ]; then
    echo "📁 $INSTALL_DIR 已存在，跳過 clone"
else
    echo "📥 Cloning unreal-mcp..."
    git clone https://github.com/chongdashu/unreal-mcp.git "$INSTALL_DIR"
fi

# 3. 安裝 Python 依賴
echo "📦 安裝 Python 依賴..."
cd "$INSTALL_DIR/Python"
uv sync --python 3.12

# 4. 設定 Claude Code MCP
echo "🔧 設定 Claude Code MCP Server..."
claude mcp add ue5 -- uv --directory "$INSTALL_DIR/Python" run unreal_mcp_server.py

echo ""
echo "=== ✅ 安裝完成 ==="
echo ""
echo "接下來你需要手動完成："
echo "1. 把 $INSTALL_DIR/MCPGameProject/Plugins/UnrealMCP"
echo "   複製到你的 UE5 專案的 Plugins/ 資料夾"
echo "2. 開啟 UE5 編輯器，確認 UnrealMCP 插件已啟用"
echo "3. 啟動新的 Claude Code session 即可使用"
echo ""
echo "測試方式：在 Claude Code 中請 Claude 在場景中建立一個 Cube"
