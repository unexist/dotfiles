#
# Temp
#
# Author: Christoph Kappel
# Contact: unexist@dorfelite.net
# Description: Show the cpu temperature
# Version: 0.1
# Date: Mon May 18 21:00 CET 2009
# $Id$
#

class Temp < Subtle::Sublet
  attr_accessor :path, :temp

  def initialize
    self.interval = 60
    @temp         = ""

    begin
      @path = Dir["/proc/acpi/thermal_zone/*"][0] #< Get temp slot
    rescue => err
      err
    end
  end

  def run
    begin
      @temp = IO.readlines(@path + "/temperature").first
      @temp = @temp.match(/temperature:\s+(\d+)/).captures

      self.data = icon("/home/unexist/.local/share/icons/temp.xbm") + @temp.to_s + "C | "
    rescue => err # Sanitize to prevent unloading
      self.data = "subtle"
      p err
    end
  end
end
