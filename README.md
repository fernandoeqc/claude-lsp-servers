# claude-lsp-servers

LSP plugin for [Claude Code](https://claude.ai/code) — TypeScript, Python, Go, and C/C++ (ESP-IDF)

## Prerequisites

### 1. Enable LSP Tool

```bash
export ENABLE_LSP_TOOL=1  # Add to your shell profile
```

### 2. Install Language Servers

```bash
# TypeScript/JavaScript
npm install -g typescript-language-server typescript

# Python
npm install -g pyright

# Go
go install golang.org/x/tools/gopls@latest

# C/C++ with ESP-IDF — see section below
```

## Installation

```bash
claude plugin marketplace add fernandoeqc/claude-lsp-servers
claude plugin install lsp-servers@claude-lsp-servers
```

Restart Claude Code.

## C/C++ with ESP-IDF

Code intelligence for ESP-IDF projects using esp-clang. Supports all ESP32 variants:
- **xtensa**: ESP32, ESP32-S2, ESP32-S3
- **riscv32**: ESP32-C3, ESP32-C6, ESP32-H2, ESP32-P4

### Prerequisites

**1. Install esp-clang** via ESP-IDF tools:

```bash
idf_tools.py install esp-clang
```

**2. Create `compile_commands.json`** at your project root pointing to your build directory:

```bash
# After building (e.g. for board B):
ln -sf build-esp32s3-b/compile_commands.json compile_commands.json
```

For multi-board projects, add this to your build script so it updates automatically on each build.

### Custom ESP-IDF path

If your ESP-IDF tools are not in `~/.espressif`, set the `ESPRESSIF_DIR` environment variable:

```bash
export ESPRESSIF_DIR=/custom/path/to/espressif
```

## Verify

Run `/plugin` — you should see `lsp-servers@claude-lsp-servers` without errors.

## Features

| Operation | Description |
|-----------|-------------|
| `hover` | Type info and docs |
| `goToDefinition` | Jump to definitions |
| `findReferences` | Find all usages |
| `documentSymbol` | List symbols in file |
| `goToImplementation` | Find implementations |
| `incomingCalls` | What calls this |
| `outgoingCalls` | What this calls |

## Troubleshooting

**"No LSP server available"** — Set `ENABLE_LSP_TOOL=1` and restart.

**"Executable not found"** — Install the language server binary.

**ESP-IDF: "esp-clang not found"** — Run `idf_tools.py install esp-clang`.

**ESP-IDF: errors/missing includes** — Make sure `compile_commands.json` exists at your project root and points to a valid build directory.

**Debug mode** — `claude --enable-lsp-logging`

## License

MIT
