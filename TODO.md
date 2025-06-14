# TODO

## Organize

### Critical

- [ ] debugger
- [x] fix file completion with `:cd` (could not reproduce), though keep in mind `:cd %:h` to change
  to directory of current file
- [x] jump to type definition
- [ ] grep and search word work when in e.g. plugin dirs

### Plugins

- LSP
    - languages
        - [x] python
        - markdown
        - [x] C#
            - suppress "info messages" but show popups
        - [x] lua
        - [x] go
    - [x] set up MVP from docs
    - [x] set up upkeymaps to conveniently switch from loud to quite diagnostics
- [x] blink
- [x] tmux navigator
- treesitter (familiarise with user methods)
- [x] oatmeal
- gitsigns
    - [x] maps: unstage hunk
- spell checker
- autoformatter
    - [x] set up python (that is identical to precommit hooks)
- [x] add border to hover window

### Skills

- terminal

### Extensions

- link follower
    - extend to make use of `gx` / `vim.ui.open()`
- markdown box checking
- open api veiwer
- mermaid builder

### Standard vim

- filetypes
- folding: retain current folds on re-opening file

### Settings

- [ ] caseless searching

### Advanced

- treesitter embedded languages
- telescope, disregard test files

### Misc

- [ ] better status line
- [ ] auto vertical split
- [ ] nicer fold titles
    - [ ] fix conceal (folded ```bash``` blocks vanish completely)
    - [ ] fold in go respects tabs
- [ ] <leader>sf auto looks for git tracked files, even if hidden
- [ ] highlight trailling whitespace in nvim

