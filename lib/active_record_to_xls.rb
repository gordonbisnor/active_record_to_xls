require 'spreadsheet'

class ActiveRecordToXls

  def self.call(target, options = {}, &block)

    return '' if target.nil? && options[:prepend].nil?

    columns = []
    
    show_header = options[:header] == true

    xls_report = StringIO.new

    Spreadsheet.client_encoding = options[:client_encoding] || "UTF-8"

    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    columns = if options[:only]
      Array(options[:only]).map(&:to_sym)
    elsif !target.nil?
      if target.first.is_a? Hash
        target.first.keys.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
      else
        target.first.attributes.keys.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
      end
    end

    return '' if columns.empty? && options[:prepend].nil?

    sheet_index = 0

    options[:prepend].map { |arr| sheet.row(sheet_index).concat(arr); sheet_index += 1 } unless options[:prepend].nil?

    if show_header
      sheet.row(sheet_index).concat(options[:header_columns].nil? ? columns.map(&:to_s).map(&:humanize) : options[:header_columns])
      sheet_index += 1
    end
    
    options[:column_width].each_index { |index| sheet.column(index).width = options[:column_width][index] } if options[:column_width]

    target.each_with_index do |obj, i|
      if block
        sheet.row(sheet_index).replace(columns.map { |col| block.call(col, obj.is_a?(Hash) ? obj[col] : obj.send(col), i) } )
      else
        sheet.row(sheet_index).replace(columns.map { |col| obj.is_a?(Hash) ? obj[col] : obj.send(col) } )
      end
      sheet_index += 1
    end
    
    options[:append].map { |arr| sheet.row(sheet_index).concat(arr); sheet_index += 1 } unless options[:append].nil?

    book.write(xls_report)

    xls_report.string
  end

end