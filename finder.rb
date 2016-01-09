def find_file_name(dir, file_name, depth = 0)
  return nil unless Dir.exist? dir

  # depth = 0: only search current directory
  # depth < 0: search recursively
  # depth > 0: search till depth level subdirectory
  depth = depth <= 0 ? depth : depth - 1

  result = []

  old_dir = Dir.pwd
  Dir.chdir dir

  begin
    Dir.foreach "." do |entry|
      if depth != 0 and Dir.exist? entry
        next if [".", ".."].include? entry
        find_file_name(entry, file_name, depth).each do |x|
          result << File.join(dir, x)
        end
        next
      end
      if entry[file_name]
        result << File.join(dir, entry)
      end
    end
  ensure
    Dir.chdir old_dir
  end
  result
end

if ARGV.length < 1
  puts "usage: finder filename"
  exit
end

filename = ARGV[0]
puts find_file_name("./", filename, -1)

