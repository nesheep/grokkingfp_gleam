import gleam/io
import gleam/list

type Point {
  Point(x: Int, y: Int)
}

fn is_inside(point: Point, radius: Int) -> Bool {
  radius * radius >= point.x * point.x + point.y * point.y
}

pub fn main() {
  let points = [Point(5, 2), Point(1, 1)]
  let risky_radiuses = [-10, 0, 2]

  {
    let rs = risky_radiuses |> list.filter(fn(r) { r > 0 })
    use r <- list.flat_map(rs)
    points |> list.filter(is_inside(_, r))
  }
  |> io.debug

  Nil
}
