#!/usr/bin/ruby
#
# @file Irb config
#
# @copyright (c) 2010, Christoph Kappel <unexist@dorfelite.net>
# @version $Id$
#

require "rubygems" rescue nil
require "wirble" rescue nil
require "irb/completion"
require "irb/ext/save-history"

# Irb config 
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
#IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
 
# Load wirble
Wirble.init
Wirble.colorize
