# ActiveRecordToXls

This gem will generate XLS data for a collection of ActiveRecord models.

It was forked from the [to_xls-rails gem](https://github.com/liangwenke/to_xls-rails).

## Installation

**Gemfile**:

```ruby
gem 'active_record_to_xls'
```

**config/initializers/mime_types.rb**:

```ruby
Mime::Type.register_alias "text/excel", :xls
```

## Usage

**controller**: 

format.xls {
  filename = “my_export.xls”
  send_data ActiveRecordToXls.call(Widget.all)
}

**view:**  

```ruby  
link_to 'Export Excel', my_action_path(format: :xls)
```

### Options  

#### client_encoding

- **Type:** String  
- **Default**: UTF-8

#### only 

- **Type:** Array

Will only include the columns specified in this array:

```ruby
send_data ActiveRecordToXls.call( Widget.all, only: [:title, :body] )
```

#### except 

- **Type:** Array

Will omit the columns specified in this array, eg:

```ruby
send_data ActiveRecordToXls.call( Widget.all, omit: [:id] )
```

#### prepend
  
- **Type:** Array of row arrays

Will prepend above header:

```ruby
send_data ActiveRecordToXls.call( Widget.all, prepend: [["Col 0, Row 0", "Col 1, Row 0"], ["Col 0, Row 1"]] )
```

#### header

- **Type:** true or false
- **Default:** false

Will omit the header row:

```ruby
send_data ActiveRecordToXls.call( Widget.all, header: false )
```

#### header_columns

- **Type**: Array

Specify header column names:

```ruby
send_data ActiveRecordToXls.call( Widget.all, header: false , header_columns: ['Title', 'Description])
```

#### column_width

- **Type:** Array of integers

Set column widths:

```ruby
send_data ActiveRecordToXls.call( Widget.all, column_width: [17,15,15,40,25,37] )
```

#### append

- **Type:** Array of row arrays

Will append this row at end, eg:

```ruby
send_data ActiveRecordToXls.call( Widget.all, append: [["Col 0, Row 0", "Col 1, Row 0"], ["Col 0, Row 1"]] )
```

  