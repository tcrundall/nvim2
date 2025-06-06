# My NeoVIM config 2.0

## TODO

- caseless searching

## Principle

Efficient and effective text editor

## Envision Result

Have a sleek neovim configuration where I understand everything deeply

## Organize

### Plugins

- LSP
    - languages
        - [x] python
        - markdown
        - [x] C#
        - [x] lua
    - [x] set up MVP from docs
    - [x] set up keymaps to conveniently switch from loud to quite diagnostics
- [x] blink
- [x] tmux navigator
- treesitter (familiarise with user methods)
- [x] oatmeal
- gitsigns
    - [x] maps: unstage hunk
- spell checker
- autoformatter
    - [ ] set up python (that is identical to precommit hooks)

### Skills

- terminal

### Extensions

- link follower
    - extend to make use of `gx` / `vim.ui.open()`

### Standard vim

- filetypes
- folding: retain current folds on re-opening file

### Advanced

- treesitter embedded languages
- telescope, disregard test files

### Misc

- [ ] nicer fold titles
    - [ ] fix conceal (folded ```bash``` blocks vanish completely)
- [ ] <leader>sf auto looks for git tracked files, even if hidden
- [ ] highlight trailling whitespace in nvim

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
