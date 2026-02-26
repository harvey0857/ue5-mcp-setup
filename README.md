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

## Windows 安裝教學

### 1. 安裝前置工具

- **Git**: https://git-scm.com/download/win
- **Node.js**: https://nodejs.org/
- **uv** (Python 套件管理器)：開 PowerShell 執行：
  ```powershell
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  ```
- **Claude Code**：
  ```powershell
  npm install -g @anthropic-ai/claude-code
  ```

### 2. 一鍵安裝

```powershell
git clone https://github.com/harvey0857/ue5-mcp-setup.git
cd ue5-mcp-setup
.\setup.ps1
```

腳本會自動：
- Clone [chongdashu/unreal-mcp](https://github.com/chongdashu/unreal-mcp) 到 `%USERPROFILE%\unreal-mcp`
- 用 uv 安裝 Python 依賴
- 設定 Claude Code 的 MCP 連線

### 3. UE5 插件安裝（手動）

將 `%USERPROFILE%\unreal-mcp\MCPGameProject\Plugins\UnrealMCP` 整個資料夾複製到你的 UE5 專案的 `Plugins\` 下。

開啟 UE5 編輯器，到 **Edit → Plugins** 確認 **UnrealMCP** 已啟用。

### 4. 驗證

1. 開啟 UE5 編輯器（確認插件已載入）
2. 開一個新的 Claude Code session
3. 請 Claude 在場景中建立一個 Cube
4. 確認 UE5 編輯器中出現 Cube

---

## macOS / Linux 安裝

### 前置工具

- **uv**：`curl -LsSf https://astral.sh/uv/install.sh | sh`
- **Claude Code**：`npm install -g @anthropic-ai/claude-code`

### 安裝

```bash
git clone https://github.com/harvey0857/ue5-mcp-setup.git
cd ue5-mcp-setup
chmod +x setup.sh
./setup.sh
```

後續步驟同 Windows 的步驟 3、4。

---

## 功能

基於 [chongdashu/unreal-mcp](https://github.com/chongdashu/unreal-mcp)：

- 演員管理（建立/刪除/移動/旋轉）
- 藍圖開發（類別建立、組件配置）
- 編輯器控制（視口、攝影機）
- 資產查詢與管理
