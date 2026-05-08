# roboto_description

该仓库用于集中管理 RoboParty 项目的统一机器人 URDF 模型、网格(meshes)和外观仿真文件(MJCF)。

## 项目结构

- `*_description/`: 通过子模块引入的具体机器人描述库（例如 `rpo_description`, `rp1_description`）。
- `debian/`: Debian 包构建所需的元数据设置。

## 安装

由于现已采用大一统构建，您可以直接从 APT 源安装即可获取所有机器人类型的模型资源：
```bash
sudo apt update
sudo apt install roboto-description
```
所有的模型文件均会被安装至目标机的 `/opt/roboparty/share/` 目录下。

## 子模块说明

本项目使用 Git 子模块来同步获取特定机器人的源码库。检出本库后，如需修改调试描述文件，请先初始化子模块：
```bash
git submodule update --init --recursive
```
