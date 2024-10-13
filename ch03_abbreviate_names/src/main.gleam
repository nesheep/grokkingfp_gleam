import gleam/result
import gleam/string

pub fn abbreviate(s: String) -> Result(String, Nil) {
  use #(a, b) <- result.try(case s |> string.split(" ") {
    [a, b] -> Ok(#(a, b))
    _ -> Error(Nil)
  })

  use #(a_initial, b) <- result.try(case string.first(a), string.is_empty(b) {
    Ok(a_initial), False -> Ok(#(a_initial, b))
    _, _ -> Error(Nil)
  })

  Ok(a_initial <> ". " <> b)
}
