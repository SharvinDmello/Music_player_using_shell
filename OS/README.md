# 🎧 Terminal Music Player

A lightweight, terminal-based music player script for Linux/Unix environments. It provides a simple menu-driven interface to search, play, and manage your music library using `mpv` and `fzf`.

## 🚀 Features

- **Search & Play**: Use `fzf` to quickly find and play any MP3 file in your music directory.
- **Shuffle Play**: Play all songs in your library in a random order.
- **Favorites System**: Bookmark your favorite songs and play them in shuffle mode.
- **Sleep Timer**: Set a timer (in minutes) to automatically stop the music after you've started playing a song.
- **Desktop Notifications**: Uses `notify-send` to show the currently playing song title.

## 📋 Prerequisites

Ensure you have the following dependencies installed on your system:

- **mpv**: The core media player engine.
- **fzf**: Command-line fuzzy finder for song selection.
- **libnotify**: For `notify-send` (optional, for notifications).
- **findutils**: For the `find` command.
- **coreutils**: For `shuf` and `basename`.

On Ubuntu/Debian, you can install them via:
```bash
sudo apt update
sudo apt install mpv fzf libnotify-bin
```

## ⚙️ Setup

The script uses a default music directory. You should update this path in the script to point to your music collection:

1. Open `music_player.sh`.
2. Locate the line:
   ```bash
   MUSIC_DIR="/c/Users/sharvin/Music/SONGS"
   ```
3. Change the path to your actual music directory.

## 📖 Usage

1. Make the script executable:
   ```bash
   chmod +x music_player.sh
   ```
2. Run the script:
   ```bash
   ./music_player.sh
   ```
3. Follow the on-screen menu to select your desired option.

## ⌨️ Controls (within mpv)

While a song is playing:
- `Space`: Pause/Play
- `q`: Stop playing current song and return to menu
- `9` / `0`: Volume down / Volume up
