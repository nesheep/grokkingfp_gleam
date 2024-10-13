import gleam/list
import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn abbreviate_test() {
  let f = main.abbreviate
  [
    #("Alonzo Church", Ok("A. Church")),
    #("A. Church", Ok("A. Church")),
    #("A Church", Ok("A. Church")),
    #("", Error(Nil)),
    #(" ", Error(Nil)),
    #(" Church", Error(Nil)),
    #("Alonzo ", Error(Nil)),
    #("Alonzo Church Taro", Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}
