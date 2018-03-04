# rex

A simple regexp executer for bash.

Like sed, but you don't need to deal with complex escape characters.

It uses node regexp. Could not be simpler to use!

## Installation

You can install using `npm`:

```bash
    npm i -g bash-rex
```

Or yarn:

```bash
    yarn global bash-rex
```

Or download the bin from github (wip):

```bash
    wget https://github.com/luanpotter/bash-rex/TODO
    ...
```

## Usage

Very simple! Just run:

```bash
    echo 'foo' | rex 'o' 'e'
    > fee
```

But unlike sed, you don't need to escape complex regex'es:

```bash
    echo 'package-name-1.2.3' | rex '(\w)-\d[\d-.:+]*' '$1'
    > package-name
```
Just use single quotes so `bash` won't replace stuff like `$1`.

If you want to change a file, you can use `sponge`:

```bash
    cat file | rex 'foo' 'bar' | sponge file
```

Install [sponge](https://linux.die.net/man/1/sponge) for Arch Linux:

```bash
    sudo pacman -S moreutils
```