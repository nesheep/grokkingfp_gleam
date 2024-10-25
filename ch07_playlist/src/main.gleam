import gleam/list
import gleam/set.{type Set}

pub type User {
  User(name: String)
}

pub type Artist {
  Artist(name: String)
}

pub type MusicGenre {
  House
  Funk
  HipHop
}

pub type PlaylistKind {
  CuratedByUser(user: User)
  BasedOnArtist(artist: Artist)
  BasedOnGenres(genres: Set(MusicGenre))
}

pub type Song {
  Song(artist: Artist, title: String)
}

pub type Playlist {
  Playlist(name: String, kind: PlaylistKind, songs: List(Song))
}

pub fn gather_songs(
  playlists: List(Playlist),
  artist: Artist,
  genre: MusicGenre,
) -> List(Song) {
  use playlist <- list.flat_map(playlists)
  case playlist.kind {
    CuratedByUser(_) ->
      playlist.songs |> list.filter(fn(s) { s.artist == artist })
    BasedOnArtist(a) ->
      case a == artist {
        True -> playlist.songs
        False -> []
      }
    BasedOnGenres(gs) ->
      case set.contains(gs, genre) {
        True -> playlist.songs
        False -> []
      }
  }
}
