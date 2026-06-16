#import "@preview/touying:0.7.4": utils
#import "colors.typ": *
#import "fonts.typ": *

#import "@preview/cetz:0.5.2": intersection

// The University of Leipzig logo (seal + "UNIVERSITÄT LEIPZIG" wordmark).
// Used as the large plaque on the title slide and as the small logo in the
// footer of every content slide.
#let leipzig-logo = "../assets/logo_leipzig.svg"

#let plaque(height: 1.6cm) = image(leipzig-logo, height: height)

// The three-coloured corner accent for the title slide.
//
// All geometry is computed with plain, unitless numbers in the unit square
// `(0,0)` (top-left) .. `(1,1)` (bottom-right) — this is required because
// cetz's intersection math takes dot products of the coordinates, which only
// works on numbers, not lengths.
//
// The resulting points are emitted as ratios (`%`), so this is simply a built
// polygon that fills whatever square box it is placed in. Placing it inside a
// square keeps the shape independent of the page aspect ratio (see
// `title-slide` in slides.typ).
#let corner-design = {
  let right-top = (1.0, 0.0)
  let right-middle = (1.0, 0.7)
  let outer-corner = (1.0, 1.0)
  let bottom-left = (0.6, 1.0)
  let bottom-middle = (0.9, 1.0)
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

  // Map a unitless point to relative (ratio) coordinates and draw a polygon.
  let rel(p) = (p.at(0) * 100%, p.at(1) * 100%)
  let shape(fill, ..points) = place(polygon(
    fill: fill,
    stroke: none,
    ..points.pos().map(rel),
  ))

  shape(LeipzigAquamarin, bottom-left, bottom-middle, inner-corner)
  shape(LeipzigGranat, right-top, right-middle, inner-corner)
  shape(LeipzigKarneol, bottom-middle, inner-corner, right-middle, outer-corner)
}


// A taller "side band" variant of the accent. Same conventions as
// `corner-design`: unitless geometry in the unit square, emitted as ratios so
// it fills whatever square box it is placed in.
#let side-design = {
  let top-left = (0.6, 0.0)
  let top-middle = (0.93, 0.0)
  let top-right = (1.0, 0.0)
  let bottom-left = (0.65, 1.0)
  let bottom-center1 = (0.9, 1.0)
  let bottom-center2 = (0.95, 1.0)
  let inner-corner = intersection.line-line(
    // line 1
    bottom-left,
    top-middle,
    // line 2
    top-left,
    bottom-center1,
    //
    ray: false,
    eps: 0.003,
  )
  // A line parallel to (bottom-left -> inner-corner) but passing through
  // bottom-center2, intersected with the right edge of the page.
  let dir = (inner-corner.at(0) - bottom-left.at(0), inner-corner.at(1) - bottom-left.at(1))
  let right-middle = intersection.line-line(
    // line 1: the right edge
    (1.0, 0.0),
    (1.0, 1.0),
    // line 2: parallel, through bottom-center2
    bottom-center2,
    (bottom-center2.at(0) + dir.at(0), bottom-center2.at(1) + dir.at(1)),
    ray: true,
    eps: 0.03,
  )

  let rel(p) = (p.at(0) * 100%, p.at(1) * 100%)
  let shape(fill, ..points) = place(polygon(
    fill: fill,
    stroke: none,
    ..points.pos().map(rel),
  ))

  shape(LeipzigAquamarin, top-left, inner-corner, bottom-left)
  shape(LeipzigGranat, top-left, top-middle, inner-corner)
  shape(
    LeipzigKarneol,
    top-middle,
    top-right,
    right-middle,
    bottom-center2,
    bottom-center1,
    inner-corner,
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
