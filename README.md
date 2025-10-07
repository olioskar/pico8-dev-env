# PICO-8 Development Environment

A comprehensive, self-contained PICO-8 development environment optimized for external editors and fantasy console immersion.

## 🎯 What This Is

A **complete PICO-8 development setup** that provides:

- **🎮 Fantasy Console Immersion**: Clean PICO-8 experience with only cart directories visible
- **📝 External Editor Optimized**: Perfect for Warp, VS Code, or any text editor  
- **⚡ Just-Based Automation**: Simple, powerful task automation with `just` commands
- **📦 Fully Portable**: Copy entire directory to any macOS machine and it works
- **🧹 Organized Workflow**: Clear separation of development vs downloaded carts

## 🏗️ Directory Structure

```
pico-8/                           # Development environment root
├── justfile                      # Task automation (recipes)
├── README.md                     # This documentation
├── STATUS.md                     # Detailed change log
├── WARP.md                       # AI assistant rules for Warp
├── pico8                         # PICO-8 launch script
├── templates/                    # Cart templates
│   ├── basic-template/           # Simple project structure
│   └── project-template/         # Advanced modular structure
├── backups/                      # Development backups
├── pico8-runtime/                # PICO-8 executable & docs
│   ├── PICO-8.app               # The fantasy console
│   ├── pico-8_manual.txt        # Official manual
│   └── license.txt              # License
└── workspace/                    # PICO-8 workspace (where magic happens)
    ├── carts/                   # 🎯 PICO-8 root directory
    │   ├── mycarts/             # Your development projects
    │   └── other/               # Downloaded/shared carts
    ├── screenshots/             # PICO-8 screenshots
    ├── bbs/                     # BBS downloads (browseable!)
    ├── backup/                  # PICO-8 auto-backups
    ├── cdata/                   # Save game data
    └── config.txt               # PICO-8 configuration
```

## 🚀 Quick Start

### Prerequisites

1. **macOS** (Intel or Apple Silicon)
2. **Just** task automation: `brew install just`
3. **PICO-8** (we'll handle the setup)

### Installation

1. **Get PICO-8**: Download from [lexaloffle.com](https://www.lexaloffle.com/pico-8.php)
2. **Copy PICO-8.app** to `pico8-runtime/` directory
3. **Initialize environment**:
   ```bash
   just init
   ```

That's it! 🎉

### First Steps

```bash
# See available commands
just

# List current carts (will be empty initially)  
just carts

# Create your first cart
cd workspace/carts/mycarts
just make hello-world

# Launch PICO-8 to see your cart
just run hello-world
```

## 📋 Commands Reference

### **Cart Management**

```bash
just carts                        # List all carts (mycarts + other)
just make NAME                    # Create empty cart in current directory  
just make NAME TEMPLATE           # Create cart from template
just templates                   # List available templates
```

### **Running PICO-8**

```bash
just run                         # Launch PICO-8 normally
just run CART_NAME               # Load specific cart from current directory  
just run CART_NAME -volume 64    # Load cart with PICO-8 switches
just run -splore                 # Launch PICO-8 in Splore mode
```

### **System**

```bash
just init                        # Initialize/verify environment setup
just                             # Show available commands + environment info
```

## 🎮 Development Workflow

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

Downloaded carts from the community? Put them here:
```bash
cp ~/Downloads/cool-community-game.p8 workspace/carts/other/
```

Now they're organized and `just carts` will show them separately.

## 🎯 PICO-8 Experience

### **Fantasy Console Immersion**

When you launch PICO-8, you'll only see cart directories - no system clutter!

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

### **BBS Integration**

The BBS (Bulletin Board System) downloads are fully browseable:

```
> CD ../BBS/CARTS      # Navigate to BBS downloads
> LS                   # Browse community carts
> LOAD SOME-COOL-CART  # Play community creations
```

## 🎨 Templates

Templates provide starting points for different types of projects:

### **Basic Template**
- Single `.p8` file
- Perfect for simple games or prototypes
- Usage: `just make my-game basic-template`

### **Project Template**  
- Directory-based structure
- Modular code organization with `#include`
- Perfect for larger, more complex games
- Usage: `just make my-game project-template`

### **Creating Custom Templates**

1. Add your template to `templates/`
2. Can be a single `.p8` file or entire directory
3. Available immediately via `just make`

## ⚡ Advanced Features

### **External Editor Workflow**

This environment is optimized for external editors:

1. **Edit in Warp/VS Code**: Work with `.p8` files in your favorite editor
2. **Auto-reload**: PICO-8 shows "EXTERNAL CHANGES" when files change
3. **Quick reload**: Press `CTRL-R` in PICO-8 to reload
4. **Version control ready**: `.p8` files work great with git

### **Launch Script Features**

The `./pico8` script:
- Runs PICO-8 in background (non-blocking)
- Uses local workspace for all PICO-8 data
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

**Happy game development!** 🎮✨

This environment provides everything you need for professional PICO-8 development while maintaining the fantasy console's charm and simplicity.