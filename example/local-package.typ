#import "@local/leipzig-typst:0.0.1": *

#show: leipzig-theme.with(
  config-info(
    title: [Test Document showing off the theme],
    subtitle: [in Typst, the new markup language],
    author: [Lukas Böhm],
    institution: [Institut für Informatik],
    place: [Leipzig],
    date: datetime.today(),
  ),
)

#title-slide()

= Introduction

== What is this?

#slide(subheader: [A first slide])[
  This file demonstrates the usage of the Leipzig theme for Typst, installed as
  a local package.
]
