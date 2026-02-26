# UE5 MCP Server Setup

讓 Claude Code 透過 MCP 協議直接操控 UE5 編輯器。

## 架構

```
Claude Code
  ↓ MCP (stdio)
FastMCP Python Server (unreal-mcp)
  ↓ TCP (port 55557)
UE5 C++ Plugin (UnrealMCP)
  ↓
UE5 Editor Subsystem
```

## 快速安裝

**macOS / Linux：**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows (PowerShell)：**
```powershell
.\setup.ps1
```

## 手動安裝

### 1. 前置需求

- [uv](https://docs.astral.sh/uv/) - Python 套件管理器
- [Claude Code](https://claude.ai/claude-code) - CLI 工具
- UE5 5.4+

### 2. 安裝 MCP Server

```bash
git clone https://github.com/chongdashu/unreal-mcp.git ~/unreal-mcp
cd ~/unreal-mcp/Python
uv sync --python 3.12
```

### 3. UE5 專案設定

將 `~/unreal-mcp/MCPGameProject/Plugins/UnrealMCP` 複製到你的 UE5 專案的 `Plugins/` 資料夾。

開啟 UE5 編輯器，確認以下插件已啟用：
- UnrealMCP（剛複製的）
- Remote Control（內建）

### 4. 設定 Claude Code

```bash
claude mcp add ue5 -- uv --directory ~/unreal-mcp/Python run unreal_mcp_server.py
```

### 5. 驗證

1. 啟動 UE5 編輯器（確認插件已載入）
2. 開啟新的 Claude Code session
3. 請 Claude 在場景中建立一個 Cube
4. 確認 UE5 編輯器中出現 Cube

## 功能

基於 [chongdashu/unreal-mcp](https://github.com/chongdashu/unreal-mcp)：

- 演員管理（建立/刪除/移動/旋轉）
- 藍圖開發（類別建立、組件配置）
- 編輯器控制（視口、攝影機）
- 資產查詢與管理
