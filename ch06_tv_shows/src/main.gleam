import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type TvShow {
  TvShow(title: String, start: Int, end: Int)
}

pub type ParseError {
  ExtractTitleError(String)
  ExtractYearStartError(String)
  ExtractYearEndError(String)
  ExtractSingleYearError(String)
  ParseIntError(String)
}

fn extract_title(raw_show: String) -> Result(String, ParseError) {
  use #(s, _) <- result.try(
    string.split_once(raw_show, "(")
    |> result.replace_error(ExtractTitleError(raw_show)),
  )
  Ok(string.trim_right(s))
}

fn extract_year_start(raw_show: String) -> Result(Int, ParseError) {
  use #(_, s) <- result.try(
    string.split_once(raw_show, "(")
    |> result.replace_error(ExtractYearStartError(raw_show)),
  )
  use #(s, _) <- result.try(
    string.split_once(s, "-")
    |> result.replace_error(ExtractYearStartError(raw_show)),
  )
  int.parse(s)
  |> result.replace_error(ParseIntError(s))
}

fn extract_year_end(raw_show: String) -> Result(Int, ParseError) {
  use #(_, s) <- result.try(
    string.split_once(raw_show, "-")
    |> result.replace_error(ExtractYearEndError(raw_show)),
  )
  use #(s, _) <- result.try(
    string.split_once(s, ")")
    |> result.replace_error(ExtractYearEndError(raw_show)),
  )
  int.parse(s)
  |> result.replace_error(ParseIntError(s))
}

fn extract_single_year(raw_show: String) -> Result(Int, ParseError) {
  use #(_, s) <- result.try(
    string.split_once(raw_show, "(")
    |> result.replace_error(ExtractSingleYearError(raw_show)),
  )
  use #(s, _) <- result.try(
    string.split_once(s, ")")
    |> result.replace_error(ExtractSingleYearError(raw_show)),
  )
  case string.contains(s, "-") {
    True -> Error(ExtractSingleYearError(raw_show))
    False -> int.parse(s) |> result.replace_error(ParseIntError(s))
  }
}

pub fn parse_show(raw_show: String) -> Result(TvShow, ParseError) {
  use title <- result.try(extract_title(raw_show))
  use start <- result.try(
    extract_year_start(raw_show)
    |> result.lazy_or(fn() { extract_single_year(raw_show) }),
  )
  use end <- result.try(
    extract_year_end(raw_show)
    |> result.lazy_or(fn() { extract_single_year(raw_show) }),
  )
  Ok(TvShow(title:, start:, end:))
}

pub fn parse_shows_best_effort(raw_shows: List(String)) -> List(TvShow) {
  raw_shows
  |> list.map(parse_show)
  |> result.values
}

fn add_or_resign(
  parsed_shows: Result(List(TvShow), ParseError),
  new_parsed_show: Result(TvShow, ParseError),
) -> Result(List(TvShow), ParseError) {
  use parsed_shows <- result.try(parsed_shows)
  use new_parsed_show <- result.try(new_parsed_show)
  Ok([new_parsed_show, ..parsed_shows])
}

pub fn parse_shows(raw_shows: List(String)) -> Result(List(TvShow), ParseError) {
  raw_shows
  |> list.map(parse_show)
  |> list.fold(Ok([]), add_or_resign)
  |> result.map(list.reverse)
}

fn sort_by(list: List(a), by score: fn(a) -> Int) -> List(a) {
  list |> list.sort(fn(x, y) { int.compare(score(x), score(y)) })
}

pub fn sort_shows(shows: List(TvShow)) -> List(TvShow) {
  shows
  |> sort_by(fn(x) { x.end - x.start })
  |> list.reverse
}
