# 🔩 text-to-cad-muse

[English](README.md) | [中文](README.zh-CN.md)

**Muse 有一台远程电脑，为什么不用它做 CAD？**

[text-to-cad](https://github.com/earthtojake/text-to-cad) 给了 AI agent CAD
超能力：用一句话描述零件，拿回真正的 STEP 文件。很牛——但它是为跑在
*你自己机器上* 的 agent 设计的（Claude Code、Codex、Cursor…）：插件你装，
运行时你养，所有麻烦都在你本地电脑上。😮‍💨

但 Muse 不一样：每个 Muse 账号都自带一台远程电脑，有终端、有 Python、
能装软件、能跑程序。💻

那还装什么本地软件？🤔

**一台 Muse 远程电脑，就是一整间 CAD 工作室。** 🖥️

给 Muse 发句话——中文、英文，甚至语音都行。它在远程电脑上写参数化建模
脚本，把零件建出来，渲一张预览图发回聊天里给你检查——你只收两样东西：

- 🖼️ 预览图——直接在聊天里看模型，不用开任何软件
- 📦 STEP / STL / 3MF 文件——真正的工程文件，SolidWorks 能开，3D 打印机
  能直接切片

以前要装 CAD 软件、要学半天，现在**只要一个 Muse 账号，就够了**。云端建模，
手机上检查，零本地安装。☁️

更爽的是：**📱 手机上就能做 CAD。**
"一块 100×60×8 的铝板，四角打直径 6 的通孔"——一句话，零件带着预览图就
回来了。口袋里的 CAD 工作站，不用电脑。

这里的创新不是算法，而是**思路——一种全新的工作方式**。💡 Agent 写确定性的
参数化代码（[build123d](https://github.com/gumyr/build123d) + Open CASCADE
几何内核），远程机器执行，每次构建都以一张你肉眼能判断的预览图收尾。
说话 → 代码 → 零件 → 预览 → 迭代。

## 🛠️ 工作原理

```
你的一句话（中文/语音/截图）
  → Muse 写 build123d 参数化脚本
  → cadgen 本地执行，输出 STEP / STL / 3MF / GLB
  → snapshot 渲预览图，发回聊天
  → 你看图说"孔再大一点"，改几个数字重跑，一秒出新图
```

- **参数化，不是猜像素。** 每个模型都是带命名尺寸的 Python 脚本，改个数字，
  一秒重建，没有网格玄学。
- **聊天里看图。** 每次构建都附一张渲染预览图，不开软件就能验货，不对就
  直接说，继续迭代。
- **真文件交付。** STEP 给工程，STL 给打印——和 text-to-cad 一样的产物，
  减掉本地安装的麻烦。
- **默认关闭 telemetry。** `setup.sh` 会关掉 cadgen 的使用统计，你的零件
  只属于你。

## 🎯 定位：机械 CAD，不贪多

text-to-cad-muse 是**机械** CAD 工作站：参数化零件、工程图、STL 打印、STEP
制造。只守这一摊，不贪多：

| 活 | 归谁 |
|---|---|
| 机械零件与工程图 | ✅ 本项目 |
| 2D 符号图（电气原理图、科学示意图） | [scientific-illustrator-muse](https://github.com/song-squared/scientific-illustrator-muse) |
| 有机/艺术三维（人物、场景、照片级渲染） | [blender-for-muse](https://github.com/song-squared/blender-for-muse) |
| 建筑 BIM / 施工图 | ❌ 三个都不做——简单的体块示意可以 |

让它画电气图，它会请你出门右转。🙂

## 🚀 快速开始

```bash
git clone https://github.com/song-squared/text-to-cad-muse
cd text-to-cad-muse
./setup.sh        # 安装 uv + cadgen，校验 CAD 内核
./setup.sh check  # 随时体检，可重复跑
```

然后看 [QUICKSTART.zh-CN.md](QUICKSTART.zh-CN.md)——你的第一个零件只差一句话。
完整的 agent 工作手册在 [SKILL.md](SKILL.md)。

## 📐 示例

`examples/plate.py` —— 100×60×8 的板，四角 Ø6 通孔，中心 Ø20 通孔，
构建约 1 秒：

```bash
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 python examples/plate.py
# → STEP/plate.step, STL/plate.stl，外加一张聊天预览图
```

## 🙏 致谢

站在 [text-to-cad](https://github.com/earthtojake/text-to-cad)（MIT）
作者 [@earthtojake](https://github.com/earthtojake) 的肩膀上——skill 任务分发
表、装饰器模型契约、截图评审循环都是从那个项目移植的。CAD 内核是
[build123d](https://github.com/gumyr/build123d) +
[Open CASCADE](https://dev.opencascade.org)。本仓库是 Muse 远程适配版：
零本地安装、聊天原生预览、中文优先输入。

## 📄 许可证

MIT —— 见 [LICENSE](LICENSE)。
