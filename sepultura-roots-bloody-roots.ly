\version "2.20.0"

\include "articulate.ly"

\include "bend-helpers.ly"
\include "bend-stencils.ly"
\include "bend-grob-defs.ly"
\include "bend-music-functions.ly"

\header {
  title = "Roots Bloody Roots"
  composer = "Sepultura"
  author = \markup \fromproperty #'header:composer
  subject = \markup \concat {
    "Bass partition for “"
    \fromproperty #'header:title
    "” by "
    \fromproperty #'header:composer
  }
  source = "https://www.songsterr.com/a/wsa/jbo-roots-bloody-roots-pabbarottifriends-bass-tab-s439446t2"
  keywords = #(string-join '(
    "music"
    "partition"
    "bass"
  ) ", ")
  tagline = ##f
}

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 3
}

section = #(define-music-function (text) (string?) #{
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT
  \once \override Score.RehearsalMark.padding = #2
  \mark \markup \override #'(thickness . 2) \rounded-box \bold #text
#})

intro = {
  b,,16( c8.) c8[ b16( c8.)] c8 b16([ c8.)]
}

chorus = {
  b16( c8.) c8[ b16( c8.)] c8 b16([ cis8.)]
}

verse = {
  \repeat unfold 4 f16
  \repeat unfold 4 e
  \repeat unfold 3 d
  \repeat unfold 3 cis
  \repeat unfold 2 d
}

solo = {
  c8\4 b, b c'\4 c\4 c\4 e,8\5 \startBend eis \stopBend
}

song = \relative c {
  \numericTimeSignature
  \time 4/4
  % Don't put the initial silence in the MIDI
  \tag #'score {
    \compressMMRests R1*8
  }
  \override Score.RehearsalMark.self-alignment-X = #LEFT
  \section "Intro"
  \repeat unfold 8 \intro
  \section "Chorus 1"
  \repeat unfold 8 \chorus
  \break
  \section "Verse 1"
  \repeat unfold 8 \relative c \intro
  \break
  \repeat unfold 3 \verse
  \repeat unfold 4 \relative c \intro
  \break
  \section "Chorus 2"
  \repeat unfold 8 \chorus
  \break
  \section "Verse 2"
  \repeat unfold 4 \relative c \intro
  \break
  \section "Bridge"
  \repeat unfold 4 {
    b8 b r2.
  }
  \time 2/4
  \partial 2
  b16 b b r16 r4
  \time 4/4
  r2. c'4\4 \glissando
  \section "Verse 3"
  \repeat unfold 8 \relative c \intro
  \break
  \repeat unfold 3 \relative c,, \verse
  \section "Guitar solo"
  \repeat unfold 8 \solo
  \section "Ending"
  \repeat unfold 8 { c'8 }
  \repeat unfold 3 {
    c, b r cis[ c] r c b
    r cis c r c r c r
  }
  c b r cis c r c b
  r cis c r c r8 r4
  \tempo 4 = 115
  \repeat unfold 3 {
    c4 r2.
  }
  \repeat unfold 7 {
    \repeat unfold 5 { c8 } b r4
  }
  \repeat unfold 5 { c8 } r8 r4
}

staff = \new StaffGroup \with {
  midiInstrument = #"electric bass (finger)"
} <<
  \new Staff \with { \omit StringNumber } {
    \clef "bass_15"
    \once \override Score.MetronomeMark.extra-offset = #'(-3 . 0)
    \tempo 4 = 120
    \song
  }
  \new TabStaff \with { stringTunings = #bass-five-string-tuning } {
    \clef moderntab
    \song
  }
>>

\markup {
  \center-column {
    \line{Standard 5-string tuning}
    \concat{
       \left-column{
        \line{\circle 1 = G}
        \line{\circle 2 = D}
        \line{\circle 3 = A}
      }
      \hspace #3
      \right-column{
        \line{\circle 4 = E}
        \line{\circle 5 = B}
      }
    }
  }
}

\score {
  \keepWithTag #'score \staff
}

\score {
  \unfoldRepeats \articulate \keepWithTag #'midi \staff
  \midi {}
}
