# Session.vim
Thanks for ごりら teach me how to create vim plugin! 

![Support Vim 8.1.2269 or above](https://img.shields.io/badge/support-Vim%208.1.2269%20or%20above-yellowgreen.svg)
[![vim](https://github.com/lambdalisue/fern.vim/workflows/vim/badge.svg)](https://github.com/lambdalisue/fern.vim/actions?query=workflow%3Avim)

## Cencept
- Supports vim
- Easy to create session, and delete session

## Installation
If you use vim plug, write follow the command in vimrc
```
Plug 'Mr-peipei/session.vim'
```
and use `:PlugInstall` commnad

If you use neobundle
```
NeoBundle 'Mr-peipei/session.vim'
```

If you use dein.vim
```
call dein#add('Mr-peipei/session.vim')
```


## Usage

###Command
Create a session by:
```vim
:SessionCreate {session-name}
```

Delete a session by:
```vim
:SessionDelete {session-name}
```

Open a session List by:
```
:SessionList
```
![Session List](https://user-images.githubusercontent.com/54967427/116644491-7955c580-a9ae-11eb-8288-1cf5fb00f7f3.png)

###key mappings
after use :SessionList Command
```
nmap <buffer> <CR> <Plug>(session-open)
```

