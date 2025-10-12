# PICO-8 Development Environment Overview

## Purpose
- Portable macOS-focused PICO-8 workspace with curated structure and docs (`README.md`, `AGENTS.md`).
- Keeps licensed runtime binaries in `pico8-runtime/` while seeding user work under `workspace/`.
- Emphasises automation via `just` recipes for consistent setup and day-to-day tasks (`justfile:10`).

## Automation Highlights
- Default `just` output surfaces recipe catalog and contextual help for `run`, `make`, `init`, `carts`, `templates`, and `pico-8` topics (`justfile:19`, `justfile:42`).
- `run` auto-detects carts in the caller's directory, testing multiple cartridge extensions before launching through the bundled script (`justfile:227`, `justfile:239`).
- `make` scaffolds empty carts or copies templates with smart `.p8` handling, while `carts`/`templates` provide friendly listings even when empty (`justfile:296`, `justfile:317`, `justfile:381`).

## Environment Setup
- `just init` provisions directories, verifies or stages `PICO-8.app` (including zip extraction and manual/license copying), fixes launcher permissions, and hydrates `workspace/config.txt` from `backups/config.base.txt` (`justfile:438`, `justfile:471`, `justfile:631`).
- When Python 3 is available the config templating refreshes `desktop_path`, `root_path`, and `cdata_path`, replaces the header note, and the result (or the untouched base copy when Python is absent) is always archived via timestamped backups such as `backups/config20250101-120000.txt`; the launcher still passes workspace paths explicitly for safety (`justfile:639`).

## Runtime & Workspace
- Launcher script runs PICO-8 in the background with `-home workspace`, `-root workspace/carts`, and `-desktop workspace/screenshots` so all artefacts stay inside the repo (`pico8:1`).
- `workspace/` hosts carts (`carts/mycarts`, `carts/other`), screenshots, BBS downloads, save data, logs, and other runtime byproducts; runtime payload and manuals live in `pico8-runtime/`.

## Documentation & Roadmap
- `README.md` provides onboarding, directory walkthrough, and workflow tips; `WARP.md` briefs Warp users on architecture and key commands.
- `STATUS.md` records recent improvements (interactive help, runtime provisioning polish) and lists prospective tasks like logging, template expansion, and workflow helpers.

## Daily Workflow
1. Run `just init` after cloning to scaffold directories, seed configs, and stage the runtime if available.
2. Create carts in `workspace/carts/mycarts/` via `just make <name> [template]`.
3. Iterate in an external editor; launch with `just run [cart | switches]` or `just run -splore`.
4. Keep downloaded carts in `workspace/carts/other/` and inspect with `just carts` / `just templates`.
