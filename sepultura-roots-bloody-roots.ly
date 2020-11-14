\version "2.20.0"

\include "articulate.ly"
\include "snippets/ly/tablature/bending.ily"

\header {
  title = "Roots Bloody Roots"
  composer = "Sepultura"
  source = "https://www.songsterr.com/a/wsa/jbo-roots-bloody-roots-pabbarottifriends-bass-tab-s439446t2"
  tagline = ##f
}

\paper {
  markup-system-spacing.padding = #3
  system-system-spacing.padding = #5
}

intro = {
  b,,16( c8.) c8[ b16( c8.)] c8 b16([ c8.)]
}

chorus = {
  b16( c8.) c8[ b16( c8.)] c8 b16([ cis8.)]
}

verse = {
  \repeat unfold 4 f16\5
  \repeat unfold 4 e\5
  \repeat unfold 3 d
  \repeat unfold 3 cis
  \repeat unfold 2 d
}

solo = {
  c8\5 b, b c'\5 c\5 c\5 \bendOn e,8\5( eis) \bendOff
}

song = \relative c {
  \numericTimeSignature
  \time 4/4
  % Don't put the initial silence in the MIDI
  \tag #'score {
    \compressMMRests { R1*8 }
  }
  \override Score.RehearsalMark.self-alignment-X = #LEFT
  \mark "Intro"
  \repeat unfold 8 \intro
  \mark "Chorus 1"
  \repeat unfold 8 \chorus
  \break
  \mark "Verse 1"
  \repeat unfold 8 \relative c \intro
  \break
  \repeat unfold 3 \verse
  \repeat unfold 4 \relative c \intro
  \break
  \mark "Chorus 2"
  \repeat unfold 8 \chorus
  \break
  \mark "Verse 2"
  \repeat unfold 4 \relative c \intro
  \break
  \mark "Bridge"
  \repeat unfold 4 {
    b8 b r2.
  }
  \time 2/4
  \partial 2
  b16 b b r16 r4
  \time 4/4
  r2. c'4\5 \glissando
  \mark "Verse 3"
  \repeat unfold 8 \relative c \intro
  \break
  \repeat unfold 3 \relative c,, \verse
  \mark "Guitar solo"
  \repeat unfold 8 \solo
  \mark "Ending"
  \repeat unfold 8 { c'8\5 }
  \repeat unfold 3 {
    c,\5 b\5 r cis\5[ c\5] r c\5 b\5
    r cis\5 c\5 r c\5 r c\5 r
  }
  c\5 b\5 r cis\5 c\5 r c\5 b\5
  r cis\5 c\5 r c\5 r8 r4
  \tempo 4 = 115
  \repeat unfold 3 {
    c4\5 r2.
  }
  \repeat unfold 7 {
    \repeat unfold 5 c8\5 b\5 r4
  }
  \repeat unfold 5 c8\5 r8 r4
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
    \once \override Score.RehearsalMark.direction = #DOWN
    \mark \markup { \small "BEADG Tuning" }
    \song
  }
>>

\score {
  \keepWithTag #'score \staff
  \layout {
    \context {
      % See https://github.com/openlilylib/snippets/tree/master/notation-snippets/guitar-string-bending#limitations
      \StaffGroup
      \override StaffGrouper.staff-staff-spacing.padding = #5
    }
  }
}

\score {
  \unfoldRepeats \articulate \keepWithTag #'midi \staff
  \midi {}
}
