import gleeunit
import gleeunit/should
import main

pub fn main() {
  gleeunit.main()
}

pub fn ranked_words_test() {
  let score_fn = main.score
  ["ada", "haskell", "scala", "java", "rust"]
  |> main.ranked_words(score_fn)
  |> should.equal(["haskell", "rust", "scala", "java", "ada"])
}

pub fn ranked_words_with_bonus_test() {
  let score_fn = main.score_with_bonus
  ["ada", "haskell", "scala", "java", "rust"]
  |> main.ranked_words(score_fn)
  |> should.equal(["scala", "haskell", "rust", "java", "ada"])
}

pub fn ranked_words_with_bonus_and_penalty_test() {
  let score_fn = main.score_with_bonus_and_penalty
  ["ada", "haskell", "scala", "java", "rust"]
  |> main.ranked_words(score_fn)
  |> should.equal(["java", "ada", "scala", "haskell", "rust"])
}
