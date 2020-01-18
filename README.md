# crcrcr

`crcrcr` reads your folder contents to create some slides in your terminal.

:warning: very experimental, but it works (sometimes) on my computer.

# Usage

Just run `crcrcr` in your folder and voilà!

Here is a sample structure:

```
my-slides/
├── 01-intro/
│   ├── 01-intro.txt
│   └── 02-whoami.txt
├── 02-what
│   ├── 01-slides.txt
│   └── 02-terminal.txt
└── 00.txt
```

The slides are ordered alphabetically, so the order is:

- 00.txt
- 01-intro/01-intro.txt
- 01-intro/02-whoami.txt
- 02-what/01-slides.txt
- 02-what/02-terminal.txt

# Development

`crcrcr` is made with [Crystal](https://crystal-lang.org/).

## License

Licensed under the [GPLv3 license](./LICENSE).