# My NeoVIM config 2.0

## Principle

Efficient and effective text editor

## Envision Result

Have a sleek neovim configuration where I understand everything deeply

## Organize

### Plugins

- LSP
    - languages
        - python
        - markdown
        - C#
        - lua
    - set up MVP from docs
    - set up keymaps to conveniently switch from loud to quite diagnostics
- blink
- [x] tmux navigator
- treesitter (familiarise with user methods)
- oatmeal
- fugitive
    - maps: unstage hunk
- spell checker

### Skills

- terminal

### Extensions

- link follower
    - extend to make use of `gx` / `vim.ui.open()`

### Standard vim

- filetypes

### Advanced

- treesitter embedded languages
- telescope, disregard test files

## Supporting material

### Known issues on mac

My mac struggles to compile treesitter parsers.
Check temp dirs in `~/.local/share/nvim/tree-sitter-*` and try to manually compile (with make?).

Don't spend too much time on this before mac is updated.

### Link following example

asdfa dfasdf [some website](google.com)

asdfa sdf [some plugin](./lua/config/plugins/init.lua#L100)

asdfa sdf [some plugin](lua/config/plugins/init.lua#L100)

asdfa sdf [some plugin](lua/config/plugins/init.lua)

### LSP

`:help lsp-defaults` for default bindings

`:help lsp`: see new (for 0.11.0) way to set up lsp

`:help lsp-config`: see nice wrapper for lsp

`:chekchealth vim.lsp`

ensure the executable is findable:
`:echo executable('name-of-executable')`

get diagnsotic options
`:help vim.diagnostic.Opts`
