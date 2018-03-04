# Examples

rex is simple, but really powerful.

Below are some examples that we think might be useful for a lot of people:

## Extract data in a bash pipe chain

```bash
cat keys.json | rex '[\w]*=([\w\d\.-]*)' '$1' | xargs -I{} something --secret {}
```

Without sed escape headaches

## Use the -b option as a logger in a complex chain

```
    find . | grep '.js' | xargs cat | grep '^class' | ... | rex -b '' '' | grep '\W[\w]*' | ...
```

It will pipe stdin to stdout unharmed, but log it in a `__rex__.bak` file.

## Replace tabs with spaces on all files in a project

```bash
find . | rex -f '    ' '\t'
```

Using the `find` command to output all files recursively, and `-f` option to alter files in place. It will ignore directories automatically.

## Replace spaces with tabs

```bash
find . | rex -f '\t' '    '
```

Because we are indentation agnostic.

## Refactor a variable

```bash
find *.js | rex -f 'foodprice' 'foodPrice'
```

Beware, though, it'll dumb replace! Be sure to have a `git diff` to see the effects, or use the -b option:

```bash
find *.js | rex -fb 'foodprice' 'foodPrice'
```

Which will save the originals on `*.bak` files for you to manually `diff` then later.

## Rename loads of files

```bash
find . | grep .js | rex '(.*).js' 'mv $1.js $1.ts' | bash
```

Easy-peasy, hum?
