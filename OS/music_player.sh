#!/bin/sh

MUSIC_DIR="/c/Users/sharvin/Music/SONGS"
declare -a favorites=()

play_direct() {
    echo "Searching in $MUSIC_DIR..."
    selected=$(find "$MUSIC_DIR" -type f -iname "*.mp3" | fzf)
    if [[ -n "$selected" ]]; then
        notify-send "Now Playing" "$(basename "$selected")"
        mpv --no-video "$selected"
    else
        echo "No song selected."
    fi
}

shuffle_play() {
    echo "Shuffling songs..."
    find "$MUSIC_DIR" -type f -iname "*.mp3" | shuf | while read -r song; do
        notify-send "Now Playing" "$(basename "$song")"
        mpv --no-video "$song"
    done
}

add_to_favorites() {
    echo "Select songs to add to favorites (TAB to mark, ENTER to confirm):"
    selected=$(find "$MUSIC_DIR" -type f -iname "*.mp3" | fzf -m)
    if [[ -n "$selected" ]]; then
        while IFS= read -r song; do
            if [[ ! " ${favorites[*]} " =~ " ${song} " ]]; then
                favorites+=("$song")
            fi
        done <<< "$selected"
        echo "Favorites updated!"
    else
        echo "No songs selected."
    fi
}

play_favorites() {
    if [[ ${#favorites[@]} -eq 0 ]]; then
        echo "No favorites added yet!"
    else
        printf "%s\n" "${favorites[@]}" | shuf | while read -r song; do
            notify-send "Now Playing (Fav)" "$(basename "$song")"
            mpv --no-video "$song"
        done
    fi
}

sleep_timer_with_play() {
    read -p "Set sleep timer (in minutes): " mins
    echo "You have $mins minute(s) before music stops."

    selected=$(find "$MUSIC_DIR" -type f -iname "*.mp3" | fzf)
    if [[ -z "$selected" ]]; then
        echo "No song selected. Cancelling..."
        return
    fi

    notify-send "Now Playing (Sleep Timer)" "$(basename "$selected")"
    mpv --no-video "$selected" &  # Run mpv in background
    PLAYER_PID=$!

    sleep "$((mins * 60))"
    kill "$PLAYER_PID" 2>/dev/null && notify-send "Sleep Timer" "Timer ended. Music stopped."
}

# Main Menu
while true; do
    echo ""
    echo "=== 🎧 Terminal Music Player ==="
    echo "1. Search & Play a Song"
    echo "2. Shuffle Play All Songs"
    echo "3. Add Songs to Favorites"
    echo "4. Play Favorites"
    echo "5. Set Sleep Timer and Play Song"
    echo "6. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) play_direct ;;
        2) shuffle_play ;;
        3) add_to_favorites ;;
        4) play_favorites ;;
        5) sleep_timer_with_play ;;
        6) echo "Goodbye 🎵"; break ;;
        *) echo "Invalid choice. Try again!" ;;
    esac
done

