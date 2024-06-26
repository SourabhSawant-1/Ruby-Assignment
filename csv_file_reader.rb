require 'csv'

class CSVFileReader

  def self.inherited(subclass)
    file_path = "#{subclass.name.downcase}s.csv"
    
    if File.exist?(file_path)
      headers = CSV.read(file_path, headers: true).headers
      # Dynamically defining attribute accessors based on CSV headers
      subclass.class_eval do
          attr_accessor *headers
      end
    end
  end


  def self.find_by(header, value)
    CSV.foreach("#{self.to_s.downcase}s.csv", headers: true, header_converters: :symbol) do |row|
      if row[header.to_sym].to_s == value.to_s
        obj = new
        row.to_h.each do |k, v|
          obj.instance_variable_set("@#{k}", v)
        end
        return obj
      end
    end
    nil
  end 
end



# def save
#   file_name = "#{self.class.name.downcase}s.csv"
#   existing_data, existing_headers = read_existing_csv_data
  
#   CSV.open(file_name, 'a', write_headers: !File.exist?(file_name), headers: existing_headers) do |csv|
#     csv << existing_headers.map { |header| send(header) }
#   end
# end
