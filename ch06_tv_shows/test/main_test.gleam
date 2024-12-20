import gleam/list
import gleeunit
import gleeunit/should
import main.{ExtractSingleYearError, ExtractTitleError, ParseIntError, TvShow}

pub fn main() {
  gleeunit.main()
}

pub fn parse_show_test() {
  [
    #("The Wire (2002-2008)", Ok(TvShow("The Wire", 2002, 2008))),
    #("Breaking Bad (2008-2013)", Ok(TvShow("Breaking Bad", 2008, 2013))),
    #("Mad Men (2007-2015)", Ok(TvShow("Mad Men", 2007, 2015))),
    #("Scrubs (2001-2010)", Ok(TvShow("Scrubs", 2001, 2010))),
    #("Chernobyl (2019)", Ok(TvShow("Chernobyl", 2019, 2019))),
    #(
      "The Wire aired from 2002 to 2008",
      Error(ExtractTitleError("The Wire aired from 2002 to 2008")),
    ),
    #("Breaking Bad ()", Error(ParseIntError(""))),
    #("()", Error(ParseIntError(""))),
    #(
      ") - (Breaking Bad, 2008-2013",
      Error(ExtractSingleYearError(") - (Breaking Bad, 2008-2013")),
    ),
    #("Mad Men (-2015)", Error(ExtractSingleYearError("Mad Men (-2015)"))),
    #(
      "The Wire ( 2002 - 2008 )",
      Error(ExtractSingleYearError("The Wire ( 2002 - 2008 )")),
    ),
    #(
      "Stranger Things (2016-)",
      Error(ExtractSingleYearError("Stranger Things (2016-)")),
    ),
  ]
  |> list.each(fn(t) { main.parse_show(t.0) |> should.equal(t.1) })
}

pub fn parse_shows_best_effort_test() {
  [
    "The Wire (2002-2008)", "Breaking Bad (2008-2013)", "Mad Men (2007-2015)",
    "Scrubs (2001-2010)", "The Wire aired from 2002 to 2008", "Breaking Bad ()",
    "()", ") - (Breaking Bad, 2008-2013", "Mad Men (-2015)",
    "The Wire ( 2002 - 2008 )", "Stranger Things (2016-)",
  ]
  |> main.parse_shows_best_effort
  |> should.equal([
    TvShow("The Wire", 2002, 2008),
    TvShow("Breaking Bad", 2008, 2013),
    TvShow("Mad Men", 2007, 2015),
    TvShow("Scrubs", 2001, 2010),
  ])
}

pub fn parse_shows_test() {
  [
    #(
      [
        "The Wire (2002-2008)", "Breaking Bad (2008-2013)",
        "Mad Men (2007-2015)", "Scrubs (2001-2010)",
        "The Wire aired from 2002 to 2008", "Breaking Bad ()", "()",
        ") - (Breaking Bad, 2008-2013", "Mad Men (-2015)",
        "The Wire ( 2002 - 2008 )", "Stranger Things (2016-)",
      ],
      Error(ExtractTitleError("The Wire aired from 2002 to 2008")),
    ),
    #(
      [
        "The Wire (2002-2008)", "Breaking Bad (2008-2013)",
        "Mad Men (2007-2015)", "Scrubs (2001-2010)",
      ],
      Ok([
        TvShow("The Wire", 2002, 2008),
        TvShow("Breaking Bad", 2008, 2013),
        TvShow("Mad Men", 2007, 2015),
        TvShow("Scrubs", 2001, 2010),
      ]),
    ),
  ]
  |> list.each(fn(t) { main.parse_shows(t.0) |> should.equal(t.1) })
}

pub fn sort_shows_test() {
  [
    #(
      [
        TvShow("Breaking Bad", 2008, 2013),
        TvShow("The Wire", 2002, 2008),
        TvShow("Mad Men", 2007, 2015),
      ],
      [
        TvShow("Mad Men", 2007, 2015),
        TvShow("The Wire", 2002, 2008),
        TvShow("Breaking Bad", 2008, 2013),
      ],
    ),
  ]
  |> list.each(fn(t) { main.sort_shows(t.0) |> should.equal(t.1) })
}
