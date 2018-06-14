# encoding: utf-8

version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name                      = 'active_record_to_xls'
  spec.version                   = version
  spec.author                    = "Gordon B. Isnor"
  spec.email                     = "info@isnorcreative.com"
  spec.homepage                  = "http://github.com/gordonbisnor/active_record_to_xls"
  spec.summary                   = "Export Rails ActiveRecord data to Excel XLS data"
  spec.description               = "This simple plugin gives you the ability to get XLS for a collection of ActiveRecord models."
  spec.files                     = Dir["{lib,test}/**/*", "[a-zA-Z]*", "init.rb"] - ["Gemfile.lock"]
  spec.require_path              = "lib"
  spec.license                   = 'MIT'
  spec.add_dependency('spreadsheet', '>= 0.8.5')
  spec.add_development_dependency "rspec"
  spec.platform                  = Gem::Platform::RUBY
  spec.required_rubygems_version = ">= 1.3.4"
end
