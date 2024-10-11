import gleam/float
import gleam/int
import gleam/list
import gleam/result

pub fn total_time(lap_times: List(Float)) -> Float {
  lap_times
  |> list.rest
  |> result.replace_error(0.0)
  |> result.map(float.sum)
  |> result.unwrap_both
}

pub fn avg_time(lap_times: List(Float)) -> Float {
  case list.length(lap_times) {
    0 | 1 -> 0.0
    n -> total_time(lap_times) /. int.to_float(n - 1)
  }
}
