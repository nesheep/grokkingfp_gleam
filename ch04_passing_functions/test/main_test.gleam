import gleam/int
import gleam/list
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

pub fn map_len_test() {
  ["scala", "rust", "ada"]
  |> list.map(string.length)
  |> should.equal([5, 4, 3])
}

pub fn map_number_of_s_test() {
  ["rust", "ada"]
  |> list.map(main.number_of_s)
  |> should.equal([1, 0])
}

pub fn map_negative_test() {
  [5, 1, 2, 4, 3]
  |> list.map(main.negative)
  |> should.equal([-5, -1, -2, -4, -3])
}

pub fn map_double_test() {
  [5, 1, 2, 4, 3]
  |> list.map(fn(x) { x * 2 })
  |> should.equal([10, 2, 4, 8, 6])
}

pub fn total_test() {
  [5, 1, 2, 4, 100]
  |> list.fold(0, int.add)
  |> should.equal(112)
}

pub fn total_len_test() {
  ["scala", "rust", "ada"]
  |> list.fold(0, fn(acc, x) { acc + string.length(x) })
  |> should.equal(12)
}

pub fn total_s_test() {
  ["scala", "haskell", "rust", "ada"]
  |> list.fold(0, fn(acc, x) { acc + main.number_of_s(x) })
  |> should.equal(3)
}

pub fn max_test() {
  [5, 1, 2, 4, 15]
  |> list.reduce(int.max)
  |> should.equal(Ok(15))
}
