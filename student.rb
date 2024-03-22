require_relative "csv_file_reader"

class Student < CSVFileReader
end 

s1= Student.new 
# s1.student_id= 3
# s1.student_name = "kiran"
# s1.teacher_name = "manoj"
# s1.subject= "maths"

# s1.student_id = 10
# s1.student_name = "Amit"
# s1.teacher_name = "Shilesh"
# s1.subject = "Physics"


# sd1= Student.find_by("student_id", 3)
# p sd1


class State < CSVFileReader
end 

s1= State.new 
s1.name = "Maharashtra"
s1.capital = "mumbai"
s1.population = "10crore"

# st.name = "Bihar"
# st.capital = "Patna"
# st.population = "22Crore"


# state = State.find_by("name","bihar")
# puts state.capital
