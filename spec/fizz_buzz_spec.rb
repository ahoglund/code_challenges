require 'fizz_buzz'

RSpec.describe FizzBuzz, "#ing" do
	
	context "multiples of 3 and 5" do
	  fizz_buzzed = FizzBuzz.ing(100)
		it "should print FizzBuzz for 15" do
	    expect(fizz_buzzed[14]).to eq "FizzBuzz"
	  end
		it "should print FizzBuzz for 15" do
	    expect(fizz_buzzed[29]).to eq "FizzBuzz"
	  end
		it "should print FizzBuzz for 15" do
	    expect(fizz_buzzed[44]).to eq "FizzBuzz"
	  end
	end

	context "multiples of 3" do
		fizz_buzzed = FizzBuzz.ing(100)
		it "should print Fizz for 3" do
		  expect(fizz_buzzed[2]).to eq "Fizz"
	  end
		it "should print Fizz for 3" do
		  expect(fizz_buzzed[5]).to eq "Fizz"
	  end
		it "should print Fizz for 3" do
		  expect(fizz_buzzed[8]).to eq "Fizz"
	  end
	end

	context "multiples of 5" do
	  fizz_buzzed = FizzBuzz.ing(100)
	  it "should print Buzz for 5" do
	    expect(fizz_buzzed[4]).to eq "Buzz"
    end
	  it "should print Buzz for 10" do
	    expect(fizz_buzzed[9]).to eq "Buzz"
    end
	  it "should print Buzz for 20" do
	    expect(fizz_buzzed[19]).to eq "Buzz"
    end
	end
end