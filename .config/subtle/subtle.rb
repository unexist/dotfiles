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
  "border"  => 2,               # Border size of the windows
  "step"    => 5,               # Window move/resize key step
  "bar"     => 0,               # Bar position (0 = top, 1 = bottom)
  "gravity" => 5,               # Default gravity
  "padding" => [ 0, 0, 0, 0 ]   # Screen padding (left, right, top, bottom)
}

#
# Font
#
FONT = { 
  "family" => "lucidatypewriter",   # Font family for the text
  "style"  => "medium",             # Font style (medium|bold|italic)
  "size"   => 11                    # Font size
}

#
# Colors
# 
COLORS = { 
  "fg_bar"     => "#e2e2e5",   # Foreground color of normal windows
  "bg_bar"     => "#444444",   # Background color of normal windows
  "fg_focus"   => "#000000",   # Foreground color of focus windows
  "bg_focus"   => "#b1d631",   # Background color of focus windows
  "normal"     => "#5d5d5d",   # Color of border
  "background" => "#3d3d3d"    # Color of root background
}

@dmenu = "dmenu_run -fn '%s-%d' -nb '%s' -nf '%s' -sb '%s' -sf '%s' -p 'Select:'" % [
  FONT["family"], FONT["size"],
  COLORS["bg_bar"], COLORS["fg_bar"], 
  COLORS["bg_focus"], COLORS["fg_focus"]
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
  "W-1"      => "ViewJump1",                  # Jump to view 1
  "W-2"      => "ViewJump2",                  # Jump to view 2
  "W-3"      => "ViewJump3",                  # Jump to view 3 
  "W-4"      => "ViewJump4",                  # Jump to view 4

  "W-C-q"    => "SubtleQuit",                 # Quit subtle
  "W-C-r"    => "SubtleReload",               # Reload subtle

  "W-B1"     => "WindowMove",                 # Move window
  "W-B3"     => "WindowResize",               # Resize window
  "W-f"      => "WindowFloat",                # Toggle float
  "W-space"  => "WindowFull",                 # Toggle full
  "W-s"      => "WindowStick",                # Toggle stick
  "W-r"      => "WindowRaise",                # Raise window
  "W-l"      => "WindowLower",                # Lower window
  "W-Left"   => "WindowLeft",                 # Select window left
  "W-Down"   => "WindowDown",                 # Select window below
  "W-Up"     => "WindowUp",                   # Select window above
  "W-Right"  => "WindowRight",                # Select window right  
  "W-k"      => "WindowKill",                 # Kill window

  "W-KP_7"   => "GravityTopLeftVert",      # Set top left gravity
  "W-KP_8"   => "GravityTopVert",          # Set top gravity
  "W-KP_9"   => "GravityTopRightVert",     # Set top right gravity
  "W-KP_4"   => "GravityLeftVert",         # Set left gravity
  "W-KP_5"   => "GravityCenterVert",       # Set center gravity
  "W-KP_6"   => "GravityRightVert",        # Set right gravity
  "W-KP_1"   => "GravityBottomLeftVert",   # Set bottom left gravity
  "W-KP_2"   => "GravityBottomVert",       # Set bottom gravity
  "W-KP_3"   => "GravityBottomRightVert",  # Set bottom right gravity

  "W-S-KP_7"   => "GravityTopLeftHorz",      # Set top left gravity
  "W-S-KP_8"   => "GravityTopHorz",          # Set top gravity
  "W-S-KP_9"   => "GravityTopRightHorz",     # Set top right gravity
  "W-S-KP_4"   => "GravityLeftHorz",         # Set left gravity
  "W-S-KP_5"   => "GravityCenterHorz",       # Set center gravity
  "W-S-KP_6"   => "GravityRightHorz",        # Set right gravity
  "W-S-KP_1"   => "GravityBottomLeftHorz",   # Set bottom left gravity
  "W-S-KP_2"   => "GravityBottomHorz",       # Set bottom gravity
  "W-S-KP_3"   => "GravityBottomRightHorz",  # Set bottom right gravity

  "W-Return" => "urxvt",                     # Exec a term
  "W-x"      => @dmenu,                      # Exec dmenu 
  "W-u"      => "uzbl",                      # Exec uzbl

  "S-F2"     => lambda { |c| puts c.name },   # Print client name
  "S-F3"     => lambda {  puts version   }   # Print subtlext version
}

# Tags
#
TAGS = {
  "terms"   => "urxvt|xterm",
  "browser" => "opera",
  "editor"  => "[g]?vim",
  "test"    => "urxvt|xephyr",
  "stick"   => "mplayer|imagemagick|chrom",
  "float"   => "xlogo|mplayer|xephyr|evince|gimp|imagemagick|chrom",
  "top"     => "urxvt1|[g]?vim",
  "bottom"  => "urxvt2"
}  

#
# Views
#
VIEWS = {
  "dev"  => "editor|terms",
  "test" => "test",
  "web"  => "browser"
}

#
# Hooks
#
HOOKS = { }
