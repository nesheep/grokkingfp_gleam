import gleam/result
import gleam/string

pub fn increment(x: Int) -> Int {
  x + 1
}

pub fn get_first_character(s: String) -> String {
  s |> string.first |> result.unwrap("")
}

pub fn word_score(word: String) -> Int {
  word |> string.replace("a", "") |> string.length
}
