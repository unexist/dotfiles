# 
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
# 
# $Id$
# 

#
# Options
#
OPTIONS = {
  :border  => 2,                                   # Border size of the windows
  :step    => 5,                                   # Window move/resize key step
  :snap    => 10,                                  # Window border snapping
  :gravity => 5,                                   # Default gravity
  :urgent  => false,                               # Make transient windows urgent
  :padding => [ 0, 0, 0, 0 ],                      # Screen padding (left, right, top, bottom)
  :font    => "-*-snap-*-*-*-*-10-*-*-*-*-*-*-*"   # Font string
}

#
# Panel
#
# Available panels: 
# :views, :cation, :tray, :sublets
# :spacer
#
PANEL = {
  :top       => [ :tray, :caption, :spacer, :sublets, :spacer, :views ],
  :bottom    => [ ],
  :stipple   => false,
  :separator => "|"
}

#
# Colors
# 
COLORS = { 
  :fg_panel      => "#5fd7ff",  # Foreground color of panel
  :fg_views      => "#6c6c6c",  # Foreground color of view button
  :fg_sublets    => "#6c6c6c",  # foreground color of sublets
  :fg_focus      => "#5fd7ff",  # Foreground color of focus window title and view

  :bg_panel      => "#202020",  # Background color of panel
  :bg_views      => "#202020",  # Background color of view button
  :bg_sublets    => "#202020",  # Background color of sublets
  :bg_focus      => "#202020",  # Background color of focus window title and view

  :border_focus  => "#5fd7ff",  # Border color of focus windows
  :border_normal => "#202020",  # Border color of normal windows
  
  :background    => "#3d3d3d"   # Background color of root background
}

#
# Dmenu settings
#
@dmenu = "dmenu_run -fn '%s' -nb '%s' -nf '%s' -sb '%s' -sf '%s' -p 'Select:'" % [
  OPTIONS[:font],
  COLORS[:bg_panel], COLORS[:fg_panel], 
  COLORS[:bg_focus], COLORS[:fg_focus]
]

#
# Grabs
#
# Modifier keys:
# A  = Alt key       S = Shift key
# C  = Control key   W = Super (Windows key)
# M  = Meta key
#
# Mouse buttons:
# B1 = Button1       B2 = Button2
# B3 = Button3       B4 = Button4
# B5 = Button5
#

GRABS = {
  "W-1"       => :ViewJump1,                 # Jump to view 1
  "W-2"       => :ViewJump2,                 # Jump to view 2
  "W-3"       => :ViewJump3,                 # Jump to view 3
  "W-4"       => :ViewJump4,                 # Jump to view 4
  "W-5"       => :ViewJump5,                 # Jump to view 4

  "W-S-1"     => :ScreenJump1,               # Jump to view 1
  "W-S-2"     => :ScreenJump2,               # Jump to view 2
  "W-S-3"     => :ScreenJump3,               # Jump to view 3
  "W-S-4"     => :ScreenJump4,               # Jump to view 4

  "W-C-q"     => :SubtleQuit,                # Quit subtle
  "W-C-r"     => :SubtleReload,              # Reload subtle

  "W-B1"      => :WindowMove,                # Move window
  "W-B3"      => :WindowResize,              # Resize window
  "W-S-f"     => :WindowFloat,               # Toggle float
  "W-S-space" => :WindowFull,                # Toggle full
  "W-S-s"     => :WindowStick,               # Toggle stick
  "W-r"       => :WindowRaise,               # Raise window
  "W-l"       => :WindowLower,               # Lower window
  "W-Left"    => :WindowLeft,                # Select window left
  "W-Down"    => :WindowDown,                # Select window below
  "W-Up"      => :WindowUp,                  # Select window above
  "W-Right"   => :WindowRight,               # Select window right
  "W-k"       => :WindowKill,                # Kill window

  "A-S-1"     => :WindowScreen1,             # Set screen 1
  "A-S-2"     => :WindowScreen2,             # Set screen 2
  "A-S-3"     => :WindowScreen3,             # Set screen 3
  "A-S-4"     => :WindowScreen4,             # Set screen 4

  "W-KP_7"    => :GravityTopLeft,            # Set top left gravity
  "W-KP_8"    => :GravityTop,                # Set top gravity
  "W-KP_9"    => :GravityTopRight,           # Set top right gravity
  "W-KP_4"    => :GravityLeft,               # Set left gravity
  "W-KP_5"    => :GravityCenter,             # Set center gravity
  "W-KP_6"    => :GravityRight,              # Set right gravity
  "W-KP_1"    => :GravityBottomLeft,         # Set bottom left gravity
  "W-KP_2"    => :GravityBottom,             # Set bottom gravity
  "W-KP_3"    => :GravityBottomRight,        # Set bottom right gravity

  "W-b"       => "bashrun",                  # Exec bashrun
  "W-u"       => "uzbl",                     # Exec uzbl
  "W-Return"  => "urxvt",                    # Exec a term
  "W-m"       => "midori",                   # Exec midori
  "W-g"       => "gvim",                     # Exec gvim
  "W-o"       => @dmenu,                     # Exec dmenu

  "S-F2"      => lambda { |c| puts c.name }, # Print client name
  "S-F3"      => lambda {  puts version   }  # Print subtlext version
}

#
# Tags
#
TAGS = {
  "test"    => { :regex => "xephyr", :screen => 0 },
  "misc"    => { :regex => "jd-main|gimp", :gravity => 5, :screen => 1 },
  "terms"   => { :regex => "xterm", :gravity => 5, :screen => 1 },
  "browser" => { :regex => "swiftweasel|uzbl|midori", :gravity => 5, :screen => 1 },
  "editor"  => { :regex => "[g]?vim", :gravity => 5, :screen => 1 },
  "stick"   => { :regex => "mplayer|apvlv|display|chrom|skype", :stick => true, :float => true, :screen => 1 },
  "float"   => { :regex => "xephyr|gimp", :float => true, :screen => 1 },
  "top"     => { :regex => "top", :gravity => 8, :screen => 0 },
  "bottom"  => { :regex => "bottom", :gravity => 2, :screen => 0 },
  "bashrun" => { :regex => "bashrun", :size => [ 50, 1000, 200, 28 ], :stick => true, :float => true, :urgent => true, :screen => 0 }
}  

#
# Views
#
VIEWS = [
  { "terms"  => "top|bottom|terms" },
  { "www"    => "top|bottom|browser" },
  { "misc"   => "top|bottom|default|misc" },
  { "test"   => "top|bottom|test|editor" },
  { "editor" => "top|bottom|editor" }
]

#
# Hooks
#
HOOKS = { }
