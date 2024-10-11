import gleam/list

pub fn get_tip_percentage(names: List(String)) -> Int {
  case names |> list.length {
    0 -> 0
    n if n <= 5 -> 10
    _ -> 20
  }
}
