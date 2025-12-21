# Nemo Actions Collection

A collection of custom actions for the Nemo file manager in Linux.

## Description

This repository contains a set of scripts and configuration files to extend the functionality of the Nemo file manager. Actions include archive operations, audio conversion, and other useful features.

## Installation

### Option 1: Using the Debian package (recommended)

Build and install the Debian package using the provided installation script:

1. Clone the repository:
```bash
git clone https://github.com/bwowan/vb-nemo-actions.git
cd vb-nemo-actions
```

2. Run the installation script to build the DEB package:
```bash
chmod +x make_deb.sh
./make_deb.sh
```

This will create `some-nemo-extensions.deb` in the current directory.

3. Install the package:
```bash
sudo dpkg -i some-nemo-extensions.deb
```

If there are dependency issues, fix them with:
```bash
sudo apt-get install -f
```

4. Restart Nemo to apply changes.

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

## Building the Debian Package

The `make_deb.sh` script automates the creation of a Debian package. Here's what it does:

1. Creates a temporary `install` directory structure
2. Copies all `.nemo_action` files and the `scripts/` directory to `usr/share/nemo/actions/`
3. Creates the `DEBIAN` folder with `control` and `postinst` files
4. Builds the `.deb` package using `dpkg-deb`
5. Cleans up temporary files, leaving only the `.deb` file

### Using make_deb.sh

**Prerequisites:**
- `dpkg-deb` must be installed (usually included with `dpkg-dev` package)
- Bash shell

**Usage:**
```bash
./make_deb.sh
```

The script will:
- Create `some-nemo-extensions.deb` in the current directory
- Automatically set executable permissions on all scripts
- Remove the temporary `install` directory after building

**Customization:**
You can edit `make_deb.sh` to modify:
- Package name and version (in the `control` file template)
- Installation message (in the `postinst` file template)
- Package structure and included files

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
├── make_deb.sh                  # Script to build Debian package
├── archive_create_7z.nemo_action
├── archive_extract.nemo_action
├── archive_extract_7z.nemo_action
├── archive_list.nemo_action
├── archive_store_zip.nemo_action
├── convert_to_aac.nemo_action
├── convert_to_opus.nemo_action
├── extract_aac.nemo_action
├── gen_playlist.nemo_action
└── scripts/                    # Scripts executed by actions
    ├── archive_create_7z.sh     # Create 7Z archive
    ├── archive_extract.sh       # Extract archives
    ├── archive_store_zip.sh     # Create ZIP archive
    ├── convert_to_aac.sh        # Convert to AAC
    ├── convert_to_opus.sh       # Extract to OPUS
    ├── extract_aac.sh           # Extract AAC
    ├── gen_playlist.sh          # Generate playlist from music file in folder
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
