# roboto_urdf

This repository manages the robot URDF models and visual descriptions for the RoboParty project.

## Project Structure

- `urdf/`: Legacy/Common URDF files.
- `*_description/`: Submodules containing specific robot descriptions (e.g., `atom01_description`).
- `debian/`: Debian package metadata.
- `build_deb.sh`: Script to package the models into a `.deb` file.

## Installation

You can install the pre-built package:
```bash
sudo apt install ./roboto-urdf_1.1.0_robopi1.deb
```
The files will be installed to `/opt/roboparty/share/`.

## Building from Source

To build the Debian package manually:
```bash
./build_deb.sh [robopi1|robopi2]
```

## Submodules

This project uses Git submodules to pull in robot-specific descriptions. To initialize them:
```bash
git submodule update --init --recursive
```
