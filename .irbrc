#!/usr/bin/ruby
#
# @file Irb config
#
# @copyright (c) 2010, Christoph Kappel <unexist@dorfelite.net>
# @version $Id$
#

require "rubygems" rescue nil

# Irb config 
if defined? IRB
  require "wirble" rescue nil
  require "bond" rescue nil
  require "irb/ext/save-history"

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
  IRB.conf[:PROMPT_MODE] = :SIMPLE
  IRB.conf[:AUTO_INDENT] = true

  # Load wirble
  Wirble.init
  Wirble.colorize

  # Load bond
  Bond.start
else #< Ripl config
  require "ripl/color_result" rescue nil
end
