# 🔩 text-to-cad-muse

[English](README.md) | [中文](README.zh-CN.md)

**Muse has a remote computer. Why not do CAD on it?**

[text-to-cad](https://github.com/earthtojake/text-to-cad) gave AI agents CAD
superpowers: describe a part in words, get back real STEP files. Brilliant —
but it's built for agents running on *your* machine (Claude Code, Codex,
Cursor…): you install the plugin, you keep the runtime warm, all the hassle
lives on your computer. 😮‍💨

But Muse? Every Muse account comes with a remote computer. Terminal, Python,
installs software, runs programs. 💻

So why install anything locally at all? 🤔

**One Muse remote computer is the entire CAD workstation.** 🖥️

Send Muse a message — in Chinese, in English, even a voice note. It writes the
parametric modeling script on its remote computer, builds the part, renders a
preview for you to inspect in chat — you just collect two things:

- 🖼️ Preview PNGs — inspect the model right in chat, no software needed
- 📦 STEP / STL / 3MF files — real engineering files, open them in SolidWorks
  or send them straight to the 3D printer

What used to need a CAD install plus learning curve now takes **one Muse
account. That's it.** Model in the cloud, check on your phone, zero local
installs. ☁️

Even better: **📱 you can do CAD from your phone.**
"一块 100×60×8 的铝板，四角打直径 6 的通孔" — one sentence, and the part
comes back with a preview render. A pocket CAD workstation, no computer needed.

That's the innovation here: not algorithmic, but **conceptual — a new way of
working**. 💡 The agent writes deterministic parametric code
([build123d](https://github.com/gumyr/build123d) on Open CASCADE), the remote
machine executes it, and every build ends with a picture you can judge with
your own eyes. Talk → code → part → preview → iterate.

## 🛠️ What it does

```
你的一句话（中文/语音/截图）
  → Muse 写 build123d 参数化脚本
  → cadgen 本地执行，输出 STEP / STL / 3MF / GLB
  → snapshot 渲预览图，发回聊天
  → 你看图说"孔再大一点"，改几个数字重跑，一秒出新图
```

- **Parametric, not pixels.** Every model is a Python script with named
  dimensions. Change a number, rebuild in ~1 second. No mesh guessing.
- **Preview in chat.** Every build ends with a rendered PNG you inspect
  without opening any software. Wrong? Say so, iterate.
- **Real files out.** STEP for engineering, STL for printing — the same
  artifacts text-to-cad produces, minus the local setup.
- **Telemetry off by default.** `setup.sh` disables cadgen's usage stats.
  Your parts stay yours.

## 🚀 Quickstart

```bash
git clone https://github.com/song-squared/text-to-cad-muse
cd text-to-cad-muse
./setup.sh        # installs uv + cadgen, verifies the CAD kernel
./setup.sh check  # re-run safe health check
```

Then follow [QUICKSTART.md](QUICKSTART.md) — your first part is one sentence
away. The full agent playbook lives in [SKILL.md](SKILL.md).

## 📐 Example

`examples/plate.py` — a 100×60×8 plate, four Ø6 through-holes at the corners,
one Ø20 through-hole in the center. Builds in ~1 second:

```bash
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 python examples/plate.py
# → STEP/plate.step, STL/plate.stl, plus a chat-ready preview PNG
```

## 🙏 Credits

Built on the shoulders of [text-to-cad](https://github.com/earthtojake/text-to-cad)
(MIT) by [@earthtojake](https://github.com/earthtojake) — the skill/task-table
design, the decorator model contract, and the snapshot-review loop are all
ported from that project. The CAD kernel is
[build123d](https://github.com/gumyr/build123d) on
[Open CASCADE](https://dev.opencascade.org). This repo is the Muse-remote
adaptation: no local install, chat-native previews, Chinese-first input.

## 📄 License

MIT — see [LICENSE](LICENSE).
