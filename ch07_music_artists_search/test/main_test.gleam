import gleam/list
import gleeunit
import gleeunit/should
import main.{
  type Artist, ActiveInPast, Artist, HardRock, HeavyMetal, Location,
  PeriodInYears, Pop, StillActive, active_length,
}

pub fn main() {
  gleeunit.main()
}

type ActiveTengthTest {
  ActiveTengthTest(args: ActiveTengthArgs, want: Int)
}

type ActiveTengthArgs {
  ActiveTengthArgs(artist: Artist, current_year: Int)
}

pub fn active_length_test() {
  let tests = [
    ActiveTengthTest(
      args: ActiveTengthArgs(
        artist: Artist(
          "Metallica",
          HeavyMetal,
          Location("U.S."),
          StillActive(1981, []),
        ),
        current_year: 2022,
      ),
      want: 41,
    ),
    ActiveTengthTest(
      args: ActiveTengthArgs(
        artist: Artist(
          "Led Zeppelin",
          HardRock,
          Location("England"),
          ActiveInPast([PeriodInYears(1968, 1980)]),
        ),
        current_year: 2022,
      ),
      want: 12,
    ),
    ActiveTengthTest(
      args: ActiveTengthArgs(
        artist: Artist(
          "Bee Gees",
          Pop,
          Location("England"),
          ActiveInPast([PeriodInYears(1958, 2003)]),
        ),
        current_year: 2022,
      ),
      want: 45,
    ),
  ]
  list.each(tests, fn(t) {
    active_length(t.args.artist, t.args.current_year)
    |> should.equal(t.want)
  })
}
