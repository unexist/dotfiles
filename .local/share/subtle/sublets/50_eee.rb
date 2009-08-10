#
# Eee
#
# Author: Christoph Kappel
# Contact: unexist@dorfelite.net
# Description: Shows fan and rfkill state
# Version: 0.1
# Date: Mon May 18 21:00 CET 2009
# $Id$
#

class Eee < Subtle::Sublet
  attr_accessor :fan, :rfkill

  def initialize
    self.interval = 120
    @fan          = false
    @rfkill       = false
  end

  def run
    begin
      # Get states
      @fan    = IO.readlines("/sys/class/hwmon/hwmon0/pwm1").first.to_i.equal?(0) ? false : true
      @rfkill = IO.readlines("/sys/class/rfkill/rfkill0/state").first.to_i.equal?(0) ? false : true

      # Select images
      path   = "/home/unexist/.local/share/icons/"
      fan    = @fan    ? "fs_01.xbm"   : "fs_02.xbm"
      rfkill = @rfkill ? "wifi_01.xbm" : "wifi_02.xbm"

      self.data = "%s%s%s " % [ icon(path + fan), icon(path + rfkill), icon(path + "arch.xbm") ]
    rescue => err # Sanitize to prevent unloading
      self.data = "subtle"
      p err
    end  
  end
end
