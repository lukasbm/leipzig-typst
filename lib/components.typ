#import "@preview/touying:0.7.4": utils
#import "colors.typ": *
#import "fonts.typ": *

// The University of Leipzig logo (seal + "UNIVERSITÄT LEIPZIG" wordmark).
// Used as the large plaque on the title slide and as the small logo in the
// footer of every content slide.
#let leipzig-logo = "../assets/logo_leipzig.svg"

#let plaque(height: 1.6cm) = image(leipzig-logo, height: height)

// The three-coloured corner accent placed in the bottom-right corner of the
// title slide. The polygon coordinates are resolved against `size` explicitly
// (absolute lengths) so the shape is deterministic regardless of context.
#let title-corner-shape(size: 3.5cm) = {
  let p(x, y) = (x * size, y * size)
  let inner-corner = p(0.90, 0.90)
  let start-left = p(1.00, 0.00)
  let start-top = p(0.70, 1.00)
  let outer-corner = p(1.00, 1.00)
  let mid-left = p(0.87, 1.00)
  let mid-top = p(1.00, 0.87)

  box(width: size, height: size, {
    place(polygon(
      fill: LeipzigAquamarin,
      stroke: none,
      start-left,
      outer-corner,
      inner-corner,
    ))
    place(polygon(
      fill: LeipzigGranat,
      stroke: none,
      start-top,
      mid-top,
      inner-corner,
    ))
    place(polygon(
      fill: LeipzigKarneol,
      stroke: none,
      mid-left,
      inner-corner,
      mid-top,
      outer-corner,
    ))
  })
}

// Orange en-dash used as the list marker on every level.
#let list-marker = text(fill: LeipzigOrange, [–])

// Page header: a short orange rule followed by the presentation title and
// subtitle, all on a single line (Kopf- und Fußzeile, 12pt).
#let leipzig-header(self) = {
  set text(size: header-footer-size, fill: LeipzigSchwarz)
  set align(left + horizon)
  let title = self.info.title
  let subtitle = self.info.subtitle
  grid(
    columns: (1cm, auto),
    column-gutter: 0.6em,
    align: horizon + left,
    line(length: 100%, stroke: 1.5pt + LeipzigOrange),
    {
      if title != none { strong(title) }
      if title != none and subtitle != none { h(0.5em) }
      if subtitle != none { subtitle }
    },
  )
}

// Page footer: the Leipzig logo, the institution and the current slide number
// (right-aligned, in red), all on a single line.
#let leipzig-footer(self) = {
  set text(size: header-footer-size, fill: LeipzigSchwarz)
  set align(left + horizon)
  grid(
    columns: (auto, auto, 1fr, auto),
    column-gutter: 0.8em,
    align: horizon + left,
    plaque(height: 0.55cm),
    if self.info.institution != none { self.info.institution },
    none,
    align(
      right + horizon,
      text(
        size: page-number-size,
        fill: LeipzigGranat,
        context utils.slide-counter.display(),
      ),
    ),
  )
}
