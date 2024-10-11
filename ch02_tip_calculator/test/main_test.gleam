import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn get_tip_percentage_test() {
  let f = main.get_tip_percentage
  [
    #([], 0),
    #(["a"], 10),
    #(["a", "b", "c", "d", "e"], 10),
    #(["a", "b", "c", "d", "e", "f"], 20),
    #(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"], 20),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}
