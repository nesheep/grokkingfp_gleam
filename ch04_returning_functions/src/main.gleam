import gleam/list
import gleam/string

pub fn larger_than(n: Int) -> fn(Int) -> Bool {
  fn(i) { i > n }
}

pub fn divisible_by(n: Int) -> fn(Int) -> Bool {
  fn(i) { i % n == 0 }
}

pub fn shorter_than(n: Int) -> fn(String) -> Bool {
  fn(s) { string.length(s) < n }
}

pub fn number_of_s(s: String) -> Int {
  s |> string.to_graphemes |> list.count(fn(c) { c == "s" })
}

pub fn contains_s(n: Int) -> fn(String) -> Bool {
  fn(s) { number_of_s(s) >= n }
}
