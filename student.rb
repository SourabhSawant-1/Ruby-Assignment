require_relative "csv_file_reader"


class Student < CSVFileReader
end

class State < CSVFileReader
end

class Country < CSVFileReader
end

s = Student.new
s.student_id = 10
s.student_name = "Amit"
s.teacher_name = "Shailesh"
s.subject = "Physics"
p s

puts 

s1 = Student.find_by("student_id", 3)
# p s1
puts s1.student_name # this should print kiran
puts s1.teacher_name # this should print manoj

puts

st = State.new
st.name = "Bihar"
st.capital = "Patna"
st.population = "22Crore"
p st

puts

st1 = State.find_by("name", "Karnataka")
# p st1
puts st1.capital # this should print bangalore
puts st1.population # this should print 6crore

