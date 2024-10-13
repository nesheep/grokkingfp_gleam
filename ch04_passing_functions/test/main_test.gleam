import gleam/string
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn sort_by_len_test() {
  ["scala", "rust", "ada"]
  |> main.sort_by(string.length)
  |> should.equal(["ada", "rust", "scala"])
}

pub fn sort_by_number_of_s_test() {
  ["rust", "ada"]
  |> main.sort_by(main.number_of_s)
  |> should.equal(["ada", "rust"])
}

pub fn sort_by_negative_test() {
  [5, 1, 2, 4, 3]
  |> main.sort_by(main.negative)
  |> should.equal([5, 4, 3, 2, 1])
}

pub fn sort_by_negative_number_of_s_test() {
  ["ada", "rust"]
  |> main.sort_by(main.negative_number_of_s)
  |> should.equal(["rust", "ada"])
}
