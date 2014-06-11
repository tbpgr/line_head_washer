# encoding: utf-8
require 'line_head_washer_dsl_model'

module LineHeadWasher
  class Dsl
    attr_accessor :line_head_washer

    # String Define
    [:input, :output, :remove_regexp].each do |f|
      define_method f do |value|
        eval "@line_head_washer.#{f} = '#{value}'", binding
      end
    end

    # Array/Hash/Boolean Define
    [].each do |f|
      define_method f do |value|
        eval "@line_head_washer.#{f} = #{value}", binding
      end
    end

    def initialize
      @line_head_washer = LineHeadWasher::DslModel.new
      @line_head_washer.input = './*.txt'
      @line_head_washer.output = './*.txt'
      @line_head_washer.remove_regexp = '[ |	]'
    end
  end
end
