# encoding: utf-8
require 'spec_helper'
require 'line_head_washer_core'

describe LineHeadWasher::Core do

  context :execute do
    TMP_WASHER = 'tmp_washer'
    WASHER_CASE1 = <<-EOS
# encoding: utf-8
input "./input/*.txt"
output "output"
remove_regexp "[ |\t|　]*"
    EOS

# rubocop:disable Tab
    CONTENTS1 = <<-EOS
hoge
  hige
　　huge
		hege
    EOS
# rubocop:enable Tab

    CONTENTS2 = <<-EOS
hoge
hige
huge　　
hege
    EOS
    EXPECTED1 = <<-EOS
hoge
hige
huge
hege
    EOS
    EXPECTED2 = <<-EOS
hoge
hige
huge　　
hege
    EOS
    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        washerfile: WASHER_CASE1,
        input_contents: [CONTENTS1, CONTENTS2],
        input_file_names: ['./input/test1.txt', './input/test2.txt'],
        output_file_names: ['./output/test1.txt', './output/test2.txt'],
        expected_contents: [EXPECTED1, EXPECTED2]
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          line_head_washer_core = LineHeadWasher::Core.new

          # -- when --
          line_head_washer_core.execute

          # -- then --
          c[:output_file_names].each_with_index { |v, i|expect(File.read(v).encode('UTF-16BE', 'UTF-8', invalid: :replace, undef: :replace, replace: '?').encode('UTF-8')).to eq(c[:expected_contents][i]) }
        ensure
          case_after c
        end
      end

      def case_before(c)
        Dir.mkdir(TMP_WASHER) unless File.exist?(TMP_WASHER)
        Dir.chdir(TMP_WASHER)
        Dir.mkdir('input')
        File.open(LineHeadWasher::Core::WASHER_FILE, 'w:UTF-8') { |f|f.print c[:washerfile] }
        c[:input_file_names].each_with_index do |v, i|
          File.open(v, 'w:UTF-8') { |f|f.print c[:input_contents][i] }
        end
      end

      def case_after(c) # rubocop:disable UnusedMethodArgument
        Dir.chdir('../')
        return unless File.exist? TMP_WASHER
        FileUtils.rm_rf("./#{TMP_WASHER}")
      end
    end
  end
end
