# PICO-8 Workspace
just a tiny developer environment for the PICO-8 Fantasy Console
by @olioskar

## 🎯 What This Is

A ** PICO-8 development setup** that provides:

- **⚡ Just-Based Automation**: Simple task automation with `just` commands
- **📦 Fully Portable**: Copy entire directory to any macOS machine and it works
- **🧹 Organized Structure**: Store templates in templates

## 🏗️ Directory Structure

```
pico-8/                           # Development environment root
├── justfile                      # Task automation (recipes)
├── README.md                     # This documentation
├── STATUS.md                     # Detailed change log
├── pico8                         # PICO-8 launch script
├── templates/                    # Cart templates
│   ├── basic-template/           # Simple project structure
│   └── project-template/         # Advanced modular structure
├── backups/                      # Development backups
├── pico8-runtime/                # PICO-8 executable & docs
└── workspace/                    # PICO-8 workspace (where magic happens)
    ├── carts/                   # 🎯 PICO-8 root directory
    │   ├── mycarts/             # Your development projects
    │   └── other/               # Downloaded/shared carts
    ├── screenshots/             # PICO-8 screenshots
    ├── bbs/                     # BBS downloads
    ├── backup/                  # PICO-8 auto-backups
    ├── cdata/                   # Save game data
    └── config.txt               # PICO-8 configuration
```

## 🚀 Quick Start

### Prerequisites

1. **macOS** (Intel or Apple Silicon)
2. **Just** task automation: `brew install just`
3. **PICO-8** The Fantasy Console from Lexaloffle

### Installation

1. **Get PICO-8**: Download from [lexaloffle.com](https://www.lexaloffle.com)
2. **Copy PICO-8.app** to `pico8-runtime/` directory (or leave it anywhere handy for now)
3. **Initialize environment**:
   ```bash
   just init
   ```
   `just init` always configures the repository root (even if you invoke it from a subfolder). If no runtime is detected it will search for one, prompt you to supply a path to a `PICO-8.app` bundle or ZIP archive, copy over the manual/license when found, or let you continue without bundling PICO-8. If `workspace/config.txt` is missing, `just init` copies `backups/config.base.txt` into place. When Python 3 is available it rewrites `desktop_path`, `root_path`, and `cdata_path` for your machine and refreshes the header note. Regardless of Python availability, the resulting file is archived with a timestamped backup (e.g. `backups/config20250101-120000.txt`), and runtime flags keep paths correct even when the file stays untouched.

That's it! 🎉

### First Steps

```bash
# See available commands
just

# List current carts (will be empty initially)  
just carts

# Create your first cart
cd workspace/carts/mycarts
just make hello-pico-8 coolgame

# Launch PICO-8 to see your cart and start editing
just run hello-pico-8
```

## 🕹️ Key Recipes

Use `just help <name>` for detailed guidance and examples.

- `just run` — Launch PICO-8 with optional **[cart filename]** and/or **[PICO-8 switches]**
  - `just run` — Launch without loading a cart
  - `just run CART_NAME` — Load `CART_NAME` from the current directory
  - `just run -splore` — Jump straight into Splore
- `just make` — Create new carts in the current directory
  - `just make NAME` — Create `NAME.p8` (extension added automatically)
  - `just make NAME TEMPLATE` — Copy `templates/TEMPLATE` into `NAME`
- `just carts` — List carts in `workspace/carts/mycarts` and `workspace/carts/other`
- `just templates` — Show available cart starters in `templates/`
- `just init` — Prepare the environment and manage `workspace/config.txt`
  - `just init alsoconfig` — Regenerate config paths (prompts before overwriting)
  - `just init alsobackup` — Snapshot the current `workspace/config.txt` before running setup
- `just help pico-8` — Display common PICO-8 command-line switches and manual links
- `just help` — Print the overview shown by `just` (with thanks to Lexaloffle!)

## 🕹️ Development Workflow

### **Your Main Development Space**

Navigate to your development folder:
```bash
cd workspace/carts/mycarts
```

This is where you'll spend most of your time creating games.

### **Creating Games**

**Option 1: Empty Cart**
```bash
just make my-awesome-game
# Creates: my-awesome-game.p8
```

**Option 2: From Template**
```bash
just make space-shooter project-template  
# Creates: space-shooter/ (directory with modular structure)
```

### **Running & Testing**

From any directory:
```bash
just run my-awesome-game         # Looks for cart in current directory
```

### **Managing Downloads**

Downloaded carts from the community? Store them in workspace/carts/other:
```bash
cp ~/Downloads/cool-community-game.p8 workspace/carts/other/
```

Now they're organized and `just carts` will show them separately.

## 🎯 PICO-8 Experience

When you launch PICO-8, you'll only see cart directories

```
> LS                    # Clean view:
  MYCARTS/             # Your development folder  
  OTHER/               # Downloaded carts

> CD MYCARTS           # Your development space
> LS                   # See your projects
  HELLO-WORLD.P8
  SPACE-SHOOTER/

> CD ../OTHER          # Community/downloaded carts
> LS
  COOL-COMMUNITY-GAME.P8
```

## 🎨 Templates

Templates provide starting points for different types of projects:

### **Basic Templates**
- Single `.p8` file
- Perfect for simple games or prototypes
- Usage: `just make my-game basic-template`

### **Project Template**  
- Directory-based structure
- Modular code organization with `#include`
- Perfect for larger, more complex games
- Usage: `just make my-game project-template`

### **Creating Templates**

Templates are either a single .p8 file or directories containing .p8 files.
These are just reusable blueprints to get started.

1. Add your template to `templates/`
2. Can be a single `.p8` file or entire directory
3. Applied to a new project via `just make [name of the game] [template name]`
4. You can see a list of all templates you have via just templates

## ⚡ Advanced Features

### **External Editor Workflow**

PICO-8 makes it easy to code using external editors:

1. Work with `.p8` files in your favorite editor
2. PICO-8 shows "EXTERNAL CHANGES" when files change
3. Press `CTRL-R` in PICO-8 to reload
4. **Version control ready**: `.p8` files work great with git

### **Launch Script Features**

The `./pico8` script:
- Runs PICO-8 in background (non-blocking)
- Uses local workspace for all PICO-8 data (home/root/desktop paths passed via CLI)
- Supports all PICO-8 command line options
- Screenshots save to `workspace/screenshots/`

### **Portability**

The entire environment is portable:

```bash
# Archive your setup
tar -czf pico8-dev.tar.gz pico-8/

# On another macOS machine
tar -xzf pico8-dev.tar.gz  
cd pico-8
just init                   # Verify setup
./pico8                     # Ready to go!
```

## 🛠️ Troubleshooting

### **PICO-8 Won't Launch**

```bash
just init                   # Check system status
chmod +x pico8             # Fix script permissions if needed
```

### **Templates Not Found**

```bash
just templates             # List available templates
ls templates/              # Check templates directory
```

### **Carts Not Showing**

```bash
just carts                 # Should show both mycarts and other
ls workspace/carts/mycarts # Check your development directory
```

### **Config Issues**

The PICO-8 configuration is in `workspace/config.txt`. Key settings:
- `root_path`: Points to `workspace/carts/` (creates fantasy console experience)
- `desktop_path`: Screenshots save to `workspace/screenshots/`

## 🎯 Design Philosophy

### **Fantasy Console First**

PICO-8 is a fantasy console - users should stay within that world. This environment:
- Hides system complexity from PICO-8's view
- Shows only cart-related directories
- Maintains the fantasy while providing modern development tools

### **External Editor Optimized**

While PICO-8 has a built-in editor, external editors provide:
- Better syntax highlighting
- More powerful editing features  
- Version control integration
- Multi-file project support

### **Organized Development**

Clear separation of:
- **Development projects** (`mycarts/`) - Your creations
- **Downloaded/shared carts** (`other/`) - Community content
- **System files** (hidden from PICO-8 view) - Configuration, saves, etc.

## 🤝 Contributing

This environment can be customized:

1. **Add templates**: Create new project templates in `templates/`
2. **Extend justfile**: Add new recipes for your workflow
3. **Share setups**: The portable nature makes sharing easy

## 📚 Resources

- **PICO-8 Manual**: `pico8-runtime/pico-8_manual.txt`
- **PICO-8 Website**: [lexaloffle.com/pico-8.php](https://www.lexaloffle.com/pico-8.php)
- **Just Documentation**: [just.systems](https://just.systems)
- **Community**: [PICO-8 BBS](https://bbs.lexaloffle.com)

---

💖 Huge thanks to [Lexaloffle](https://www.lexaloffle.com) for creating the wonderfully tiny-big PICO-8.

**Happy game development!** 🕹️✨

This environment provides everything you need for professional PICO-8 development while maintaining the fantasy console's charm and simplicity.
