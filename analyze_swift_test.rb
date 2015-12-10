require 'minitest/autorun'
require 'minitest/pride'
require_relative 'analyze_swift'

class AnalyzeSwiftTest < Minitest::Test
  def test_reads_in_lyrics_first_line
    path = "./fixtures/lyrics_sample.txt"
    swifty = AnalyzeSwift.new

    expected = "I'm alone, on my own\n"
    assert_equal expected, swifty.read_lyrics(path).first
  end

  def test_sanitize_string_of_text
    swifty = AnalyzeSwift.new
    string = "I said: \"That's a lie.\""
    expected = "i said that's a lie"

    assert_equal expected, swifty.clean(string)
  end

  def test_sanitize_and_join_strings_of_text
    path = "./fixtures/lyrics_sample.txt"
    swifty = AnalyzeSwift.new
    expected = "i'm alone on my own and that's all i know i'll be strong i'll be wrong oh but life goes on oh i'm just a girl trying to find a place in this world"

    assert_equal expected, swifty.join_lyrics(path)
  end

  def test_counts_unique_words_in_lyrics
    path = "./fixtures/lyrics_sample.txt"
    swifty = AnalyzeSwift.new

    assert_equal 28, swifty.analyze_lyrics(path)
  end

  def test_count_uniq_lyrics_returns_unique_words_and_respective_ocurrences_in_lyrics
    path = "./fixtures/lyrics_mini_sample.txt"
    swifty = AnalyzeSwift.new
    expected = { "i'm" => 1, "alone" => 1, "on" => 1, "my" => 1, "own" => 1, "i'll" => 2, "be" => 2, "strong" => 1, "wrong" => 1 }

    assert_equal expected, swifty.count_uniq_lyrics(path)
  end

  def test_counts_unique_words_in_lyrics
    path = "./swift_stats/lyrics.txt"
    swifty = AnalyzeSwift.new

    assert_equal 2013, swifty.analyze_lyrics(path)
  end

  def test_top_words_returns_top_used_word
    path = "./fixtures/lyrics_mini_sample.txt"
    swifty = AnalyzeSwift.new

    assert_equal ["be"], swifty.top_words(path, 1)
  end

  def test_top_words_returns_top_three_used_words
    path = "./fixtures/lyrics_mini_sample.txt"
    swifty = AnalyzeSwift.new

    assert_equal ["be", "i'll", "alone"], swifty.top_words(path, 3)
  end
end
