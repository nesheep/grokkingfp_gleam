import gleam/list

pub type ProgrammingLanguage {
  ProgrammingLanguage(name: String, year: Int)
}

pub fn language_names(langs: List(ProgrammingLanguage)) -> List(String) {
  langs |> list.map(fn(lang) { lang.name })
}
