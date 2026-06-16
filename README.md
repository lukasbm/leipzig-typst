# Leipzig Typst theme

:rocket: the Leipzig style, but in *typst*.
Inspired by [Leipzig Beamer](https://github.com/bmondal94/Leipzig-Beamer-Template)

This theme is built on top of [Touying](https://github.com/touying-typ/touying).

## :gear: Prerequisites

- Arial font family (Liberation Sans as fallback)
- `typst >= 0.12.0` compiler installed
- `git` and `python3` installed

## :wrench: Installation

This theme will not be published in the package repository of typst due to distribution restrictions.

However you can easily install it locally as follows:

```bash
git clone git@github.com:lukasbm/leipzig-typst.git
cd leipzig-typst
# make sure you execute the python script from the project root!
python3 install.py  # run the cross-platform install script (just copies the source files to the right location)
```

## :rocket: Usage

After installing the dependencies (Fonts, git, Typst compiler) and the local package (using the python script),
you can start writing your own documents.
The default setup will look like this:

```typst
#import "@local/leipzig-typst:0.0.1": *

// initialize the template with this function (important!)
#show: leipzig-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Test Document],
    subtitle: [showing off the theme],
    author: [Lukas Böhm],
    institution: [Institut für Informatik],
    place: [Leipzig],
    date: datetime.today(),
    // optional: extra logos shown side-by-side on the title slide
    // logos: (image("logo-a.svg", height: 1.2cm), image("logo-b.svg", height: 1.2cm)),
  ),
)
```

You're ready to get going!
Write your first presentation. For example like this:

```typst
// the title slide reads its content from `config-info`
#title-slide()

// a level-1 heading becomes an intermission / section slide
= Introduction

// a level-2 heading becomes the slide header (ALL CAPS, bold);
// the optional subheader is passed to `#slide`
== What is this?

#slide(subheader: [A first slide])[
  This file demonstrates the usage of the Leipzig theme for Typst.

  - bullet points use orange dashes
    - and shrink from the second level on
]

// content directly after a level-2 heading does not even need `#slide`
== Another slide

Just write your content here.
```

## :sparkles: Examples

While more extensive documentation is in the works,
take a look at the [example directory](./example/) to get a better indication of how to use this template.

## :bulb: More Information

For more information, take a look at the [Developer Guide](./DEVELOPER.md)

## :page_facing_up: License

TODO

## :lightning: Debugging

### Touying Error

In case there are inexplicable compiler errors, try redownloading the dependency package (touying).
First delete it from [the cache where it is saved](https://docs.rs/dirs/latest/dirs/fn.cache_dir.html).
(e.g. `rm -rf ~/.cache/typst/packages/preview/touying` on linux) then try again.
