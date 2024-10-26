import gleam/int
import gleam/list

pub type MusicGenre {
  HeavyMetal
  Pop
  HardRock
}

pub type Location {
  Location(name: String)
}

pub type PeriodInYears {
  PeriodInYears(start: Int, end: Int)
}

pub type YearsActive {
  StillActive(since: Int, previous_periods: List(PeriodInYears))
  ActiveInPast(periods: List(PeriodInYears))
}

pub type Artist {
  Artist(
    name: String,
    genre: MusicGenre,
    origin: Location,
    years_active: YearsActive,
  )
}

pub fn period_overlaps_with_periods(
  checked_period: PeriodInYears,
  periods: List(PeriodInYears),
) -> Bool {
  list.any(periods, fn(p) {
    p.start <= checked_period.end && p.end >= checked_period.start
  })
}

pub fn was_artist_active(artists: Artist, search_period: PeriodInYears) -> Bool {
  case artists.years_active {
    StillActive(since, previous_periods) ->
      since <= search_period.end
      || period_overlaps_with_periods(search_period, previous_periods)
    ActiveInPast(periods) ->
      period_overlaps_with_periods(search_period, periods)
  }
}

pub fn active_length(artist: Artist, current_year: Int) -> Int {
  case artist.years_active {
    StillActive(since, previous_periods) -> [
      PeriodInYears(since, current_year),
      ..previous_periods
    ]
    ActiveInPast(periods) -> periods
  }
  |> list.map(fn(p) { p.end - p.start })
  |> list.fold(0, int.add)
}

pub type SearchCondition {
  SearchByGenre(genres: List(MusicGenre))
  SearchByOrigin(locations: List(Location))
  SearchByActiveYears(period: PeriodInYears)
  SearchByActiveLength(how_long: Int, until: Int)
}

pub fn search_artists(
  artists: List(Artist),
  required_conditions: List(SearchCondition),
) -> List(Artist) {
  list.filter(artists, fn(artist) {
    use cond <- list.all(required_conditions)
    case cond {
      SearchByGenre(genres) -> list.contains(genres, artist.genre)
      SearchByOrigin(locations) -> list.contains(locations, artist.origin)
      SearchByActiveYears(period) -> was_artist_active(artist, period)
      SearchByActiveLength(how_long, until) ->
        active_length(artist, until) >= how_long
    }
  })
}
