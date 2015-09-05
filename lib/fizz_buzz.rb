class FizzBuzz
	def self.ing(n)
		out = []
		(1..n).each do |i|
		  if i % 15 == 0
		    out << "FizzBuzz" 
		  elsif i % 5 == 0
		    out << "Buzz"
		  elsif i % 3 == 0
		    out << "Fizz"
		  else
		    out << i
		  end
		end
		out
	end
end