require 'colorize'
require 'unicode'

class Show
  def initialize
    @keywords = YAML.load_file('keywords.yml')
  end

  def show (names, opinions)
    names.each do |name|
      unless opinions.include?(name)
        opinions[name] = ['Не найдено отзывов']
      end
    end
    opinions.each do |name, opinions|
      puts name
      puts '====='
      opinions.each do |opinion|
        estimate_and_print(opinion)
      end
      puts ''
    end
  end

  def estimate_and_print(opinion)
    mark = estimate(opinion)
    case mark
    when 1..Float::INFINITY
      puts opinion.green
    when -Float::INFINITY..-1
      puts opinion.red
    when 0
      puts opinion
    end
    puts ''
  end

  def estimate(opinion)
    mark = 0
    raw = Unicode.downcase(opinion)
    @keywords['positive'].each { |word| mark += raw.scan(word).count }
    @keywords['negative'].each { |word| mark -= raw.scan(word).count }
    mark
  end
end
