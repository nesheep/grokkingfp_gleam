import gleam/int
import gleam/list
import gleam/string

pub fn sort_by(list: List(a), by score: fn(a) -> Int) -> List(a) {
  list |> list.sort(fn(x, y) { int.compare(score(x), score(y)) })
}

pub fn number_of_s(s: String) -> Int {
  s |> string.to_graphemes |> list.count(fn(c) { c == "s" })
}

pub fn negative(i: Int) -> Int {
  -i
}

pub fn negative_number_of_s(s: String) -> Int {
  s |> number_of_s |> negative
}
