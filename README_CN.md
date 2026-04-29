# roboto_urdf

该仓库用于管理 RoboParty 项目的机器人 URDF 模型和视觉描述文件。

## 项目结构

- `urdf/`: 基础/通用 URDF 文件。
- `*_description/`: 通过子模块引入的具体机器人描述文件（例如 `atom01_description`）。
- `debian/`: Debian 包构建所需的元数据。
- `build_deb.sh`: 将模型打包为 `.deb` 文件的构建脚本。

## 安装

您可以直接安装预构建的包：
```bash
sudo apt install ./roboto-urdf_1.1.0_robopi1.deb
```
模型文件将被安装到 `/opt/roboparty/share/` 目录下。

## 从源码构建

如需手动构建 Debian 包：
```bash
./build_deb.sh [robopi1|robopi2]
```

## 子模块说明

本项目使用 Git 子模块来获取特定机器人的描述。初始化子模块：
```bash
git submodule update --init --recursive
```
