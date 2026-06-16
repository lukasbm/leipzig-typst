#import "@preview/polylux:0.4.0": toolbox
#import "../leipzig-typst.typ": main
#import main: *

#show: main.setup-theme.with(
  aspect-ratio: "16-9",
  short-author: "Lukas Böhm",
  short-title: "Test Document",
  short-date: datetime.today(),
  short-organization: "Lab1",
)

#title-slide(
  title: "Test Document showing off the theme",
  subtitle: "in Typst, the new Markup Language",
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institute",
      email: "tung@artos.edu",
    ),
    (name: "Eugene Deklan", affiliation: "Honduras State"),
    (name: "Lukas Böhm"),
  ),
)

#section-slide("The Basics")

#slide(
  title: "Introduction",
  subtitle: "What is this?",
)[
  This file demonstrates the usage of the FAU theme for typst.

  You can simply start by importing the theme for your institution (RW, Phil, Med,
  Tech, Nat, FAU) and then use the `#setup-theme` function to set it up:

  ```typst
    #import "@preview/polylux:0.4.0": *
    #import "../leipzig-typst.typ": nat-theme, main
    #import nat-theme: *

    #show: main.setup-theme.with(
      short-author: "Lukas Böhm",
      short-title: "Test Document",
      short-date: datetime.today(),
      short-organization: "Lab1",
    )
    ```

]

#slide(
  title: "Sections",
  subtitle: "And how to use them",
)[
  Sections in slides are always tricky to handle.

  In this template level 1 headings defined like: `= Heading of level 1` are
  disabled. Instead you use `#section-slide("Title")`. This will register the
  section and generate an overview slide with the current section highlighted.

  The other heading levels should work as intended.

  = Should not show!
  == Should show second level heading
  === and 3rd level as well
]

#slide(title: "Full slide")[
  Slides with too much content are automatically broken up

  #lorem(200)

  *Still the same slide!*
]

#slide(title: "Side by Side", subtitle: "Organizing content on the slide")[
  #align(horizon + center)[
    #toolbox.side-by-side[
      #lorem(7)
    ][
      #lorem(10)
    ][
      #lorem(5)
    ]
  ]
]

#slide(title: "Blocks")[
  A block is a container for content, it can have a title and any content.

  #fau-block(title: "Block Header")[
    Block content
  ]

  Use any environment (like grid) to shape and align blocks.

  // #grid(columns: (1fr, 1fr), gutter: 2em, fau-block()[
  //   smaller block (no title)
  // ], fau-block(title: "hey there")[
  //   smaller block (with title)
  // ])
]

#slide(
  title: "A very very very very very very very very very very long title",
)[
  This is a slide with a very long title, it should be wrapped to the next line
  and the subtitle should be hidden.
]

#slide(title: "Info Environments", subtitle: "`terms`, Lists and Enumerate")[
  #set align(horizon)

  - This is a list
  - with items
    - and inner items

  + This is an enumerate
    + inner enumeration
  + with some more items

  / Term1: A terms element.
  / Term2: With some fancy words.

  Inline `code` is also available. ```bash
                                  echo "and raw code blocks as well"
                                  ```
]

#slide(
  title: "Graphics",
)[
  #import "../lib/colors.typ": WortmarkeBlue
  #figure(image(WortmarkeBlue.source, height: 75%), caption: "This is a caption") <fig:logo>

  The image @fig:logo is a figure with a caption.
]

// TODO: slide showing off animations/overlays
// hopefully this would work given this issue exists: https://github.com/andreasKroepelin/polylux/issues/128

#section-slide("Color Palette")

#slide(
  title: "Institutional Themes",
)[
  #align(
    horizon,
  )[
    the FAU theme comes with a set of institutional themes, which can be used to
    change the colors of the entire presentation.

    The following options are available:
    - FAU
    - RW
    - Med
    - Nat
    - Tech
  ]
]

#slide(title: "The Colors", subtitle: "Base and Dark theme")[
  How to use color themes:

  #let box-size = 2cm
  #set align(horizon + center)

  #grid(columns: (auto, auto), gutter: 8cm, table(
    stroke: none,
    inset: 1pt,
    columns: (box-size, auto),
    align: left,
    column-gutter: 1em,
    rect(width: box-size, height: box-size, fill: BaseColor),
    `BaseColor`,
    rect(width: box-size, height: box-size, fill: BaseColorA),
    `BaseColorA`,
    rect(width: box-size, height: box-size, fill: BaseColorB),
    `BaseColorB`,
    rect(width: box-size, height: box-size, fill: BaseColorC),
    `BaseColorC`,
    rect(width: box-size, height: box-size, fill: BaseColorD),
    `BaseColorD`,
  ), table(
    stroke: none,
    inset: 1pt,
    columns: (box-size, auto),
    align: left,
    column-gutter: 1em,
    rect(width: box-size, height: box-size, fill: BaseDarkColor),
    `BaseDarkColor`,
    rect(width: box-size, height: box-size, fill: BaseDarkColorA),
    `BaseDarkColorA`,
    rect(width: box-size, height: box-size, fill: BaseDarkColorB),
    `BaseDarkColorB`,
    rect(width: box-size, height: box-size, fill: BaseDarkColorC),
    `BaseDarkColorC`,
    rect(width: box-size, height: box-size, fill: BaseDarkColorD),
    `BaseDarkColorD`,
  ))
]

#section-slide("Slide Environments")

#slide(title: "Normal Slide", subtitle: "With normal dimensions")[
  #box(width: 100%, height: 100%, fill: luma(75%))[
    #align(horizon + center)[
      This is the area you can fill on a normal slide created with: ```typst
                                                                          #slide(title: "Title")[
                                                                          content
                                                                          ]
                                                                        ```
    ]
  ]
]

#slide-plain[
  #box(width: 100%, height: 100%, fill: luma(75%))[
    #align(horizon + center)[
      more space ```typst
                          #slide-plain(title: "Title")[
                          content
                          ]
                        ```
    ]
  ]
]

#slide-fullscreen[
  #box(width: 100%, height: 100%, fill: luma(75%))[
    #align(horizon + center)[
      even more space ```typst
                  #slide-fullscreen(title: "Title")[
                    content
                  ]
                  ```
    ]
  ]
]

#focus-slide(
  title: "Focus Slide",
)[
  This is a focus slide, it is a slide that is not part of the normal flow of the
  presentation, but can be used to focus on a specific topic.

  The content is centered and text looks like a quote.
]

#section-slide("Equations and Math")

#slide(title: "Equations")[
  #align(horizon)[
    $ A = pi r^2 $
    $ "area" = pi dot "radius"^2 $
    $ cal(A) :=
    { x in RR | x "is natural" } $
    #let x = 5
    $ #x < 17 $
  ]
]

#section-slide("Citations")

#slide(title: "Citations", subtitle: "And footnotes!")[
  #align(horizon)[
    This is a citation: @bungert2021bregman
  ]

  You can just as easily add footnotes #footnote("hey there!").

  #bibliography("test.bib")
]

#section-slide("Presentation")

#slide(
  title: "Notes and pdfpc",
)[
  The presentation can be exported to pdf and used with #link("https://pdfpc.github.io/")[pdfpc] to
  present it. Pdfpc is a presenter console with multi-monitor support, allowing
  you to have presenter specific tools like laser-pointer, notes and a timer on a
  second screen.

  By using the special `#toolbox.pdfpc.speaker-note(body)` function from polylux you can
  add notes to your slides that will only be visible to the presenter.
  
  #toolbox.pdfpc.speaker-note("This is a note only the speaker will see")

  The body can be regular text as well as raw Markdown.

  Take a look at the #link(
    "https://andreaskroepelin.github.io/polylux/book/external/pdfpc.html",
  )[polylux documentation] for more information.
]
