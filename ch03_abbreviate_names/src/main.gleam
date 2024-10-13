import gleam/result
import gleam/string

pub fn abbreviate(s: String) -> Result(String, Nil) {
  use #(a, b) <- result.try(s |> string.split_once(" "))
  use a_initial <- result.try(a |> string.first)
  case b |> string.is_empty {
    True -> Error(Nil)
    False -> Ok(a_initial <> ". " <> b)
  }
}
