import gleam/int
import gleam/list
import gleam/string

pub fn score(word: String) -> Int {
  word |> string.replace("a", "") |> string.length
}

pub fn bonus(word: String) -> Int {
  case word |> string.contains("c") {
    True -> 5
    False -> 0
  }
}

pub fn penalty(word: String) -> Int {
  case word |> string.contains("s") {
    True -> 7
    False -> 0
  }
}

pub fn score_with_bonus(word: String) -> Int {
  score(word) + bonus(word)
}

pub fn score_with_bonus_and_penalty(word: String) -> Int {
  score(word) + bonus(word) - penalty(word)
}

pub fn ranked_words(
  words: List(String),
  word_score: fn(String) -> Int,
) -> List(String) {
  words |> list.sort(fn(w1, w2) { int.compare(word_score(w2), word_score(w1)) })
}
