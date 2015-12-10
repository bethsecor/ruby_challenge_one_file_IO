require 'pry'

class AnalyzeSwift
  def initialize
    @reader = FileReader.new
  end

  def read_lyrics(path)
    @reader.read(path).to_a
  end

  def clean(string)
    string.gsub(/[^a-z ']/i, '').downcase
  end

  def join_lyrics(path)
    lyric_lines = read_lyrics(path)
    # binding.pry
    clean(lyric_lines.join(' '))
  end

  def lyric_words(path)
    all_clean_lyrics = join_lyrics(path)
    all_clean_lyrics.split(' ')
  end

  def analyze_lyrics(path)
    lyric_words(path).uniq.count
  end

  def count_uniq_lyrics(path)
    words = lyric_words(path)
    counts = words.uniq.map do |word|
      [word, words.count(word)]
    end
    Hash[counts]
  end

  def top_words(path, num_words)
    sorted = count_uniq_lyrics(path).sort.sort_by { |w, c| [ -c, w ] }
    Hash[sorted].keys[0..num_words-1]
  end
end

class FileReader
  def read(path)
    File.new(path, "r")
  end
end
