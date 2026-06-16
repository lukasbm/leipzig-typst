#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": corner-design, leipzig-footer, leipzig-header, plaque

// Regular content slide.
//
// The slide header (ALL CAPS, bold) is taken from the preceding level-2
// heading (`== ...`); the optional subheader (ALL CAPS) is passed explicitly.
//
// - subheader (content, none): the slide subheader shown below the header.
#let slide(
  subheader: none,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(header: leipzig-header, footer: leipzig-footer),
  )
  let new-setting = body => {
    show: setting
    set align(top + left)
    // Slide header from the current level-2 heading + optional subheader.
    block(
      width: 100%,
      below: 0.8em,
      {
        context {
          let h = utils.current-heading(level: 2, depth: self.slide-level)
          if h != none {
            text(
              size: slide-header-size,
              weight: "bold",
              fill: LeipzigSchwarz,
              upper(h.body),
            )
          }
        }
        if subheader != none {
          linebreak()
          text(size: subheader-size, fill: LeipzigSchwarz, upper(subheader))
        }
      },
    )
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


// Title slide: a blank page with the Leipzig plaque in the top-left, a
// vertically centered text block (subtitle, title, place/date, author, logos)
// and the three-coloured corner accent in the bottom-right.
//
// Reads `title`, `subtitle`, `author`, `date`, `place` and `logos` from the
// presentation info (set via `config-info`); any of them may also be passed
// directly to `title-slide`. `logos` is an array of already-constructed
// `image(..)` values (paths are resolved relative to your document, so they
// must be built on your side).
#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(header: none, footer: none, margin: 0pt, fill: LeipzigWeiss),
    config,
  )
  let info = self.info + args.named()
  let pad-x = 1.4cm
  let logos = info.at("logos", default: ())
  let talk-place = info.at("place", default: none)

  let meta-line(left, right) = {
    set text(size: date-size, fill: LeipzigSchwarz)
    if left != none and right != none {
      [#left, #right]
    } else if left != none {
      left
    } else if right != none {
      right
    }
  }

  let blocks = ()
  if info.subtitle != none {
    blocks.push(text(size: subtitle-size, fill: LeipzigSchwarz, info.subtitle))
  }
  if info.title != none {
    blocks.push(text(
      size: title-size,
      weight: "bold",
      fill: LeipzigSchwarz,
      upper(info.title),
    ))
  }
  if talk-place != none or info.date != none {
    blocks.push(meta-line(
      talk-place,
      if info.date != none { utils.display-info-date(self) },
    ))
  }
  if info.author != none {
    blocks.push(text(size: date-size, fill: LeipzigSchwarz, info.author))
  }
  if logos != () {
    blocks.push(stack(dir: ltr, spacing: 1cm, ..logos))
  }

  let body = {
    place(top + left, dx: pad-x, dy: 1.2cm, plaque(height: 2.2cm))
    place(bottom + right, corner-design(size: 15cm))
    align(
      horizon + left,
      pad(x: pad-x, stack(dir: ttb, spacing: 0.9em, ..blocks)),
    )
  }
  touying-slide(self: self, body)
})


// Intermission / section slide, generated automatically for every level-1
// heading (`= ...`). White title on the primary colour, no header or footer.
#let intermission(
  config: (:),
  level: 1,
  numbered: false,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.primary, header: none, footer: none),
  )
  let slide-body = {
    set align(horizon + left)
    set text(fill: self.colors.neutral-lightest)
    block({
      text(
        size: title-size,
        weight: "bold",
        upper(utils.display-current-heading(level: level, numbered: numbered)),
      )
      if body != none {
        linebreak()
        text(size: subtitle-size, body)
      }
    })
  }
  touying-slide(self: self, config: config, slide-body)
})


// Focus slide: large centered content on the primary colour, used to draw
// attention to a single statement.
#let focus-slide(
  config: (:),
  background: auto,
  foreground: auto,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if background == auto { self.colors.primary } else { background },
      header: none,
      footer: none,
      margin: 2em,
    ),
  )
  set text(
    fill: if foreground == auto { self.colors.neutral-lightest } else {
      foreground
    },
    weight: "bold",
    size: title-size,
  )
  touying-slide(self: self, config: config, align(center + horizon, body))
})
