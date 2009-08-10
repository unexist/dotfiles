#
# Battery
#
# Author: Christoph Kappel
# Contact: unexist@dorfelite.net
# Description: Show the battery state
# Version: 0.1
# Date: Sat Sep 13 19:00 CET 2008
# $Id$
#

class Battery < Subtle::Sublet
  attr_accessor :full, :now, :path, :state 

  def initialize
    self.interval = 60
    @full         = 0
    @now          = 0
    @percent      = 0
    @path         = ""
    @state        = ""

    begin
      @path = Dir["/sys/class/power_supply/B*"].first #< Get battery slot
      @full = IO.readlines(@path + "/charge_full").first.to_i
    rescue => err
      err
    end
  end

  def run
    begin
      @now     = IO.readlines(@path + "/charge_now").first.to_i
      @state   = IO.readlines(@path + "/status").first.chop
      @percent = (@now * 100 / @full).floor

      ac = case @state
        when "Charging" then
          icon("/home/unexist/.local/share/icons/ac.xbm")
        when "Discharging" then
          case @percent
            when 100..66
              icon("/home/unexist/.local/share/icons/bat_full_02.xbm")
            when 66..33
              icon("/home/unexist/.local/share/icons/bat_low_02.xbm")
            when 33..0
              icon("/home/unexist/.local/share/icons/bat_empty_02.xbm")
          end
        when "Full" then
          icon("/home/unexist/.local/share/icons/ac.xbm")
      end
  
      self.data = "%d%%%s | " % [ @percent, ac ]
    rescue => err # Sanitize to prevent unloading
      self.data = "subtle"
      p err
    end
  end
end
