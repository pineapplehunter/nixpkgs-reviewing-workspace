orderedd_paths = STDIN.each_line.map(&:chomp)

module Concat
  def self.trim_header(str)
    str.slice(/---\n.+/m)
  end
end

puts File.read(orderedd_paths.shift)

orderedd_paths.each do |path|
  puts "\n", Concat.trim_header(File.read(path))
end
