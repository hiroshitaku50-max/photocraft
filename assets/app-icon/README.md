# Nousara Image app icon

A rounded tile with a warm-to-cool gradient border (honey, coral, violet, teal) around a graphite
square carrying a cream "N". Drawn for Nousara Image; it replaces the upstream PhotoCraft kitsune.

The file names keep the upstream `photocraft*` / `ai.storyteller.photocraft*` names so the build
scripts and `include_bytes!` paths stay unchanged.

- `photocraft.svg` (master), `photocraft-small.svg`, `hicolor/scalable/apps/*.svg`: the vector tile.
- `hicolor/<size>/apps/*.png`: renders of the full tile.
- `photocraft-1024.png`, `photocraft.icns`: padded onto Apple's 824/1024 grid.
- `photocraft.ico`: 16–256 px for Windows.
