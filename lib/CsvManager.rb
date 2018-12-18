require 'csv'
require 'fileutils'

class CsvManager

    def self.saveToFile(filename,className)

        FileUtils.mkdir_p 'data'

        className.all.each do |elem|
          elem.delete(:id)
        end

        csv = CSV.open('data/'+filename,"w",
                       :write_headers => true,
                       :headers => data.first.keys
        )
        data.each do |elem|
          csv << elem
        end
    end

    def self.importFromCsv(filepath,className)

        options = { encoding:"UTF-8", headers: true, col_sep: ',', header_converters: :symbol, converters: :all}

        if className.is_a? String
            className = Module.const_get(className)
        end

        CSV.read(filepath, options).map do |row|
            h = row.to_hash
            h.delete(:id)
            className.create(h)
        end

    end


end