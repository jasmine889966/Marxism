# Marxism

**规则代理工具 · 由 Hako 驱动**

[English](README.md) · 简体中文

基于 TokenPLS/Hako-Client 的 Apple 原生规则代理客户端衍生版本，覆盖 iPhone、
iPad、Mac 和 Apple TV。使用苏联历史视觉、马克思、恩格斯、列宁同向肖像与标准苏联锤镰符号、深红导航与暖白界面，
保留原项目的配置、订阅、代理、规则、DNS、流量、日志与隧道能力。

**This project is a modified derivative of TokenPLS/Hako-Client.**
**Licensed under GPL-3.0.** 本项目不是上游官方版本，不代表任何政府或政治组织。

![Mac 首页：无签名开发构建](docs/screenshots/macos-home-en.png)

[查看英文多平台截图](README.md#native-on-every-screen)。截图来自实际运行的开发构建；缺少共享容器时如实显示不可用，不伪造连接或流量。

## 换肤内容

- 统一明暗主题、深红侧栏、原生列表和紧凑卡片。
- 首页整合品牌、主标语、真实配置状态和操作；关于页保留列宁的电气化引文。
- 标语遵循现有简体中文、繁体中文和英文语言设置，无额外语言选择器。
- 各平台图标、菜单栏、扩展和小组件品牌更新。
- 独立安装标识 `io.github.jasmine889966.marxism`；原有导入格式与 URL scheme 保持兼容。
- 修复无签名构建启动时 CloudKit 容器初始化崩溃：能力缺失时返回已有不可用状态。

历史标语不是网络安全承诺。用户订阅中的名称、旗帜和配置内容保持原样。
详细出处和视觉规范见[品牌说明](docs/BRANDING.md)。

## 构建与验证

基线为上游提交 `b05832246fcac69d13ff16df871a8d53fd394c10`，内核及 Adapter
版本由 `Dependencies.lock.json` 固定。构建需要完整 Xcode、XcodeGen、Python 3、Go。
完整命令及签名步骤见[英文 README](README.md#build-from-source)。

```sh
git clone https://github.com/jasmine889966/Marxism.git
cd Marxism
python3 -m venv .build/python-env
source .build/python-env/bin/activate
python3 -m pip install PyYAML
python3 scripts/bootstrap.py
python3 scripts/configure.py
./script/build_and_run.sh --verify
```

本地 Mac 脚本默认使用 Xcode-beta，可用 `DEVELOPER_DIR` 指定自己的完整 Xcode。
无签名构建用于编译和界面检查，无法代替具备 Apple 团队签名与对应能力的隧道运行验证。
自己的 App Group、iCloud 容器和 Network Extension 必须一并配置，不自动迁移上游私有数据。

- [源码功能地图](docs/UI-INVENTORY.md)
- [验证结果与待验证范围](docs/VERIFICATION.md)
- [上游客户端](https://github.com/TokenPLS/Hako-Client)
- [Hako 内核](https://github.com/TokenPLS/Hako) · [Hako Adapter](https://github.com/TokenPLS/Hako-Adapter)

## 开源许可

保留 [GPL-3.0](LICENSE)、上游版权、第三方资源许可与致谢。品牌资源分别保留 CC BY-SA 4.0（肖像及衍生图标）与 CC0（锤镰符号），新增源码采用 GPL-3.0。本轮提供公开源码，不包含 App Store 提交或签名安装包发布。
