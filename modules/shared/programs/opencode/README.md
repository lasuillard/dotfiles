# [OpenCode](https://opencode.ai/)

See [official docs](https://opencode.ai/docs/ko) for configuration.

## 🔀 OpenRouter

OpenRouter is officially supported by OpenCode.

### 🎛️ Using preset as model

You can use [Free Models Router](https://openrouter.ai/docs/guides/routing/routers/free-router) but the task quality would significantly vary model by model.

You can OpenRouter Preset feature to select specific models you want. Open **~/.config/opencode/opencode.jsonc** file and add preset as custom model:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "openrouter": {
      "models": {
        "@preset/default": {}
      }
    }
  }
}
```
