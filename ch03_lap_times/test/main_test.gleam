import gleam/float
import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn total_time_test() {
  let f = main.total_time
  [#([], 0.0), #([31.0], 0.0), #([31.0, 20.9, 21.1, 21.3], 63.3)]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}

pub fn avg_time_test() {
  let f = main.avg_time
  let helper = fn(f) { f |> float.multiply(10.0) |> float.round }

  [#([], 0.0), #([31.0], 0.0), #([31.0, 20.9, 21.1, 21.3], 21.1)]
  |> list.each(fn(t) { { f(t.0) |> helper } |> should.equal(t.1 |> helper) })
}
