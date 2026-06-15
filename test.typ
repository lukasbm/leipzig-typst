#import "@preview/touying:0.7.4": *
#import "leipzig-typst.typ": *   // your local copy

#show: leipzig-theme.with(
  aspect-ratio: "16-9",
  config-info(title: "test"),
)


== Formatierungsanmerkung

#slide[
  Überschriften, Zwischenüberschriften und Fließtext werden beim Eintippen der ersten Textzeile automatisch formatiert.
  - Aufzählungen können über die Schaltfläche „Aufzählungszeichen“ eingestellt werden.
  - Nach einem Umbruch (Enter) erscheint ein weiteres Aufzählungszeichen.
    - Durch Drücken der Tabulatortaste wird der Text im Format der nächsten Gliederungseben dargestellt.

  *Titel und Fußzeile* der Präsentation können automatisch für alle Folien geändert werden unter Ansicht/Folienmaster. Dort auf der Masterfolie 2 den Text bearbeiten.
]

= Intermission

== Another slide

#slide[
  hi

  #title_corner_shape
]

// TODO: subtitle!
