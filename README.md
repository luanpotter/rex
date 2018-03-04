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
yarn global add bash-rex
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
echo 'foo' > file
cat file | rex 'foo' 'bar' | sponge file
cat file
```

Install [sponge](https://linux.die.net/man/1/sponge) for Arch Linux:

```bash
sudo pacman -S moreutils
```

## No escape!

Almost nothing needs to be escaped.

The first parameter is a pure node regex, that will be run with the flags 'mg' (multiline and global). More information [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp).

The second parameter will be the replacement literally, except for:

 * `$n`, where n is a number, will become the substitution pattern
 * `\t` will become tab, `\n` will become newline, `\r` will become carriage return, `\$` will become `$` and `\\` will become `\`

## More options

It's supposed to be simple: if you want simple, stop reading. If you want a few more options, there are flags:

* `-h` : if present, won't run, just show the help section
* `-f` : if present, the stdin becomes a new-line separated list of files, and rex will perform the replace on those files
* `-b` : if present, the backup mode is active:
* * if not on `-f`, rex will output stdin as is, but will save the changes to a `__rex__.bak` file with the requested changes
* * if on `-f`, it will replace on every file specified, but the results will be saved on `*.bak` files alongside the originals, that won't be touched

There are more examples [here](examples.md).