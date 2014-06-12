# encoding: utf-8
require 'active_model'

module LineHeadWasher
  # DslModel
  class DslModel
    include ActiveModel::Model

    # input file or directory by regexp
    attr_accessor :input
    validates :input, presence: true

    # output file or directory by regexp
    attr_accessor :output
    validates :output, presence: true

    # remove_regexp
    attr_accessor :remove_regexp
    validates :remove_regexp, presence: true

  end
end
