import gleam/io
import gleam/list

type Book {
  Book(title: String, authors: List(String))
}

fn recommended_books(friend: String) -> List(Book) {
  let scala = [
    Book("FP in Scala", ["Chiusano", "Bjarnason"]),
    Book("Get Programming with Scala", ["Sfregola"]),
  ]

  let fiction = [
    Book("Harry Potter", ["Rowling"]),
    Book("The Lord of the Rings", ["Tolkien"]),
  ]

  case friend {
    "Alice" -> scala
    "Bob" -> fiction
    _ -> []
  }
}

pub fn main() {
  let friends = ["Alice", "Bob", "Charlie"]

  let recommendations = friends |> list.flat_map(recommended_books)
  recommendations |> io.debug

  let authors = recommendations |> list.flat_map(fn(b) { b.authors })
  authors |> io.debug

  friends
  |> list.flat_map(recommended_books)
  |> list.flat_map(fn(b) { b.authors })
  |> io.debug

  Nil
}
