#!/usr/bin/env ruby

def ToBinary(bits, b)
  i = 0
  while i < bits.length
    if b.positive? && (bits[i] == 1)
      bits[i] = 0
      b -= 1
    end
    i += 1
  end
  bits
end

stack = []
got_symbol = false
loop do
  lexem = gets
  if ["+", "-", "/", "*", "!", "^"].include? lexem.chr
    b = stack.pop
    a = stack.pop
    case lexem.chr
    when "+" then stack.push(a + b)
    when "-" then stack.push(a - b)
    when "*" then stack.push(a * b)
    when "^" then stack.push(a**b)
    when "!" then
      bits = []
      a = a.to_i
      loop do
        bits.push(a % 2)
        a /= 2
        break if a.negative? || a.zero?
      end
      bits.reverse!
      bits = ToBinary(bits, b)
      i = 0
      result = 0
      while i < bits.length
        result += bits[i] * (2**i)
        i += 1
      end
      stack.push(result)
    when "/" then
      if b.zero?
        puts "Division by zero. " + a.to_s + "/" + b.to_s
      else
        stack.push(a / b)
      end
    end
    got_symbol = true
  else
    stack.push(lexem.to_f)
  end
  break if stack.length < 2 && got_symbol
end

puts "#=> " + stack.pop.to_s
