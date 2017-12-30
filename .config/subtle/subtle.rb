# -*- encoding: utf-8 -*-
#
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
#
# $Id$
#

require "socket"

# Contrib {{{
begin
  require "#{ENV["HOME"]}/projects/subtle-contrib/ruby/launcher.rb"
  require "#{ENV["HOME"]}/projects/subtle-contrib/ruby/selector.rb"

  Subtle::Contrib::Selector.font  = "xft:Envy Code R:pixelsize=13"
  Subtle::Contrib::Launcher.fonts = [
    "xft:Envy Code R:pixelsize=80",
    "xft:Envy Code R:pixelsize=13"
  ]

  Subtle::Contrib::Launcher.browser_screen_num = 0
rescue LoadError
end # }}}

# Options {{{
set :increase_step,     5
set :border_snap,       10
set :default_gravity,   :center
set :urgent_dialogs,    false
set :honor_size_hints,  false
set :gravity_tiling,    false
#set :click_to_focus,    false
set :skip_pointer_warp, false
#  }}}

#  Styles {{{
style :all do
  background "#1a1a1a"
  padding    2, 6, 2, 6
  background "#1a1a1a"
  font       "xft:Envy Code R:pixelsize=13"
end

style :tray do
end

style :title do
  foreground "#FFFFFF"
end

style :views do
  foreground "#7c7c72"
  icon       "#7c7c72"

  style :focus do
    foreground    "#ffffff"
    icon          "#ffffff"
    border_bottom "#acaa53", 2
  end

  style :occupied do
    foreground    "#7c7c72"
    border_bottom "#949269", 2
  end

  style :urgent do
    foreground "#c0bd5c"
    icon       "#c0bd5c"
  end

  style :visible do
    padding_top 0
    border_top  "#494948", 2
  end
end

style :sublets do
  foreground "#7c7c72"
  icon       "#7c7c72"
end

style :separator do
  foreground "#acaa53"
  separator  "∞"
end

style :clients do
  active   "#7c7c72", 2
  inactive "#494948", 2
  margin   2
end

style :panel_top do
  screen     1, [ :tray, :title, :spacer, :views, :center, :clock, :fuzzytime, :separator, :cpu, :sublets, :center ]
  screen     2, [ :mpd, :separator, :volume, :spacer, :title, :center, :views, :center ]
  screen     3, [ :views, :spacer, :title, :center, :wifi, :jdownloader, :center ]
end
# }}}

# Gravities {{{
gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

gravity :top,            [   0,   0, 100,  50 ]
gravity :top75,          [   0,   0, 100,  75 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,   0,  33, 100 ]

gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]
gravity :bottom_left25,  [   0,  75,  50,  25 ]

gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]
gravity :bottom_right25, [  50,  75,  50,  25 ]

gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

gravity :dia_toolbox,    [   0,   0,  15, 100 ]
gravity :dia_diagram,    [  15,   0,  85, 100 ]
# }}}

# Grabs {{{
# Host specific
host     = Socket.gethostname
modkey   = "W"
gravkeys = [ "KP_7", "KP_8", "KP_9", "KP_4", "KP_5", "KP_6", "KP_1", "KP_2", "KP_3" ]

if "telas" == host or "mockra" == host #< Netbooks
  gravkeys = [ "q", "w", "e", "a", "s", "d", "y", "x", "c" ]
elsif "test" == host #< Usually VMs
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
grab modkey + "-B3",      :WindowResize
grab modkey + "-S-f",     :WindowFloat
grab modkey + "-S-space", :WindowFull
grab modkey + "-S-s",     :WindowStick
grab modkey + "-S-equal", :WindowZaphod
grab modkey + "-S-r",     :WindowRaise
grab modkey + "-S-l",     :WindowLower
grab modkey + "-S-k",     :WindowKill
grab modkey + "-S-h", lambda { |c| c.retag }

# Movement
{
 WindowLeft: [ "Left", "h" ], WindowDown:  [ "Down",  "j" ],
 WindowUp:   [ "Up",   "k" ], WindowRight: [ "Right", "l" ]
}.each do |k, v|
  grab "%s-%s" % [ modkey, v.first ], k
  grab "%s-%s" % [ modkey, v.last  ], k
end

# Reload/restart
grab modkey + "-C-q",     :SubtleQuit
grab modkey + "-C-r",     :SubtleReload
grab modkey + "-C-A-r",   :SubtleRestart

# Gravity keys and focus
gravities = [
  [:top_left, :top_left33, :top_left66],
  [:top, :top33, :top66, :top75],
  [:top_right, :top_right33, :top_right66],
  [:left, :left33, :left66],
  [:center, :center33, :center66],
  [:right, :right33, :right66],
  [:bottom_left, :bottom_left25, :bottom_left33, :bottom_left66],
  [:bottom, :bottom33, :bottom66],
  [:bottom_right, :bottom_right25, :bottom_right33, :bottom_right66]
]

gravities.each_index do |i|
  # Set gravities
  grab "%s-%s" % [ modkey, gravkeys[i] ], gravities[i]

  # Focus client with gravity
  grab "%s-C-%s" % [ modkey, gravkeys[i] ], lambda { |cur|
    idx     = 0
    clients = Subtlext::Client.visible.select { |c|
      gravities[i].include?(c.gravity.name.to_sym)
    }

    # Cycle through clients with same gravity
    if clients.include?(cur)
      idx = clients.index(cur) + 1
      idx = 0 if idx >= clients.size
    end

    clients[idx].focus
  }
end

# Multimedia keys
grab "XF86AudioMute",        :VolumeToggle
grab "XF86AudioRaiseVolume", :VolumeRaise
grab "XF86AudioLowerVolume", :VolumeLower
grab "XF86AudioPlay",        :MpdToggle
grab "XF86AudioStop",        :MpdStop
grab "XF86AudioNext",        :MpdNext
grab "XF86AudioPrev",        :MpdPrevious

grab modkey + "-m", "mpc current | tr -d '\n' | xclip"

# Programs
grab modkey + "-Return", "urxvt"
grab modkey + "-g", "gvim"
grab modkey + "-n", "nvim-qt"
grab modkey + "-f", "firefox -no-remote -profileManager"
grab modkey + "-c", "chromium"

# Contrib
grab "W-x" do
  Subtle::Contrib::Launcher.run
end

grab "W-z" do
  Subtle::Contrib::Selector.run
end

# Scratchpad
grab "W-y" do
  if (c = Subtlext::Client.first("scratch"))
    c.toggle_stick
    c.focus
    c.raise
  elsif (c = Subtlext::Client.spawn("urxvt -name scratch"))
    c.tags  = []
    c.flags = [ :stick ]
  end
end

# Pychrom
grab modkey + "-p" do
  if (t = Subtlext::Tray[:pychrom])
    t.click
  else
    Subtlext::Client.spawn("pychrom")
  end
end

# Tabbing
grab modkey + "-Tab" do
  Subtlext::Client.recent[1].focus
end

# Set layout
grab modkey + "-numbersign" do
  # Find stuff
  view   = Subtlext::View.current
  tag    = view.tags.first
  client = view.clients.first
  urxvt1 = Subtlext::Client['urxvt1']
  urxvt2 = Subtlext::Client['urxvt2']

  # Update tags
  urxvt1 + tag
  urxvt2 + tag

  # Update gravities
  sym = view.name.to_sym
  client.gravity = { sym => :top75 }
  urxvt1.gravity = { sym => :bottom_right25 }
  urxvt2.gravity = { sym => :bottom_left25 }
end

# Scratch
scratch_stack   = []
scratch_current = 0

# Add window to stack
grab modkey + "-KP_Add" do |c|
  unless scratch_stack.include?(c.win)
    scratch_stack << c.win
    c.tags = []
    c.toggle_stick if c.is_stick?
  end
end

# Remove window from stack
grab modkey + "-KP_Subtract" do |c|
  if scratch_stack.include?(c.win)
    c.retag
    scratch_stack.delete(c.win)
  end
end

# Cycle through stack windows
grab modkey + "-comma" do
  # Get id of next window
  if 0 < scratch_current
    cur_idx = scratch_stack.index(scratch_current)

    # Hide current window
    cur_client = Subtlext::Client[scratch_current]
    cur_client.toggle_stick

    # Check whether cur is last window of stack
    if cur_idx == scratch_stack.size - 1
      scratch_current = 0

      return
    end

    idx = cur_idx + 1
  else
    idx = 0
  end

  # Show next window
  cur = Subtlext::Client[scratch_stack[idx]]

  scratch_current = cur.win
  cur.toggle_stick
end
# }}}

# Tags {{{
tag "terms" do
  match    instance: "xterm|urxvt"
  gravity  :center
  set      :resize
end

tag "top" do
  match    "urxvt1"
  gravity :top
end

tag "bottom" do
  match   "urxvt2"
  gravity :bottom
end

tag "seven" do
  match   "urxvt1"
  gravity :top_left
end

tag "one" do
  match   "urxvt2"
  gravity :bottom_left
end

tag "scratch" do
  match   instance: "scratch"
  gravity :bottom33
end

tag "browser" do
  match "navigator|(google\-)?chrom[e|ium]|firefox|dwb"

  if "mockra" == host
    gravity :top75
  else
    gravity :center
  end
end

tag "editor" do
  match  "[ng]?vim"
  set    :resize

  if "mockra" == host
    gravity :top75
  else
    gravity :center
  end
end

tag "xeph640" do
  match    "xeph640"
  position [ 82, 549 ]
end

tag "xeph800" do
  match    "xeph800"
  position [ 855, 172 ]
end

tag "mplayer" do
  match     "mplayer"
  set       :floating
  stick_to  2
end

tag "stickandfloat" do
  match  "dialog|subtly|python|gtk.rb|display|pychrom|skype|xev|exe|<unknown>|plugin-container|tester.rb"
  set    :sticky, :floating
end

tag "urgent" do
  set :sticky, :urgent, :floating
end

tag "powerfolder" do
  match "de-dal33t-powerfolder-PowerFolder"
  set   :floating, :sticky
end

tag "dialogs" do
  match "sun-awt-X11-XDialogPeer"
  set   :sticky
end

tag "android" do
  match "emulator-arm|eclipse|SDL_App"
end

tag "gimp" do
  match role: "gimp.*"

  on_match do |c|
    c.gravity = ("gimp_" + c.role.split("-")[1]).to_sym
  end
end

tag "dia" do
  match "dia"

  on_match do |c|
    c.gravity = ("dia_" + c.role.split("_").first).to_sym
  end
end

tag "inkscape" do
  match "inkscape"
end
# }}}

# Views {{{
diamond = "#{ENV["HOME"]}/.local/share/icons/black_diamond_with_question_mark.xbm"

view "terms" do
  match "terms|top|bottom"
  icon  diamond
  set   :icons_only
end

view "www" do
  match "browser"
  icon  diamond
  set   :icons_only
end

view "void" do
  match     "default|void|powerfolder|pms"
  icon      diamond
  set       :icons_only
end

view "misc" do
  match     "inkscape|dia|gimp|android"
  icon      diamond
  set       :icons_only
end

view "test" do
  match     "xeph[0-9]+|seven|one"
  icon      diamond
  set       :icons_only
end

view "editor" do
  match     "editor"
  icon      diamond
  set       :icons_only
end
# }}}

# Sublets {{{
sublet :clock do
  format_string "%a %b %d,"
end
# }}}

# Virtual {{{
#screen 1 do
#  virtual [  0,  0, 100, 50 ]
#  virtual [  0, 50, 100, 50 ]
#end # }}}
