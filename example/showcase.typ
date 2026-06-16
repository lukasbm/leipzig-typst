#import "../leipzig-typst.typ": *

#show: leipzig-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Leipzig Typst Theme],
    subtitle: [Das Corporate Design der Universität Leipzig],
    author: [Lukas Böhm],
    institution: [Institut für Informatik],
    place: [Leipzig],
    date: datetime.today(),
    // Title-slide logos must be constructed on your side so that the image
    // paths resolve relative to *this* document.
    logos: (
      image("../assets/logo_leipzig.svg", height: 1.1cm),
    ),
  ),
)

// The title slide reads its content from `config-info` above.
#title-slide()

// A level-1 heading automatically becomes an intermission / section slide.
= Grundlagen

// A level-2 heading becomes the slide header (ALL CAPS, bold). The optional
// subheader is passed to `#slide`.
== Aufbau einer Folie

#slide(subheader: [Kopf, Inhalt und Fuß])[
  Jede Folie besteht aus

  - einem *Kopf* mit Präsentationstitel und Untertitel,
  - dem *Inhalt* mit Folienüberschrift und optionaler Unterüberschrift,
  - und einer *Fußzeile* mit Logo, Institution und Seitenzahl.

  Aufzählungen ab der zweiten Ebene werden automatisch kleiner gesetzt:
  - erste Ebene (18 pt)
    - zweite Ebene (16 pt)
      - dritte Ebene
]

// You do not need `#slide` for simple slides — content directly after a
// level-2 heading is wrapped automatically.
== Eine einfache Folie

Inhalt, der direkt auf die Überschrift folgt, landet ebenfalls auf einer
eigenen Folie.

#lorem(30)

= Weitere Elemente

== Nebeneinander

#slide(subheader: [Mehrspaltige Layouts])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    [
      #lorem(20)
    ],
    [
      #lorem(25)
    ],
  )
]

== Zu viel Inhalt

#slide[
  Folien mit zu viel Inhalt werden automatisch umbrochen.

  #lorem(90)

  *Immer noch dieselbe Folie!*
]

// A focus slide draws attention to a single statement.
#focus-slide[
  Vielen Dank!
]
