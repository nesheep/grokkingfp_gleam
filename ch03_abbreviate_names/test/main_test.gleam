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
    #("Alonzo Church Taro", Ok("A. Church Taro")),
    #("", Error(Nil)),
    #(" ", Error(Nil)),
    #(" Church", Error(Nil)),
    #("Alonzo ", Error(Nil)),
  ]
  |> list.each(fn(t) { f(t.0) |> should.equal(t.1) })
}
