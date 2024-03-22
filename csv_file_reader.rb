require 'csv'

class CSVFileReader
  
    def initialize(attributes = {})
      @attributes = attributes
    end

    def method_missing(method_name, *args, &block)
      string_method = method_name.to_s
        # setter to dynamically set values to hash constructor.
      if string_method.end_with?('=')
        attr_name = string_method.chomp('=').to_sym
        @attributes[attr_name] = args.first
        save
        # getter if method call does not ends with '=' then its check that method call has a key corresponding method name.
      elsif @attributes.key?(string_method.to_sym)
        @attributes[string_method.to_sym]
      else
        # if no method call match it directs to an error of no method found.
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      # checks if it is an hash key by converting to symbol if not super looks to inheritance chain
      # it is convention to call res_to when msng_meth is invoked
      @attributes.key?(method_name.to_s.chomp('=').to_sym) || super
    end


    def self.file_path
      "#{name.downcase}s.csv" 
    end


    def save
      existing_data, existing_headers = read_existing_csv_data
      updated_headers = (existing_headers | @attributes.keys.map(&:to_s)).uniq  # combines new existing and new headers from array, create new array. 
    
      identifier_key = @attributes.keys.first.to_s  # Assumes the first key as the identifier
      # reads existing headers(first row) of array by key and holds new records.
      record_index = existing_data.index { |row| row[identifier_key] == @attributes[identifier_key.to_sym].to_s }
        
      if record_index.nil?
        # if no existing record is found it add new row of data to existing file.
        existing_data << @attributes.transform_keys(&:to_s)
      else
        # if header key exists it add data with corresponding row by merge method.
        existing_data[record_index].merge!(@attributes.transform_keys(&:to_s))
      end
        # adds updataed data to file  
      CSV.open(self.class.file_path, 'w', write_headers: true, headers: updated_headers) do |csv|
        existing_data.each do |row|
          csv << updated_headers.map { |header| row.fetch(header, nil) }
        end
      end
    end


    def self.find_by(attribute, value)
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        if row[attribute.to_sym].to_s == value.to_s
          return new(row.to_h)
        end
      end
      nils
    end


  private

    def read_existing_csv_data
        file_path = self.class.file_path 
        return [[], []] unless File.exist?(file_path) && !File.zero?(file_path)
        
        existing_data = CSV.read(file_path, headers: true).map(&:to_hash)
        existing_headers = existing_data.first&.keys || []
        [existing_data, existing_headers]
      end

  end

