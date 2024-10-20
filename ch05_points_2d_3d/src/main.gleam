import gleam/io
import gleam/list

type Point {
  Point(x: Int, y: Int)
}

type Point3d {
  Point3d(x: Int, y: Int, z: Int)
}

pub fn main() {
  let xs = [1]
  let ys = [-2, 7]
  let zs = [3, 4]

  let points =
    xs
    |> list.flat_map(fn(x) {
      ys
      |> list.map(fn(y) { Point(x, y) })
    })
  points |> io.debug

  let points = {
    use x <- list.flat_map(xs)
    use y <- list.map(ys)
    Point(x, y)
  }
  points |> io.debug

  let point3ds = {
    use x <- list.flat_map(xs)
    use y <- list.flat_map(ys)
    use z <- list.map(zs)
    Point3d(x, y, z)
  }
  point3ds |> io.debug

  Nil
}
