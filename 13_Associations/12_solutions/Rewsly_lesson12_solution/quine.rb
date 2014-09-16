puts "require 'quine'"
def quine(name)
  puts "def #{name}"
  method(name).call { |s| puts "  yield '#{s}'" }
  puts "end"
  puts "quine :#{name}"
end
