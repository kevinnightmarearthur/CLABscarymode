# Scary Mode Toggle

Mod for [Cirno! Lifts a Boulder](https://store.steampowered.com/app/4173110/Cirno_Lifts_a_Boulder/) that lets you turn on the game's hidden April Fools scary mode when you want it. Uses Godot 4.6's native `override.cfg` + `autoload_prepend`

## Features

- **Scary Mode Anywhere** - the scary mode checkbox in Gameplay settings always shows up, not just on April 1
- **Still works after the jumpscare** - the option doesn't go away after you've seen it once

## Installation

1. Download `Scary-Mode-Toggle` from the recent releases
2. Put what's inside the zip into where Cirno! Lifts a Boulder is.
3. You should see `override.cfg` and `scarymode/` next to `Cirno! Lifts a Boulder.exe`
4. Launch the game and the mod should be loaded.

If you already have another mod with its own `override.cfg`, don't replace it. Add the `ScaryMode=` line under `[autoload_prepend]` in the one you have instead.

### Using it

1. On the main menu go to Options > Gameplay and check Scary Mode
2. Start the game

The checkbox is only on the main menu and turns off again when you restart the game. By the way, the game closes itself after the jumpscare since that's how the original April Fools mode works.

### Uninstall

Delete `override.cfg` (or just the `ScaryMode=` line) and the `scarymode/` folder from the game directory.

## License

MIT

## Notes

Report any issues to mediocurenightmare or yell at me in the [Cirno! runs a boulder](https://discord.gg/adP26e57p2) server on Discord.
