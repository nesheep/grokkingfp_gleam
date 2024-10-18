import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn larger_than_test() {
  [5, 1, 2, 4, 0]
  |> list.filter(main.larger_than(4))
  |> should.equal([5])

  [5, 1, 2, 4, 0]
  |> list.filter(main.larger_than(1))
  |> should.equal([5, 2, 4])
}

pub fn divisible_by_test() {
  [5, 1, 2, 4, 15]
  |> list.filter(main.divisible_by(5))
  |> should.equal([5, 15])

  [5, 1, 2, 4, 15]
  |> list.filter(main.divisible_by(2))
  |> should.equal([2, 4])
}

pub fn shorter_than_test() {
  ["scala", "ada"]
  |> list.filter(main.shorter_than(4))
  |> should.equal(["ada"])

  ["scala", "ada"]
  |> list.filter(main.shorter_than(7))
  |> should.equal(["scala", "ada"])
}

pub fn contains_s_test() {
  ["rust", "ada"]
  |> list.filter(main.contains_s(3))
  |> should.equal([])

  ["rust", "ada"]
  |> list.filter(main.contains_s(1))
  |> should.equal(["rust"])
}
