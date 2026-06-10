# Antigravity CLI

> [!NOTE]
> Google has announced that Antigravity CLI will replace Gemini CLI on 2026-07-18; see: [blog post](https://developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/)

Google's [Antigravity CLI](https://antigravity.google/product/antigravity-cli) (`agy`), which is a replacement of [Gemini CLI](https://geminicli.com/docs/) (`gemini`).

## 🤹 Installing agent skills

Antigravity CLI does not have commands for installing agent skills. Use the `skills` CLI ([vercel-labs/skills](https://www.npmjs.com/package/skills)):

```bash
$ skills add vercel-labs/agent-skills [--skill <skill-name>]
```

## 🛠️ Setting up MCP servers

Antigravity CLI does not have commands for setting up MCP servers. Open `~/.gemini/config/mcp_config.json` file and add MCP servers to it. For example,

```json
{
  "mcpServers": {
    "gcloud": {
      "command": "npx",
      "args": [
        "--yes",
        "@google-cloud/gcloud-mcp"
      ]
    }
  }
}
```

## 📚 Worth to look at

- [Configuring MCP Servers and Skills for Antigravity CLI and IDE](https://medium.com/google-cloud/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide-a938c7eebb78)
