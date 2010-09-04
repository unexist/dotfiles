#
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
#
# $Id$
#

require "socket"
require "/home/unexist/projects/subtle-contrib/ruby/launcher.rb"

#
# Options
#
set :border,     2
set :step,       5
set :snap,       10
set :gravity,    :center
set :urgent,     false
set :resize,     false
set :randr,      true
set :padding,    [0, 0, 0, 0]
set :font,       "xft:Envy Code R:pixelsize=13"
set :top,        [:tray, :title, :spacer, :sublets, :spacer, :scratchpad, :views]
set :bottom,     []
set :stipple,    false
set :separator,  ""
set :outline,    1
set :gap,        0

#
# Colors
#
color :fg_panel,      "#777777"
color :fg_views,      "#777777"
color :fg_sublets,    "#777777"
color :fg_focus,      "#0066ff"
color :fg_urgent,     "#ff3b77"
color :bg_panel,      "#eeeeec"
color :bg_views,      "#eeeeec"
color :bg_sublets,    "#eeeeec"
color :bg_focus,      "#ffffff"
color :bg_urgent,     "#eeeeec"
color :border_focus,  "#303030"
color :border_normal, "#202020"
color :border_panel,  "#dddddc"
color :background,    "#3d3d3d"

#
# Gravities
#
gravity :top_left,       [0, 0, 50, 50]
gravity :top_left66,     [0, 0, 50, 66]
gravity :top_left33,     [0, 0, 50, 33]
gravity :top_left75,     [0, 0, 75, 50]
gravity :top,            [0, 0, 100, 50]
gravity :top66,          [0, 0, 100, 67]
gravity :top33,          [0, 0, 100, 33]
gravity :top75,          [0, 0, 100, 75]
gravity :top_right,      [100, 0, 50, 50]
gravity :top_right66,    [100, 0, 50, 66]
gravity :top_right33,    [100, 0, 50, 33]
gravity :left,           [0, 0, 50, 100]
gravity :left66,         [0, 50, 50, 33]
gravity :left33,         [0, 50, 25, 33]
gravity :center,         [0, 0, 100, 100]
gravity :center66,       [0, 50, 100, 33]
gravity :center33,       [50, 50, 50, 33]
gravity :right,          [100, 0, 50, 100]
gravity :right66,        [100, 50, 50, 33]
gravity :right33,        [100, 50, 25, 100]
gravity :bottom_left,    [0, 100, 50, 50]
gravity :bottom_left66,  [0, 100, 50, 66]
gravity :bottom_left33,  [0, 100, 50, 33]
gravity :bottom_left25,  [0, 100, 50, 25]
gravity :bottom,         [0, 100, 100, 50]
gravity :bottom66,       [0, 100, 100, 66]
gravity :bottom33,       [0, 100, 100, 33]
gravity :bottom_right,   [100, 100, 50, 50]
gravity :bottom_right66, [100, 100, 50, 66]
gravity :bottom_right33, [100, 100, 50, 33]
gravity :bottom_right25, [100, 100, 50, 25]
gravity :gimp_image,     [50, 50, 80, 100]
gravity :gimp_toolbox,   [0, 0, 10, 100]
gravity :gimp_dock,      [100, 0, 10, 100]

# Host specific
host     = Socket.gethostname
modkey   = "W"
gravkeys = [ "KP_7", "KP_8", "KP_9", "KP_4", "KP_5", "KP_6", "KP_1", "KP_2", "KP_3" ]

if("telas" == host || "mockra" == host) #< Netbooks
  gravkeys = [ "q", "w", "e", "a", "s", "d", "y", "x", "c" ]
elsif("test" == host) #< Usually VMs
  modkey = "A"
end

gravkeys.map! { |g| "#{modkey}-#{g}" }

#
# Grabs
#
grab modkey + "-1",       :ViewJump1
grab modkey + "-2",       :ViewJump2
grab modkey + "-3",       :ViewJump3
grab modkey + "-4",       :ViewJump4
grab modkey + "-5",       :ViewJump5

# Screens
grab modkey + "-F1",      :ScreenJump1
grab modkey + "-F2",      :ScreenJump2
grab modkey + "-F3",      :ScreenJump3
grab modkey + "-F4",      :ScreenJump4

grab modkey + "-S-F1",    :WindowScreen1
grab modkey + "-S-F2",    :WindowScreen2
grab modkey + "-S-F3",    :WindowScreen3
grab modkey + "-S-F4",    :WindowScreen4

# Windows
grab modkey + "-B1",      :WindowMove
grab modkey + "-B2",      :WindowResize
grab modkey + "-S-f",     :WindowFloat
grab modkey + "-S-space", :WindowFull
grab modkey + "-S-s",     :WindowStick
grab modkey + "-r",       :WindowRaise
grab modkey + "-l",       :WindowLower
grab modkey + "-Left",    :WindowLeft
grab modkey + "-Down",    :WindowDown
grab modkey + "-Up",      :WindowUp
grab modkey + "-Right",   :WindowRight
grab modkey + "-k",       :WindowKill
grab modkey + "-B3",      :WindowResize

# Reload/restart
grab modkey + "-C-q",     :SubtleQuit
grab modkey + "-C-r",     :SubtleReload
grab modkey + "-C-A-r",   :SubtleRestart
grab modkey + "-C-s",     :SubletsReload

# Gravity keys
grab gravkeys[0], [:top_left, :top_left66, :top_left33, :top_left75]
grab gravkeys[1], [:top, :top66, :top33, :top75]
grab gravkeys[2], [:top_right, :top_right66, :top_right33]
grab gravkeys[3], [:left, :left66, :left33]
grab gravkeys[4], [:center, :center66, :center33]
grab gravkeys[5], [:right, :right66, :right33]
grab gravkeys[6], [:bottom_left, :bottom_left66, :bottom_left33, :bottom_left25]
grab gravkeys[7], [:bottom, :bottom66, :bottom33]
grab gravkeys[8], [:bottom_right, :bottom_right66, :bottom_right33, :bottom_right25]

# Alt-tab
grab modkey + "-Tab" do |c|
  # Extracted from line #177
    sel     = 0
    clients = Subtlext::View[:current].clients

    clients.each_index do |idx|
      if(clients[idx].id == c.id)
        sel = idx + 1 if(idx + 1 <= clients.size)
      end
    end

    clients[sel].focus
end

# Multimedia keys
grab "XF86AudioMute", "amixer set Master toggle"
grab "XF86AudioRaiseVolume", "amixer set Master 2dB+"
grab "XF86AudioLowerVolume", "amixer set Master 2dB-"
grab "XF86AudioPlay", "mpc toggle"
grab "XF86AudioStop", "mpc stop"
grab "XF86AudioPrev", "mpc prev"
grab "XF86AudioNext", "mpc next"

# Programs
grab modkey + "-Return", "urxvt"
grab modkey + "-m", "midori"
grab modkey + "-g", "gvim"

# Launcher
grab "A-g" do
  Launcher::Launcher.instance.run
end

#
# Tags
#
tag "terms" do
  match    "xterm|urxvt"
  gravity  :center
  screen   1
end

tag "browser" do
  match  "browser|navigator|midori|namoroka|firefox|chrome|chromium"
  screen 1

  if("proteus" == host)
    gravity :top75
  else
    gravity :center
  end
end

tag "pdf" do
  match    "apvlv|evince"
  stick    true
  screen   0
end

tag "editor" do
  match   "[g]?vim"
  screen  1
  resize  false

  if("mockra" == host or "proteus" == host)
    gravity :top75
  else
    gravity :center
  end
end

tag "xephyr" do
  match    "xephyr"
  screen   0

  if("mockra" == host)
    gravity  :center
  else
    geometry [857, 96, 800, 800]
  end
end

tag "android" do
  match    :name => "5554:AVD"
  screen   0
  geometry [ 873, 47, 791, 534 ]
end

tag "mplayer" do
  match   "mplayer"
  stick   true
  float   true
  urgent  true
  screen  1
end

tag "stick" do
  match  "dialog|subtly|python|gtk.rb|display|pychrom|skype|xev"
  stick  true
  float  true
end

tag "void" do
  match   "jd-Main|Virtualbox"
  screen  1
end

tag "test" do
  match   "test"
  float   true
  resize  false
end

tag "one" do
  match    "urxvt2"
  gravity  :bottom_left
  screen   0
end

tag "two" do
  match    "urxvt2"
  gravity  :bottom
  screen   0
end

tag "six" do
  match    "navigator|chrom[ium|e]"
  gravity  :right
  screen   0
end

tag "seven" do
  match    "urxvt1"
  gravity  :top_left
  screen   0
end

tag "eight" do
  match    "urxvt1"
  gravity  :top
  screen   0
end

tag "one25" do
  match    "urxvt2"
  gravity  :bottom_left25
  screen   0
end

tag "three25" do
  match    "urxvt1"
  gravity  :bottom_right25
  screen   0
end

tag "gimp_image" do
  match    :role => "gimp-image-window"
  gravity  :gimp_image
  screen   1
end

tag "gimp_toolbox" do
  match    :role => "gimp-toolbox"
  gravity  :gimp_toolbox
  screen   1
end

tag "gimp_dock" do
  match    :role => "gimp-dock"
  gravity  :gimp_dock
  screen   1
end

tag "gimp_scum" do
  match    :role => "gimp-.*"
  screen   1
end

tag "xev" do
  match    :name => "Event Tester"
  geometry [ 1000, 100, 80, 80 ]
  float    true
  stick    true
end

tag "chrome-opts" do
  match :name => "chromium options"
  stick true
end

#
# Views
terms  = "terms"
www    = "browser"
void   = "default|void|gimp_.*"
test   = "xephyr"
editor = "android|editor"

# Host specific
if("telas" == host or "aral" == host) #< Multihead
  terms  << "|eight|two"
  www    << "|eight|two"
  void   << "|eight|two"
  editor << "|seven|one$|six|xephyr"
elsif("mockra" == host or "proteus" == host)
  terms  << "|eight|two"
  www    << "|one25|three25"
  editor << "|one25|three25"
end

view "terms",  terms
view "www",    www
view "void",   void
view "test",   test
view "editor", editor

#
# Hooks
#
