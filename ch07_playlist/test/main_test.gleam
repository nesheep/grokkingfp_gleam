import gleam/set
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn gather_songs_test() {
  let foo_fighters = main.Artist("Foo Fighters")
  let playlist1 =
    main.Playlist("This is Foo Fighters", main.BasedOnArtist(foo_fighters), [
      main.Song(foo_fighters, "Breakout"),
      main.Song(foo_fighters, "Learn To Fly"),
    ])
  let playlist2 =
    main.Playlist(
      "Deep Focus",
      main.BasedOnGenres(set.from_list([main.House, main.Funk])),
      [
        main.Song(main.Artist("Daft Punk"), "One More Time"),
        main.Song(main.Artist("The Chemical Brothers"), "Hey Boy Hey Girl"),
      ],
    )
  let playlist3 =
    main.Playlist(
      "My Playlist",
      main.CuratedByUser(main.User("Michał Płachta")),
      [
        main.Song(foo_fighters, "My Hero"),
        main.Song(main.Artist("Iron Maiden"), "The Trooper"),
      ],
    )

  main.gather_songs([playlist1, playlist2, playlist3], foo_fighters, main.Funk)
  |> should.equal([
    main.Song(foo_fighters, "Breakout"),
    main.Song(foo_fighters, "Learn To Fly"),
    main.Song(main.Artist("Daft Punk"), "One More Time"),
    main.Song(main.Artist("The Chemical Brothers"), "Hey Boy Hey Girl"),
    main.Song(foo_fighters, "My Hero"),
  ])
}
