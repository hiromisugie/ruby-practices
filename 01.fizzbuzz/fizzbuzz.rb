(1..20).each do |a|
  if a % 3 == 0 && a % 5 == 0
    puts "FizzBuzz"
  elsif a % 3 == 0
    puts "Fizz"
  elsif a % 5 == 0
    puts "Buzz"
  else
    puts a
  end
end
