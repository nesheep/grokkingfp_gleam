import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn first_two_test() {
  let f = main.first_two
  [
    #(["a", "b", "c"], Ok(#("a", "b"))),
    #(["a", "b"], Ok(#("a", "b"))),
    #(["a"], Error(Nil)),
    #([], Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn last_two_test() {
  let f = main.last_two
  [
    #(["a", "b", "c"], Ok(#("b", "c"))),
    #(["a", "b"], Ok(#("a", "b"))),
    #(["a"], Error(Nil)),
    #([], Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn moved_first_two_to_the_end_test() {
  let f = main.moved_first_two_to_the_end
  [
    #(["a", "b", "c"], Ok(["c", "a", "b"])),
    #(["a", "b"], Ok(["a", "b"])),
    #(["a"], Error(Nil)),
    #([], Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn inserted_before_last_test() {
  let f = main.inserted_before_last
  [
    #(#(["a", "b"], "c"), Ok(["a", "c", "b"])),
    #(#(["a"], "b"), Ok(["b", "a"])),
    #(#([], "a"), Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0.0, t.0.1) |> should.equal(t.1) })
}
