# Nemo Actions Collection

A collection of custom actions for the Nemo file manager in Linux.

## Description

This repository contains a set of scripts and configuration files to extend the functionality of the Nemo file manager. Actions include archive operations, audio conversion, and other useful features.

## Installation

### Option 1: Using the built-in installer (recommended)

Use the installer script that will be added to this repository in the future. This is the easiest installation method.

### Option 2: Manual installation

1. Clone the repository:
```bash
git clone https://github.com/bwowan/vb-nemo-actions.git
```

2. Copy files to the Nemo actions directory:

   **For current user only:**
   ```bash
   cp -r vb-nemo-actions/* ~/.local/share/nemo/actions/
   chmod +x ~/.local/share/nemo/actions/scripts/*.sh
   ```

   **For all system users (requires sudo):**
   ```bash
   sudo cp -r vb-nemo-actions/* /usr/share/nemo/actions/
   sudo chmod +x /usr/share/nemo/actions/scripts/*.sh
   ```

3. Restart Nemo to apply changes.

## Available Actions

### Archiving

- **Store to ZIP** / **Сохранить в ZIP** - Store files into ZIP archive without compression
- **Create 7Z** / **Создать 7Z** - Create 7Z archive with maximum compression
- **Extract archive** / **Распаковать архив** - Extract 7Z, RAR, ZIP, GZ, TAR archives
- **List archive** / **Список архива** - List files in archives

### Audio

- **Convert --> AAC** / **Конвертировать --> AAC** - Convert audio to AAC file format
- **Extract to OPUS** / **Извлечь в OPUS** - Extract audio and save to OPUS file format
- **Extract AAC** / **Извлечь AAC** - Extract AAC audio channel by copying (very fast)

### Other

- **Generate Playlist** / **Создать плейлист** - Generate playlist from selected files

## Project Structure

```
.
├── README.md                    # This file
├── *.nemo_action               # Action configuration files
└── scripts/                    # Scripts executed by actions
    ├── archive_create_7z.sh     # Create 7Z archive
    ├── archive_extract.sh       # Extract archives
    ├── archive_store_zip.sh     # Create ZIP archive
    ├── convert_to_aac.sh        # Convert to AAC
    ├── extract_aac.sh           # Extract AAC
    ├── extract_opus.sh          # Extract to OPUS
    ├── gen_pl.sh                # Generate playlist
    ├── notify_out.sh            # Notifications for completed operations
    └── zenity_select.sh         # Utility for selecting from list via zenity
```

## Dependencies

The following programs are required for actions to work:

- **7zz** (7-Zip) - for archive operations
- **ffmpeg** - for audio conversion and extraction
- **zenity** - for graphical dialogs
- **bash** - script interpreter

Install dependencies (Ubuntu/Debian):
```bash
sudo apt-get install p7zip-full ffmpeg zenity
```

## Usage

After installation, actions will be available in the Nemo context menu when selecting appropriate files or folders.

### Usage Examples

1. **Archive files**: Select files → Right-click → "Store to ZIP" or "Create 7Z"
2. **Extract archive**: Select archive → Right-click → "Extract archive"
3. **Convert audio**: Select audio file → Right-click → "Convert --> AAC"
4. **Create playlist**: Select music folder → Right-click → "Generate Playlist"

## Localization

All actions support Russian and English languages. Translations are specified in `Name[ru]` and `Comment[ru]` parameters in `.nemo_action` files.

## Development

### Adding a New Action

1. Create a script in the `scripts/` directory
2. Create a `.nemo_action` file with action configuration
3. Add `Name[ru]` and `Comment[ru]` translations for Russian language support

### .nemo_action File Structure

```ini
[Nemo Action]
Name=Action Name
Name[ru]=Название действия
Comment=Action description
Comment[ru]=Описание действия
Icon-Name=icon-name
Extensions=ext1;ext2;
Selection=Any
Quote=double
Terminal=true
Exec=<scripts/your_script.sh %F>
```

## License
Free

## Author
vladimir.balabanov@gmail.com


## Support

If you encounter any issues, please create an issue in the GitHub repository.
