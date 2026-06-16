#import "@preview/touying:0.7.4": utils
#import "colors.typ": *
#import "fonts.typ": *

#import "@preview/cetz:0.5.2": intersection

// The University of Leipzig logo (seal + "UNIVERSITÄT LEIPZIG" wordmark).
// Used as the large plaque on the title slide and as the small logo in the
// footer of every content slide.
#let leipzig-logo = "../assets/logo_leipzig.svg"

#let plaque(height: 1.6cm) = image(leipzig-logo, height: height)

// The three-coloured corner accent placed in the bottom-right corner of the
// title slide. The polygon coordinates are resolved against `size` explicitly
// (absolute lengths) so the shape is deterministic regardless of context.
#let corner-design(size: 100%) = {
  let p(x, y) = (x * size, y * size)
  let right-top = p(1.0, 0.0)
  let right-middle = p(1.0, 0.7)
  let outer-corner = p(1.0, 1.0)
  let bottom-left = p(0.6, 1.0)
  let bottom-middle = p(0.9, 1.0)
  let inner-corner = intersection.line-line(
    // line 1
    right-top,
    bottom-middle,
    // line 2
    bottom-left,
    right-middle,
    // vars
    ray: false,
    eps: 0.003,
  )

  box(width: size, height: size, {
    place(polygon(
      fill: LeipzigAquamarin,
      stroke: none,
      bottom-left,
      bottom-middle,
      inner-corner,
    ))
    place(polygon(
      fill: LeipzigGranat,
      stroke: none,
      right-top,
      right-center,
      inner-corner,
    ))
    place(polygon(
      fill: LeipzigKarneol,
      stroke: none,
      bottom-middle,
      inner-corner,
      right-middle,
      outer-corner,
    ))
  })
}


#let side-design(size: 100%) = {
  let p(x, y) = (x * size, y * size)

  let top-left = p(0.6, 0.0)
  let top-middle = p(0.93, 0.0)
  let top-right = p(1.0, 0.0)
  let bottom-left = p(0.65, 1.0)
  let bottom-center1 = p(0.9, 1.0)
  let bottom-center2 = p(0.95, 1.0)
  let inner-corner = intersection.line-line(
    // line 1
    bottom-left,
    top-middle,
    // line 2,
    top-left,
    bottom-center1,
    //
    ray: false,
    eps: 0.003,
  )
  // parallel to bottom-left - inner-corner line! translate the line vector and get intersection with right side of page.
  let right-middle = intersection.line-line(
    // line 1: the right side
    (1.0, 0.0),
    (1.0, 1.0),
    // line 2: moved parallel
    bottom-center2,
    (inner-corner.at(0) + bottom-center2 - bottom-left.at(0), inner-corner.at(1)),
    ray: true,
    eps: 0.03,
  )
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
