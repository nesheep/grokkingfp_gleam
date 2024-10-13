import gleam/list

pub fn first_two(list: List(a)) -> Result(#(a, a), Nil) {
  case list {
    [a, b, ..] -> Ok(#(a, b))
    _ -> Error(Nil)
  }
}

pub fn last_two(list: List(a)) -> Result(#(a, a), Nil) {
  case list |> list.reverse {
    [a, b, ..] -> Ok(#(b, a))
    _ -> Error(Nil)
  }
}

pub fn moved_first_two_to_the_end(list: List(a)) -> Result(List(a), Nil) {
  case list {
    [a, b, ..rest] -> Ok(rest |> list.append([a, b]))
    _ -> Error(Nil)
  }
}

pub fn inserted_before_last(list: List(a), element: a) -> Result(List(a), Nil) {
  case list |> list.reverse {
    [a, ..rest] -> Ok([a, element, ..rest] |> list.reverse)
    _ -> Error(Nil)
  }
}
