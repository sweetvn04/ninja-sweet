# 🥷 Ninja Sweet Project

Ninja Sweet is a unified, Dockerized game server project. This repository contains the complete setup including the game server, database, and configurations.

## 🚀 Quick Start

1. **Prerequisites:** Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).
2. **Build and Run:**
   ```bash
   docker compose up -d --build
   ```

## 📁 Project Structure

- `game-server/`: Java source code and Dockerfile (Maven multi-stage build).
- `database/`: MariaDB setup with automatic SQL initialization.
- `game-data/`: Persistent configuration and static game resources.
- `database-data/`: (Generated) Persistent database storage.

## ⚙️ Configuration

Edit `game-data/config.properties` to change server settings such as IP, ports, and game rates.

## 🛠️ Development

To modify the game logic:
1. Edit files in `game-server/src/`.
2. Run `docker compose up -d --build` to recompile and restart.

---
*Note: This project is for educational and development purposes.*
