// #import "lib/main.typ";
#import "@preview/touying:0.7.4": *
#import "lib/colors.typ": *


#let title_corner_shape = {
  let inner_corner = (90%, 90%)
  let start_left = (100%, 0%)
  let start_top = (70%, 100%)
  let outer_corner = (100%, 100%)
  let mid_left = (87%, 100%)
  let mid_top = (100%, 87%)

  polygon(
    fill: LeipzigGranat,
    stroke: none,
    start_top,
    mid_top,
    inner_corner,
  )
  polygon(
    fill: LeipzigAquamarin,
    stroke: none,
    start_left,
    outer_corner,
    inner_corner,
  )
  polygon(
    fill: LeipzigKarneol,
    stroke: none,
    mid_left,
    inner_corner,
    mid_top,
    outer_corner,
  )
}


#let header() = {
  
}

#let footer() = {

}



#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

#let focus-slide(
  config: (:),
  background: auto,
  foreground: white,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: if background == auto {
      self.colors.primary
    } else {
      background
    }),
  )
  set text(fill: foreground, size: 1.5em)
  touying-slide(self: self, config: config, align(center + horizon, body))
})


#let leipzig-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  show: touying-slides.with(
    // config-page(
    //   utils.page-args-from-aspect-ratio(aspect-ratio),
    // ),
    config-common(
      slide-fn: slide,
      // new-section-slide-fn: new-section-slide,
    ),
    config-methods(),
    config-colors(
      neutral: LeipzigBasalt,
      neutral-light: LeipzigHellgrau,
      neutral-lightest: LeipzigWeiss,
      neutral-darkest: LeipzigSchwarz,
      primary: LeipzigGranat,
      primary-light: LeipzigKarneol,
      secondary: LeipzigAquamarin,
      tertiary: LeipzigOrange,
    ),
    // save the variables for later use
    config-store(),
    ..args,
  )

  body
}
