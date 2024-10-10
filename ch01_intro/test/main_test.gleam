import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn increment_test() {
  let f = main.increment
  [#(-10, -9), #(-1, 0), #(0, 1), #(9, 10)]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn get_first_character_test() {
  let f = main.get_first_character
  [#("hello", "h"), #("", "")]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn word_score_test() {
  let f = main.word_score
  [#("imperative", 9), #("no", 2), #("declarative", 9), #("yes", 3)]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}
