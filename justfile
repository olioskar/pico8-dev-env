# PICO-8 Development Environment
# Just-based task automation for PICO-8 development
# Settings

set shell := ["zsh", "-c"]
set positional-arguments := true

# Directory variables

justfile_dir := justfile_directory()
workspace_dir := justfile_dir / "workspace"
templates_dir := justfile_dir / "templates"
runtime_dir := justfile_dir / "pico8-runtime"
carts_dir := workspace_dir / "carts"
mycarts_dir := carts_dir / "mycarts"
other_dir := carts_dir / "other"

# Show available recipes and environment info
default:
    @just _help-overview

# Contextual help for recipes and tooling
[no-cd]
help topic="overview":
    #!/usr/bin/env zsh
    set -euo pipefail

    topic="{{ topic }}"
    topic="${topic:l}"

    case "$topic" in
        ""|"overview") just _help-overview ;;
        run) just _help-run ;;
        make) just _help-make ;;
        carts) just _help-carts ;;
        templates) just _help-templates ;;
        init) just _help-init ;;
        "pico-8"|"pico8") just _help-pico ;;
        *) just _help-unknown "$topic" ;;
    esac

_help-overview:
    @echo "🕹️ PICO-8 Development Environment"
    @echo ""
    @echo "📍 You are here: {{ invocation_directory() }}"
    @echo "🏠 Workspace root: {{ workspace_dir }}"
    @echo ""
    @echo "📜 Recipes (try 'just help <name>' for details):"
    @echo "  just run         Launch PICO-8 with optional [cart filename] and/or [PICO-8 switches]"
    @echo "  just make        Create carts in the current directory (empty or from templates)"
    @echo "  just carts       Browse carts in workspace/carts/mycarts and workspace/carts/other"
    @echo "  just templates   List starter templates stored in templates/"
    @echo "  just init        Prepare the environment and manage the local PICO-8 config"
    @echo "  just help pico-8 Show common PICO-8 command-line switches and docs links"
    @echo ""
    @echo "📚 Quick Example:"
    @echo "  just run -splore       # Open PICO-8's Splore browser"
    @echo ""
    @echo "🧭 Tip: Use 'just help run' (or make/carts/templates/init) for detailed guidance."
    @echo ""
    @echo "🕹️ Have fun crafting tiny-big adventures!"
    @echo ""
    @echo "💖 Huge thanks to Lexaloffle (www.lexaloffle.com) for creating the wonderfully tiny-big PICO-8!"

_help-run:
    @printf '%s\n' \
        "🕹️ Recipe: run" \
        "" \
        "Launch PICO-8 with an optional cart filename and/or PICO-8 command-line switches. When a cart name is supplied, the current directory is searched for .p8/.p8.png/.p8.rom files." \
        "" \
        "Usage:" \
        "  just run                     # Launch PICO-8 without loading a cart" \
        "  just run CART_NAME           # Load CART_NAME from the current directory" \
        "  just run CART_NAME -volume 8 # Pass switches after the cart name" \
        "  just run -splore             # Launch PICO-8 directly into Splore" \
        "" \
        "Helpful hints:" \
        "  • Cart lookup is case-sensitive and respects relative paths." \
        "  • Need the full switch list? Run: just help pico-8" \
        "  • To create a cart before running it, try: just make my-cart"

_help-make:
    @printf '%s\n' \
        "🕹️ Recipe: make" \
        "" \
        "Create new carts in the current directory. You can generate an empty .p8 file or copy one of the available templates." \
        "" \
        "Usage:" \
        "  just make NAME               # Create NAME.p8 (added automatically when missing)" \
        "  just make NAME TEMPLATE      # Copy templates/TEMPLATE into NAME (file or directory)" \
        "  just make                    # Show help and usage examples" \
        "" \
        "Helpful hints:" \
        "  • Use 'just templates' to see available template names." \
        "  • Directory templates drop the trailing .p8 automatically." \
        "  • Need a quick recap? Run: just help make"

_help-carts:
    @printf '%s\n' \
        "🕹️ Recipe: carts" \
        "" \
        "List carts stored in workspace/carts/mycarts (your projects) and workspace/carts/other (downloads or shared carts)." \
        "" \
        "Usage:" \
        "  just carts" \
        "" \
        "Helpful hints:" \
        "  • Place personal work in workspace/carts/mycarts." \
        "  • Community carts belong in workspace/carts/other so they stay organised." \
        "  • Pair with 'just run' from inside a cart directory for quick launches."

_help-templates:
    @printf '%s\n' \
        "🕹️ Recipe: templates" \
        "" \
        "Show all available cart templates located in templates/." \
        "" \
        "Usage:" \
        "  just templates" \
        "" \
        "Helpful hints:" \
        "  • Add your own starter templates to templates/ (files or directories)." \
        "  • Pair with 'just make NAME TEMPLATE' to scaffold new projects quickly."

_help-init:
    @printf '%s\n' \
        "🕹️ Recipe: init" \
        "" \
        "Prepare the development environment. Creates workspace folders, verifies the PICO-8 runtime, ensures the launch script is executable, and seeds workspace/config.txt from backups/config.base.txt." \
        "" \
        "Usage:" \
        "  just init                    # Perform setup and keep existing configs intact" \
        "  just init alsoconfig         # Regenerate config.txt (prompts before overwriting)" \
        "" \
        "Helpful hints:" \
        "  • If PICO-8.app is missing, place it under pico8-runtime/ or provide a path when prompted." \
        "  • A personalised copy lives at backups/config.local.txt for reference." \
        "  • Need to refresh paths later? Re-run: just init alsoconfig"

_help-pico:
    @printf '%s\n' \
        "🕹️ PICO-8 Command-Line Reference" \
        "" \
        "Common switches:" \
        "  -run <cart.p8>        # Launch and run a specific cart" \
        "  -splore              # Open Splore browser" \
        "  -volume <0-128>      # Set master volume (0–128)" \
        "  -workspace <path>    # Override workspace path" \
        "  -home <path>         # Override desktop/save path" \
        "  -pixel_perfect       # Disable pixel smoothing" \
        "  -windowed / -fullscreen / -frameless" \
        "  -width <px> -height <px>" \
        "" \
        "Documentation:" \
        "  • Offline manual: pico8-runtime/pico-8_manual.txt" \
        "  • Online manual: https://www.lexaloffle.com/dl/docs/pico-8_manual.html" \
        "  • For launch tips, run: just help run"

_help-unknown topic:
    @printf '%s\n' \
        "🔍 Help topic not recognised." \
        "" \
        "Try one of:" \
        "  just help overview" \
        "  just help run" \
        "  just help make" \
        "  just help carts" \
        "  just help templates" \
        "  just help init" \
        "  just help pico-8"

# Launch PICO-8 with optional cart and/or command line parameters
# Usage patterns:
#   just run                    # Launch PICO-8 normally
#   just run CART_NAME          # Load specific cart from current directory
#   just run CART_NAME -switches # Load cart with PICO-8 switches (cart name MUST be first)
#   just run -switches          # Launch PICO-8 with switches only (no cart)
# Note: When using both cart name and switches, cart name must come first!

[doc('Launch PICO-8 with optional [filename] and/or [PICO-8 switches]')]
[no-cd]
run *args="":
    @{{ if args == "" { "just _run-plain" } else { "just _run-with-args '" + args + "'" } }}

# Launch PICO-8 without arguments
_run-plain:
    @echo "🕹️ Launching PICO-8..."
    @echo ""
    @cd "{{ justfile_dir }}" && ./pico8

# Launch PICO-8 with arguments (cart name or parameters)
_run-with-args args:
    #!/usr/bin/env zsh
    set -euo pipefail

    invoke_dir="{{ invocation_directory() }}"
    raw_args="{{ args }}"

    # Parse arguments using just's built-in functionality
    args_array=({{ args }})
    first_arg="${args_array[1]:-}"
    
    # Check if first arg looks like a cart name (no dashes/slashes/numbers only)
    if [[ "$first_arg" != -* && "$first_arg" != */* && ! "$first_arg" =~ ^[0-9]+$ ]]; then
        # List of extensions to try, in order of preference
        extensions=("" ".p8" ".p8.png" ".p8.rom")
        
        # Search for cart with various extensions
        for ext in "${extensions[@]}"; do
            cart_path="$invoke_dir/$first_arg$ext"
            if [[ -f "$cart_path" ]]; then
                # Remove cart name from args for remaining parameters
                shift args_array
                remaining_args="${args_array[*]:-}"
                
                echo "🕹️ Running: $(basename "$cart_path") $remaining_args"
                echo ""
                echo "📁 From: $invoke_dir"
                
                # Launch PICO-8 from justfile directory with cart path
                cd "{{ justfile_dir }}" && ./pico8 -run "$cart_path" ${remaining_args}
                exit 0
            fi
        done
        
        # Cart not found - provide helpful error message
        echo "🔍 Cart not found: $first_arg"
        echo ""
        echo "📁 Searched in: $invoke_dir"
        echo ""
        echo "💡 To create a new cart, use: just make $first_arg"
        echo ""
        echo "🕹️ To start PICO-8 without a cart, use: just run"
        echo ""
        echo "ℹ️ Need guidance? Run: just help run"
        exit 0
    else
        # Not a cart name - pass to parameter handler
        just _run-with-params "$raw_args"
        exit $?
    fi

# Run PICO-8 with command line parameters
_run-with-params args:
    @echo "🕹️ Launching PICO-8 with parameters: {{ args }}"
    @echo ""
    @cd "{{ justfile_dir }}" && ./pico8 {{ args }}

# Create PICO-8 cart with optional [name] and [template]
[no-cd]
make name="" template="":
    @{{ if name == "" { "just _make-help" } else if template == "" { "just _make-empty '" + name + "'" } else { "just _make-from-template '" + name + "' '" + template + "'" } }}

# Show make help
_make-help:
    @just _help-make

# Create empty cart with smart .p8 extension handling
[no-cd]
_make-empty name:
    @just _normalize-and-create-empty "{{ name }}"

# Create cart from template with smart naming
[no-cd] 
_make-from-template name template:
    @{{ if path_exists(templates_dir / template + ".p8") == "true" { "just _create-from-file-template '" + name + "' '" + template + "'" } else if path_exists(templates_dir / template) == "true" { "just _create-from-dir-template '" + name + "' '" + template + "'" } else { "just _template-not-found '" + template + "'" } }}

# Internal: Normalize name and create empty cart
[no-cd]
_normalize-and-create-empty name:
    #!/usr/bin/env zsh
    set -euo pipefail
    
    # Smart .p8 extension handling - avoid .p8.p8
    if [[ "{{ name }}" == *.p8 ]]; then
        cart_name="{{ name }}"
    else
        cart_name="{{ name }}.p8"
    fi
    
    echo "🕹️ Creating empty cart: $cart_name"
    touch "$cart_name"
    echo "✨ Created: $cart_name"

# Internal: Create cart from .p8 template file 
[no-cd]
_create-from-file-template name template:
    #!/usr/bin/env zsh
    set -euo pipefail
    
    templates_dir="{{ templates_dir }}"
    template_file="$templates_dir/{{ template }}.p8"
    
    # Smart naming: .p8 templates always create .p8 files
    if [[ "{{ name }}" == *.p8 ]]; then
        output_name="{{ name }}"
    else
        output_name="{{ name }}.p8"
    fi
    
    echo "🕹️ Creating '$output_name' from template '{{ template }}.p8'"
    cp "$template_file" "$output_name"
    echo "✨ Created: $output_name"

# Internal: Create cart from directory template
[no-cd] 
_create-from-dir-template name template:
    #!/usr/bin/env zsh
    set -euo pipefail
    
    templates_dir="{{ templates_dir }}"
    template_dir="$templates_dir/{{ template }}"
    
    # Directory templates: use name as-is (no .p8 extension)
    output_name="{{ name }}"
    # Remove .p8 if user accidentally added it to directory name
    if [[ "$output_name" == *.p8 ]]; then
        output_name="${output_name%.p8}"
    fi
    
    echo "🕹️ Creating '$output_name/' from template directory '{{ template }}/'"
    cp -r "$template_dir" "$output_name"
    echo "✨ Created: $output_name/"

# Internal: Handle template not found error
_template-not-found template:
    @echo "🔍 Template not found: {{ template }}"
    @echo ""
    @echo "💡 Available templates:"
    @just templates
    @echo ""
    @echo "ℹ️ Need guidance? Run: just help templates"

# List all carts in mycarts/ and other/
carts:
    @echo "🕹️ Your Development Carts ({{ mycarts_dir }}):"
    @just _list-items "{{ mycarts_dir }}" "*.p8*" "carts" "just make <name>"
    @echo ""
    @echo "📚 Other Carts ({{ other_dir }}):"
    @just _list-items "{{ other_dir }}" "*.p8*" "carts" "add downloaded carts here"

# List available templates
templates:
    @echo "🎨 Available Templates ({{ templates_dir }}):"
    @just _list-items "{{ templates_dir }}" "*.p8" "templates" "add files to templates/"

# Internal: List items in directory with pattern
_list-items dir pattern item_type create_hint:
    #!/usr/bin/env zsh
    setopt null_glob  # Don't error when glob doesn't match
    set +e  # Don't exit on non-zero commands

    if [[ ! -d "{{ dir }}" ]]; then
        echo "  (no {{ item_type }} yet - {{ create_hint }})"
        return 0
    fi

    cd "{{ dir }}"
    found_items=false

    # List files matching pattern
    for file in {{ pattern }}; do
        if [[ -f "$file" ]]; then
            found_items=true
            if [[ "{{ item_type }}" == "templates" && "$file" == *.p8 ]]; then
                name="${file%.p8}"
                echo "  📄 $name (.p8 template)"
            else
                echo "  📄 $file"
            fi
        fi
    done

    # List directories
    for direntry in */; do
        if [[ -d "$direntry" ]]; then
            found_items=true
            dir_name="${direntry%/}"
            if [[ "{{ item_type }}" == "templates" ]]; then
                echo "  📁 $dir_name (directory template)"
            else
                echo "  📁 $dir_name/"
            fi
        fi
    done

    if [[ "$found_items" == "false" ]]; then
        echo "  (no {{ item_type }} yet - {{ create_hint }})"
    fi

# Initialize environment for first-time setup
init mode="":
    @just _init-dirs
    @just _check-runtime
    @just _check-script
    @just _init-config "{{ mode }}"
    @echo ""
    @echo "✨ Setup complete! Environment refreshed."
    @echo ""
    @just _init-summary
    @echo ""
    @echo "🕹️ Have fun making games!"
    @echo "💖 Huge thanks to Lexaloffle (www.lexaloffle.com) for dreaming up PICO-8."

# Create directory structure
_init-dirs:
    @echo "🚀 Initializing PICO-8 Development Environment..."
    @echo ""
    @echo "📂 Repository root: {{ justfile_dir }}"
    @echo "📍 Invocation directory: {{ invocation_directory() }}"
    @if [[ "{{ invocation_directory() }}" != "{{ justfile_dir }}" ]]; then echo "ℹ️ init always operates on the repository root."; fi
    @echo ""
    @echo "📁 Creating directories..."
    @mkdir -p "{{ mycarts_dir }}"
    @mkdir -p "{{ other_dir }}"
    @mkdir -p "{{ templates_dir }}"
    @mkdir -p "{{ justfile_dir }}/backups"
    @mkdir -p "{{ workspace_dir }}/screenshots"
    @echo ""
    @echo "✨ Directories created"
    @echo ""

# Check PICO-8 runtime
_check-runtime:
    #!/usr/bin/env zsh
    set -euo pipefail

    runtime_dir="{{ runtime_dir }}"
    repo_root="{{ justfile_dir }}"
    target="$runtime_dir/PICO-8.app"

    copy_bundle() {
        local source="$1"
        local dest="$target"
        local parent
        rm -rf "$dest"
        mkdir -p "$runtime_dir"
        if command -v ditto >/dev/null 2>&1; then
            ditto "$source" "$dest"
        else
            cp -R "$source" "$dest"
        fi
        parent="$(dirname "$dest")"
        for extra in "license.txt" "pico-8_manual.txt"; do
            if [[ -f "$source/../$extra" ]]; then
                cp "$source/../$extra" "$parent/$extra"
            elif [[ -f "$source/$extra" ]]; then
                cp "$source/$extra" "$parent/$extra"
            fi
        done
    }

    install_from_source() {
        local candidate="$1"

        if [[ -d "$candidate" ]]; then
            if [[ "$(basename "$candidate")" == "PICO-8.app" ]]; then
                echo "📦 Installing PICO-8.app from '$candidate'"
                copy_bundle "$candidate"
                return 0
            fi

            local nested="$candidate/PICO-8.app"
            if [[ -d "$nested" ]]; then
                echo "📦 Installing PICO-8.app from '$nested'"
                copy_bundle "$nested"
                return 0
            fi

            nested=$(find "$candidate" -maxdepth 2 -name 'PICO-8.app' -type d | head -n 1)
            if [[ -n "$nested" ]]; then
                echo "📦 Installing PICO-8.app from '$nested'"
                copy_bundle "$nested"
                return 0
            fi

            return 1
        fi

        if [[ -f "$candidate" && "$candidate" == *.zip ]]; then
            local tmp
            tmp=$(mktemp -d)
            if unzip -qq "$candidate" -d "$tmp" >/dev/null 2>&1; then
                local extracted
                extracted=$(find "$tmp" -maxdepth 3 -name 'PICO-8.app' -type d | head -n 1)
                if [[ -n "$extracted" ]]; then
                    echo "📦 Installing PICO-8.app from archive '$candidate'"
                    copy_bundle "$extracted"
                    rm -rf "$tmp"
                    return 0
                fi
            fi
            rm -rf "$tmp"
            return 1
        fi

        return 1
    }

    attempt_auto_install() {
        local found_app

        found_app=$(find "$repo_root" -path "$runtime_dir" -prune -o -name 'PICO-8.app' -type d -print -quit)
        if [[ -n "$found_app" ]]; then
            if install_from_source "$found_app"; then
                echo "✨ PICO-8 runtime installed from '$found_app'"
                echo ""
                return 0
            fi
        fi

        local candidate
        while IFS= read -r candidate; do
            if unzip -qq -l "$candidate" >/dev/null 2>&1 && unzip -l "$candidate" | grep -q 'PICO-8.app/'; then
                if install_from_source "$candidate"; then
                    echo "✨ PICO-8 runtime installed from archive '$candidate'"
                    echo ""
                    return 0
                fi
            fi
        done < <(find "$repo_root" -path "$runtime_dir" -prune -o -name '*.zip' -type f -print)

        return 1
    }

    if [[ -d "$target" ]]; then
        echo "✨ PICO-8 runtime found"
        echo ""
        exit 0
    fi

    echo "🔍 PICO-8 runtime not found in $runtime_dir"

    if attempt_auto_install; then
        echo "✨ PICO-8 runtime ready at $target"
        echo ""
        exit 0
    fi

    echo "🛠️ Action needed: PICO-8.app was not bundled with this checkout."
    echo ""
    echo "   Provide a path to a PICO-8.app bundle, a directory that contains it, or a zip archive."
    echo "   Press ENTER to continue without bundling PICO-8 (you can configure it later)."
    echo ""

    while true; do
        printf "👉 Path to PICO-8 (press ENTER to skip): "
        IFS= read -r user_input || user_input=""

        if [[ -z "$user_input" ]]; then
            echo "ℹ️ Continuing without bundling PICO-8 for now."
            break
        fi

        case "$user_input" in
            "~"*)
                user_input="${user_input/#\~/$HOME}"
                ;;
        esac

        if [[ ! -e "$user_input" ]]; then
            echo "🧭 Path not found: $user_input"
            continue
        fi

        if install_from_source "$user_input"; then
            echo "✨ PICO-8 runtime installed from user-provided path."
            echo ""
            break
        else
            echo "🔍 '$user_input' does not contain a PICO-8.app bundle."
        fi
    done

    if [[ -d "$target" ]]; then
        echo "✨ PICO-8 runtime ready at $target"
        echo ""
    else
        echo "⚠️ PICO-8 runtime still missing. Install manually to enable run commands."
        echo "Download PICO-8 fantasy console from https://www.lexaloffle.com/"
        echo "ℹ️ For setup guidance, run: just help init"
    fi

# Configure workspace config.txt from template
_init-config mode="":
    #!/usr/bin/env zsh
    set -euo pipefail

    mode="{{ mode }}"
    mode="${mode:l}"

    base_config="{{ justfile_dir }}/backups/config.base.txt"
    workspace_config="{{ workspace_dir }}/config.txt"
    backup_config="{{ justfile_dir }}/backups/config.local.txt"
    workspace_raw="{{ workspace_dir }}"
    workspace_dir_trimmed="${workspace_raw%/}"
    desktop_path="${workspace_dir_trimmed}/"
    root_path="${workspace_dir_trimmed}/carts/"
    cdata_path="${workspace_dir_trimmed}/cdata/"

    if [[ ! -f "$base_config" ]]; then
        echo "⚠️ Base config not found at $base_config"
        return 0
    fi

    tmp="$(mktemp)"

    python3 -c "import sys, pathlib; base=pathlib.Path(sys.argv[1]); tmp=pathlib.Path(sys.argv[2]); desktop, root, cdata = sys.argv[3:6]; tmp.write_text('\n'.join((f'desktop_path {desktop}' if line.startswith('desktop_path ') else f'root_path {root}' if line.startswith('root_path ') else f'cdata_path {cdata}' if line.startswith('cdata_path ') else line) for line in base.read_text().splitlines()) + '\n')" "$base_config" "$tmp" "$desktop_path" "$root_path" "$cdata_path"

    mkdir -p "${backup_config:h}"
    cp "$tmp" "$backup_config"
    echo "💾 Config backup updated at $backup_config"
    echo ""

    should_copy="false"
    if [[ -f "$workspace_config" ]]; then
        if [[ "$mode" == "alsoconfig" ]]; then
            echo "⚠️ About to overwrite existing config at $workspace_config with generated values."
            printf "Proceed? [y/N]: "
            read -r reply
            if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
                should_copy="true"
            else
                echo "ℹ️ Skipping workspace config restore."
                echo ""
            fi
        else
            echo "ℹ️ Existing workspace config detected; leaving as-is."
            echo ""
        fi
    else
        should_copy="true"
    fi

    if [[ "$should_copy" == "true" ]]; then
        cp "$tmp" "$workspace_config"
        echo "✨ Workspace config ready at $workspace_config"
        echo ""
    fi

    rm -f "$tmp"

# Check and fix launch script permissions
_check-script:
    #!/usr/bin/env zsh
    script_path="{{ justfile_dir }}/pico8"
    if [[ -x "$script_path" ]]; then
        echo "✨ Launch script ready"
        echo ""
    else
        echo "⚠️ Launch script not executable - fixing..."
        if chmod +x "$script_path" 2>/dev/null; then
            echo "✨ Fixed launch script permissions"
            echo ""
        else
            echo "⚠️ Could not fix permissions - run: chmod +x $script_path"
            echo ""
        fi
    fi

# Show environment summary
_init-summary:
    @echo ""
    @echo "📦 Environment Structure:"
    @echo "  {{ justfile_dir }}"
    @echo "  ├── pico8                  Launch script"
    @echo "  ├── templates/             Templates for new carts"
    @echo "  ├── backups/               Development backups"
    @echo "  ├── pico8-runtime/         PICO-8 executable and docs"
    @echo "  └── workspace/             PICO-8 workspace"
    @echo "      ├── carts/              🎯 PICO-8 root directory"
    @echo "      │   ├── mycarts/        Your development carts"
    @echo "      │   └── other/          Downloaded/shared carts"
    @echo "      ├── screenshots/       PICO-8 screenshots"
    @echo "      ├── bbs/               Downloaded BBS carts"
    @echo "      └── config.txt         PICO-8 configuration"
    @echo ""
    @echo "📜 Available Recipes (see 'just help <name>' for more):"
    @echo "  just run         Launch PICO-8 with optional [cart filename] and/or [PICO-8 switches]"
    @echo "    just run                     # Launch without loading a cart"
    @echo "    just run CART_NAME           # Load CART_NAME from the current directory"
    @echo "    just run -splore             # Open PICO-8's Splore browser"
    @echo "  just make        Create new carts in the current directory"
    @echo "    just make NAME               # Create NAME.p8 (extension added automatically)"
    @echo "    just make NAME TEMPLATE      # Copy templates/TEMPLATE into NAME"
    @echo "  just carts       List carts in workspace/carts/"
    @echo "  just templates   Show template starters living in templates/"
    @echo "  just init        Prepare the environment and manage config.txt"
    @echo "    just init alsoconfig         # Regenerate workspace/config.txt (with confirmation)"
    @echo "  just help pico-8 Explore PICO-8 command-line switches and docs"
    @echo ""
    @echo "🎯 Development Workflow:"
    @echo "  1. Navigate to carts/mycarts/ for your development projects"
    @echo "  2. Use 'just make' to create carts in current directory"
    @echo "  3. Edit carts in external editor"
    @echo "  4. Use 'just run' to test in PICO-8"
    @echo "  5. Press CTRL-R in PICO-8 when you see 'EXTERNAL CHANGES'"
    @echo "  6. Add downloaded carts to carts/other/ for exploration"
