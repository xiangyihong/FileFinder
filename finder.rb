
def find_file_name(dir, file_name, depth = 0)
  return nil unless Dir.exist? dir

  old_dir = Dir.pwd
  Dir.chdir dir

  # depth = 0: only search current directory
  # depth < 0: search recursively
  # depth > 0: search till depth level subdirectory
  depth = depth <= 0 ? depth : depth - 1
  
  result = []
  begin
    Dir.foreach dir do |entry|
      if depth != 0 and Dir.exist? entry
        result << find_file_name(entry, file_name, depth)
        next
      end
    
      if File.basename(entry)[file_name]
        result << entry
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
puts find_file_name("./", filename)

