pub type MusicGenre {
  HeavyMetal
  Pop
  HardRock
}

pub type Location {
  Location(name: String)
}

pub type YearsActive {
  StillActive(since: Int)
  ActiveBetween(start: Int, end: Int)
}

pub type Artist {
  Artist(
    name: String,
    genre: MusicGenre,
    origin: Location,
    years_active: YearsActive,
  )
}

pub fn was_artist_active(
  artists: Artist,
  year_start: Int,
  year_end: Int,
) -> Bool {
  case artists.years_active {
    StillActive(since) -> since <= year_end
    ActiveBetween(start, end) -> start <= year_end && end >= year_start
  }
}

pub fn active_length(artist: Artist, current_year: Int) -> Int {
  case artist.years_active {
    StillActive(since) -> current_year - since
    ActiveBetween(start, end) -> end - start
  }
}
