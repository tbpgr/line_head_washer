# encoding: utf-8
require 'line_head_washer_dsl'

module LineHeadWasher
  #  LineHeadWasher Core
  class Core
    WASHER_FILE = 'Washerfile'
    WASHER_TEMPLATE = <<-EOS
# encoding: utf-8

# input file or directory by regexp
# input is required
# input allow only String
# input's default value => "./*.txt"
input "./*.txt"

# output directory
# output is required
# output allow only String
# output's default value => "./"
output "./"

# remove_regexp
# remove_regexp is required
# remove_regexp allow only String
# remove_regexp's default value => "[ |	]"
remove_regexp "[ |	]"
    EOS

    # generate Washerfile to current directory.
    def init
      File.open(WASHER_FILE, 'w') { |f|f.puts WASHER_TEMPLATE }
    end

    # remove line head specific charactors
    def execute
      dsl = get_dsl
      input, remove_regexp, output = get_in_out_removes(dsl)
      create_output_dir(output)
      Dir.glob(input).each do |file|
        input_src = get_input(file)
        replaced = remove_head(input_src, remove_regexp)
        output_file(file, replaced, output)
      end
    end

    private
    def get_dsl
      src = read_dsl
      dsl = LineHeadWasher::Dsl.new
      dsl.instance_eval src
      dsl
    end

    def get_in_out_removes(dsl)
      [dsl.line_head_washer.input, dsl.line_head_washer.remove_regexp, dsl.line_head_washer.output]
    end

    def create_output_dir(output)
      Dir.mkdir(output) unless Dir.exists? output
    end

    def get_input(file)
      File.read(file)
    end

    def output_file(file, replaced, output)
      filename = File.basename(file)
      File.open("#{output}/#{filename}", 'w:UTF-8') { |f|f.print replaced }
    end

    def remove_head(input_src, remove_regexp)
      input_src.gsub /^#{remove_regexp}/, ''
    end

    def read_dsl
      File.open(WASHER_FILE) { |f|f.read }
    end
  end
end
