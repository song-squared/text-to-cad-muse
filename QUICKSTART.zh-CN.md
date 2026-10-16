# QUICKSTART — text-to-cad-muse

[English](QUICKSTART.md) | [中文](QUICKSTART.zh-CN.md)

约 5 分钟，从零到你的第一个 CAD 零件。

## 1. 安装（一行命令）

```bash
./setup.sh
```

装 [uv](https://docs.astral.sh/uv/)（没有才装）、用 `uvx` 锁定
`cadgen==0.7.21`、**关闭 telemetry**，最后跑 `cadgen doctor` 确认
Open CASCADE 内核加载成功。

可重复跑：`./setup.sh check` 只体检，不重装。

## 2. 构建示例零件

```bash
export PATH="$HOME/.local/bin:$PATH"
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 python examples/plate.py
```

得到：

- `STEP/plate.step` —— 工程文件（SolidWorks 可开）
- `STL/plate.stl` —— 3D 打印文件

…再渲一张聊天预览图：

```bash
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 cadgen snapshot STEP/plate.step preview/plate.png
```

## 3. 描述你自己的零件

模型就是一个普通 Python 脚本：一个 `@step` 装饰的函数，返回 build123d
几何体。抄 `examples/plate.py`，改数字，跑。

```
"一块 100×60×8 的铝板，四角打直径 6 的通孔"
  → agent 写脚本 → 构建 → 发你 STEP + 预览图
  → "孔再大一点" → 改两个数字 → 一秒重建
```

毫米、XY 平面、+Z 朝上，实体保持闭合正体积。完整玩法看
[SKILL.md](SKILL.md)（任务分发表、建模铁律、修复循环、中文输入处理）。

## 排错

| 现象 | 解法 |
|---|---|
| `uv: command not found` | `export PATH="$HOME/.local/bin:$PATH"`（setup.sh 会提示） |
| `cadgen doctor` 内核 FAIL | 重跑 `./setup.sh`；首次运行需要联网（下载 CAD 运行时） |
| 第一次很慢 | 正常——Python 3.13 + cadgen + OCC 只下载一次，之后缓存 |
| 预览图不对 | 先查脚本尺寸；预览渲的是已保存的文件，不是源码 |
| VM 重启后 cadgen 罢工 | 跑 `./setup.sh check`；FAIL 就重跑 `./setup.sh`——所有东西都在 `~` 下，文件不丢 |
