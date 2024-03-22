require_relative "test4"

class State < CSVEditor
end 

s1= State.new 
# s1.name="kearal"
# s1.capital="tvm"
# s1.population="4crore"
# s1.save

s1.find_by("name", "kearal")
puts s1.population
puts s1.capital

