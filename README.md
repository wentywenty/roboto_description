# roboto_description

This repository manages the unified robot URDF models and visual descriptions (meshes, MJCF, XML) for the RoboParty project.

## Project Structure

- `*_description/`: Submodules containing specific robot descriptions (e.g., `rpo_description`, `rp1_description`).
- `debian/`: Debian package metadata.

## Installation

You can install the pre-built package directly from the APT repository. The unified package provides assets for all robot models:
```bash
sudo apt update
sudo apt install roboto-description
```
The files will be installed to `/opt/roboparty/share/`.

## Submodules

This project uses Git submodules to pull in robot-specific descriptions. If you are developing locally, initialize them using:
```bash
git submodule update --init --recursive
```
