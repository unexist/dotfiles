#
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
#
# $Id$
#

require "socket"

begin
  require "#{ENV["HOME"]}/projects/subtle-contrib/ruby/launcher.rb"
rescue LoadError
end

# Options {{{
set :border,     2
set :step,       5
set :snap,       10
set :gravity,    :center
set :urgent,     false
set :resize,     false
set :strut,      [0, 0, 0, 0]
set :padding,    [4, 4, 2, 2]
#set :font,       "xft:Envy Code R:pixelsize=13"
set :font,       "xft:DejaVu Sans Mono:pixelsize=12:antialias=true"
#set :font,       "xft:Ubuntu R:pixelsize=13"
set :separator,  "_"
set :outline,    0
set :gap,        0
# }}}

# Screens {{{
screen 1 do
  stipple false
  top     [:tray, :title, :spacer, :views, :center, :sublets, :center]
  bottom  []
  view    1
end

screen 2 do
  stipple false
  top     [:views, :spacer, :title, :center, :mpd, :separator, :volume, :center]
  bottom  []
  view    0
end
# }}}

# Colors {{{
color :title_fg,        "#ffffff"
color :title_bg,        "#1a1a1a"
color :title_border,    "#1a1a1a"

color :focus_fg,        "#ffffff"
color :focus_bg,        "#595959"
color :focus_border,    "#1a1a1a"

color :urgent_fg,       "#850000"
#color :urgent_bg,       "#404040"
#color :urgent_border,   "#1a1a1a"

color :occupied_fg,     "#777777"
color :occupied_bg,     "#404040"
color :occupied_border, "#1a1a1a"

color :views_fg,        "#a8a8a8"
color :views_bg,        "#1a1a1a"
color :views_border,    "#1a1a1a"

color :sublets_fg,      "#595959"
color :sublets_bg,      "#1a1a1a"
color :sublets_border,  "#1a1a1a"

color :client_active,   "#595959"
color :client_inactive, "#404040"

color :panel,           "#1a1a1a"
#color :background,     "#404040"

color :stipple,        "#595959"
color :separator,       "#850000"
# }}}

# Gravities {{{
gravity :top_left,       [0, 0, 50, 50]
gravity :top_left33,     [0, 0, 50, 33]
gravity :top_left66,     [0, 0, 50, 66]
gravity :top_left75,     [0, 0, 50, 75]
gravity :top,            [0, 0, 100, 50]
gravity :top66,          [0, 0, 100, 67]
gravity :top33,          [0, 0, 100, 33]
gravity :top75,          [0, 0, 100, 75]
gravity :top_right,      [100, 0, 50, 50]
gravity :top_right33,    [100, 0, 50, 33]
gravity :top_right66,    [100, 0, 50, 66]
gravity :top_right75,    [100, 0, 50, 75]
gravity :left,           [0, 0, 50, 100]
gravity :left33,         [0, 50, 25, 33]
gravity :left66,         [0, 50, 50, 33]
gravity :center,         [0, 0, 100, 100]
gravity :center33,       [50, 50, 50, 33]
gravity :center66,       [0, 50, 100, 33]
gravity :right,          [100, 0, 50, 100]
gravity :right33,        [100, 50, 25, 100]
gravity :right66,        [100, 50, 50, 33]
gravity :bottom_left,    [0, 100, 50, 50]
gravity :bottom_left25,  [0, 100, 50, 25]
gravity :bottom_left33,  [0, 100, 50, 33]
gravity :bottom_left66,  [0, 100, 50, 66]
gravity :bottom,         [0, 100, 100, 50]
gravity :bottom66,       [0, 100, 100, 66]
gravity :bottom33,       [0, 100, 100, 33]
gravity :bottom_right,   [100, 100, 50, 50]
gravity :bottom_right25, [100, 100, 50, 25]
gravity :bottom_right33, [100, 100, 50, 33]
gravity :bottom_right66, [100, 100, 50, 66]
gravity :gimp_image,     [50, 50, 80, 100]
gravity :gimp_toolbox,   [0, 0, 10, 100]
gravity :gimp_dock,      [100, 0, 10, 100]
gravity :dia_toolbox,    [0, 0, 100, 15]
gravity :dia_window,     [0, 18, 100, 84]
# }}}

# Grabs {{{
# Host specific
host     = Socket.gethostname
modkey   = "W"
gravkeys = [ "KP_7", "KP_8", "KP_9", "KP_4", "KP_5", "KP_6", "KP_1", "KP_2", "KP_3" ]

if("telas" == host || "mockra" == host) #< Netbooks
  gravkeys = [ "q", "w", "e", "a", "s", "d", "y", "x", "c" ]
elsif("test" == host) #< Usually VMs
  modkey = "A"
end

# Views and screens
(1..6).each do |i|
  grab modkey + "-#{i}",   "ViewSwitch#{i}".to_sym
  grab modkey + "-S-#{i}", "ViewJump#{i}".to_sym
  grab modkey + "-F#{i}",  "ScreenJump#{i}".to_sym
end

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
grab modkey + "-h", lambda { |c| c.retag }

# Reload/restart
grab modkey + "-C-q",     :SubtleQuit
grab modkey + "-C-r",     :SubtleReload
grab modkey + "-C-A-r",   :SubtleRestart

# Gravity keys and focus
gravities = [
  [:top_left, :top_left33, :top_left66, :top_left75],
  [:top, :top33, :top66, :top75],
  [:top_right, :top_right33, :top_right66, :top_right75],
  [:left, :left33, :left66],
  [:center, :center33, :center66],
  [:right, :right33, :right66],
  [:bottom_left, :bottom_left25, :bottom_left33, :bottom_left66],
  [:bottom, :bottom33, :bottom66],
  [:bottom_right, :bottom_right25, :bottom_right33, :bottom_right66]
]

gravities.each_index do |i|
  grab "%s-%s" % [ modkey, gravkeys[i] ], gravities[i]

  grab "%s-C-%s" % [ modkey, gravkeys[i] ], lambda {
    c = Subtlext::Client.visible.select { |c|
      gravities[i].include?(c.gravity.name.to_sym)
    }

    c.first.focus unless(c.empty?)
  }
end

# Multimedia keys
grab "XF86AudioMute", "amixer set Master toggle"
grab "XF86AudioRaiseVolume", "amixer set Master 2dB+"
grab "XF86AudioLowerVolume", "amixer set Master 2dB-"
grab "XF86AudioPlay", "mpc toggle"
grab "XF86AudioStop", "mpc stop"
grab "XF86AudioPrev", "mpc prev"
grab "XF86AudioNext", "mpc next"
grab modkey + "-m", "mpc current | tr -d '\n' | xclip"

# Programs
grab modkey + "-Return", "urxvt"
grab modkey + "-g", "gvim"
grab modkey + "-c", "chromium"

grab "A-Tab" do
  #clients = Subtlext::Client.find(:all).sort { |a, b| a.name <=> b.name }
  clients = Subtlext::Client.visible
  selected = clients.select { |c| c.has_focus? }.first

  index = clients.index(selected)

  index += 1
  index = 0 if index >= clients.size

  clients[index].focus
end

# Launcher
grab "W-x" do
  Launcher::Launcher.instance.run
end
# }}}

# Tags {{{
tag "terms" do
  match    "xterm|urxvt"
  gravity  :center
end

tag "browser" do
  match "navigator|(google\-)?chrom[e|ium]"

  if("proteus" == host or "pc03112" == host)
    gravity :top75
  else
    gravity :center
  end
end

tag "pdf" do
  match    "apvlv|evince"
  stick    true
end

tag "editor" do
  match   "[g]?vim"
  resize  true

  if("mockra" == host or "proteus" == host or "pc03112" == host)
    gravity :top75
  else
    gravity :center
  end
end

tag "xephyr" do
  match    "xephyr"
  urgent   false

  if("mockra" == host)
    gravity  :center
  else
    geometry [857, 96, 800, 800]
  end
end

tag "android" do
  match    :name => "5554:AVD"
  geometry [ 873, 47, 791, 534 ]
end

tag "mplayer" do
  match   "mplayer"
  float   true
  stick   true
  urgent  true
  #full    true
end

tag "stick" do
  match  "dialog|subtly|python|gtk.rb|display|pychrom|skype|xev"
  stick  true
  float  true
end

tag "urgent" do
  match  "sun-awt-X11-XDialogPeer"
  type   :dialog
  stick  true
  urgent true
end

tag "void" do
  match   "jd-Main|Virtualbox"
end

tag "dialogs" do
  match :type => :dialog
  match :type => :splash
  stick true
end

tag "flash" do
  match "exe|<unknown>"
  stick true
end

tag "one" do
  match    "urxvt2"
  gravity  :bottom_left
end

tag "one25" do
  match    "urxvt2"
  gravity  :bottom_left25
end

tag "two" do
  match    "urxvt2"
  gravity  :bottom
end

tag "three25" do
  match    "urxvt1"
  gravity  :bottom_right25
end

tag "seven" do
  match    "urxvt1"
  gravity  :top_left
end

tag "eight" do
  match    "urxvt1"
  gravity  :top
end

tag "gimp_image" do
  match    :role => "gimp-image-window"
  gravity  :gimp_image
end

tag "gimp_toolbox" do
  match    :role => "gimp-toolbox$"
  gravity  :gimp_toolbox
end

tag "gimp_dock" do
  match    :role => "gimp-dock"
  gravity  :gimp_dock
end

tag "gimp_scum" do
  match    :role => "gimp-.*"
end

tag "dia_window" do
  match   :role => "diagram_window"
  gravity :dia_window
end

tag "dia_toolbox" do
  match   :role => "toolbox_window"
  gravity :dia_toolbox
end

tag "inkscape" do
  match "inkscape"
end

tag "xfontsel" do
  match    "xfontsel"
  geometry [464, 433, 676, 113]
  stick    true
end

tag "xev" do
  match    :name => "Event[ ]Tester"
  geometry [1213, 98, 377, 321]
  float    true
  stick    true
end
# }}}

# Views {{{
if("mockra" == host or "proteus" == host or "pc03112" == host)
  www_re    = "browser|one25|three25"
  test_re   = "xephyr|android|one25|three25"
  editor_re = "android|editor|one25|three25"
else
  www_re    = "browser"
  test_re   = "android|xephyr|seven$|one$"
  editor_re = "editor"
end

iconpath = "#{ENV["HOME"]}/.local/share/icons"

view "terms" do
  match "terms|eight|two"
  icon  "#{iconpath}/terminal.xbm"
end

view "www" do
  match www_re
  icon  "#{iconpath}/world.xbm"
end

view "void" do
  match "default|void"
  icon  "#{iconpath}/quote.xbm"
end

view "sketch" do
  match "inkscape|dia_*|gimp_.*"
  icon  "#{iconpath}/paint.xbm"
end

view "test" do
  match test_re
  icon  "#{iconpath}/bug.xbm"
end

view "editor" do
  match editor_re
  icon  "#{iconpath}/pencil.xbm"
end
# }}}
