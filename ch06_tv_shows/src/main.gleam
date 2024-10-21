import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

pub type TvShow {
  TvShow(title: String, start: Int, end: Int)
}

fn extract_title(raw_show: String) -> Result(String, Nil) {
  use #(s, _) <- result.try(string.split_once(raw_show, "("))
  let s = string.trim_right(s)
  Ok(s)
}

fn extract_year_start(raw_show: String) -> Result(Int, Nil) {
  use #(_, s) <- result.try(string.split_once(raw_show, "("))
  use #(s, _) <- result.try(string.split_once(s, "-"))
  int.parse(s)
}

fn extract_year_end(raw_show: String) -> Result(Int, Nil) {
  use #(_, s) <- result.try(string.split_once(raw_show, "-"))
  use #(s, _) <- result.try(string.split_once(s, ")"))
  int.parse(s)
}

fn extract_single_year(raw_show: String) -> Result(Int, Nil) {
  use #(_, s) <- result.try(string.split_once(raw_show, "("))
  use #(s, _) <- result.try(string.split_once(s, ")"))
  case string.starts_with(s, "-") {
    True -> Error(Nil)
    False -> int.parse(s)
  }
}

pub fn parse_show(raw_show: String) -> Result(TvShow, Nil) {
  use title <- result.try(extract_title(raw_show))
  use start <- result.try(
    extract_year_start(raw_show)
    |> result.try_recover(fn(_) { extract_single_year(raw_show) }),
  )
  use end <- result.try(
    extract_year_end(raw_show)
    |> result.try_recover(fn(_) { extract_single_year(raw_show) }),
  )
  Ok(TvShow(title:, start:, end:))
}

pub fn parse_shows_best_effort(raw_shows: List(String)) -> List(TvShow) {
  raw_shows
  |> list.map(parse_show)
  |> result.partition
  |> pair.first
  |> list.reverse
}

fn sort_by(list: List(a), by score: fn(a) -> Int) -> List(a) {
  list |> list.sort(fn(x, y) { int.compare(score(x), score(y)) })
}

pub fn sort_shows(shows: List(TvShow)) -> List(TvShow) {
  shows
  |> sort_by(fn(x) { x.end - x.start })
  |> list.reverse
}

pub fn main() {
  io.println("Hello from main!")
}
