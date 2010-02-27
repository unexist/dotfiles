# 
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
# 
# $Id$
# 

require "socket"

#
# Options
#
OPTIONS = {
  :border  => 2,
  :step    => 5,
  :snap    => 10,
  :limit   => 1,
  :gravity => :center,
  :urgent  => false,
  :resize  => false,
  :padding => [ 0, 0, 0, 0 ],
  :font    => "-*-cure-*-*-*-*-11-*-*-*-*-*-*-*"
}

#
# Panel
#
PANEL = {
  :top       => [ :tray, :title, :spacer, :sublets, :spacer, :views ],
  :bottom    => [ ],
  :stipple   => false,
  :separator => "|"
}

#
# Themes
# 
THEMES = {
  :green => {
    :fg_panel      => "#e2e2e5",
    :fg_views      => "#ffffff",                                                                                    
    :fg_sublets    => "#000000",
    :fg_focus      => "#000000",                                                                                     
    :bg_panel      => "#444444",
    :bg_views      => "#3d3d3d",
    :bg_sublets    => "#b1d631",                                                                                     
    :bg_focus      => "#b1d631",
    :border_focus  => "#b1d631",
    :border_normal => "#5d5d5d",                                                                                     
    :background    => "#3d3d3d"
  },
  :blue => {
    :fg_panel      => "#e2e2e5",
    :fg_views      => "#e2e2e5",                                                                                    
    :fg_sublets    => "#000000",                                                                                     
    :fg_focus      => "#000000",
    :bg_panel      => "#444444",
    :bg_views      => "#3d3d3d",
    :bg_sublets    => "#6699CC",                                                                                    
    :bg_focus      => "#6699CC",
    :border_focus  => "#6699CC",
    :border_normal => "#5d5d5d",                                                                                     
    :background    => "#3d3d3d"  
  },
  :merged => {
    :fg_panel      => "#5fd7ff",
    :fg_views      => "#6c6c6c",
    :fg_sublets    => "#6c6c6c",
    :fg_focus      => "#5fd7ff",
    :bg_panel      => "#202020",
    :bg_views      => "#202020",
    :bg_sublets    => "#202020",
    :bg_focus      => "#202020",
    :border_focus  => "#5fd7ff",
    :border_normal => "#202020",
    :background    => "#3d3d3d"
  },
  :hornet => {
    :fg_panel      => "#757575",
    :fg_views      => "#757575",
    :fg_sublets    => "#757575",
    :fg_focus      => "#fecf35",
    :fg_urgent     => "#FF9800",
    :bg_panel      => "#202020",
    :bg_views      => "#202020",
    :bg_sublets    => "#202020",
    :bg_focus      => "#202020",
    :bg_urgent     => "#202020",
    :border_focus  => "#303030",
    :border_normal => "#202020",
    :background    => "#3d3d3d"
  },
  :digerati => {
    :fg_panel      => "#757575",
    :fg_views      => "#757575",
    :fg_sublets    => "#757575",
    :fg_focus      => "#cdff00",
    :fg_urgent     => "#ff3b77",
    :bg_panel      => "#202020",
    :bg_views      => "#202020",
    :bg_sublets    => "#202020",
    :bg_focus      => "#202020",
    :bg_urgent     => "#202020",
    :border_focus  => "#303030",
    :border_normal => "#202020",
    :background    => "#3d3d3d"
  }
}

#
# Colors
#
COLORS = THEMES[:digerati]

#
# Gravities
# 
GRAVITIES = {
  :top_left       => [   0,   0,  50,  50 ], 
  :top_left66     => [   0,   0,  50,  66 ],
  :top_left33     => [   0,   0,  50,  33 ],
  :top            => [   0,   0, 100,  50 ],
  :top66          => [   0,   0, 100,  66 ],
  :top33          => [   0,   0, 100,  33 ],
  :top_right      => [ 100,   0,  50,  50 ],
  :top_right66    => [ 100,   0,  50,  66 ],
  :top_right33    => [ 100,   0,  50,  33 ],
  :left           => [   0,   0,  50, 100 ],
  :left66         => [   0,  50,  50,  33 ],
  :left33         => [   0,  50,  25,  33 ],
  :center         => [   0,   0, 100, 100 ],
  :center66       => [   0,  50, 100,  33 ],
  :center33       => [  50,  50,  50,  33 ],
  :right          => [ 100,   0,  50, 100 ],
  :right66        => [ 100,  50,  50,  33 ],
  :right33        => [ 100,  50,  25,  33 ],
  :bottom_left    => [   0, 100,  50,  50 ],
  :bottom_left66  => [   0, 100,  50,  66 ],
  :bottom_left33  => [   0, 100,  50,  33 ],
  :bottom         => [   0, 100, 100,  50 ],
  :bottom66       => [   0, 100, 100,  66 ],
  :bottom33       => [   0, 100, 100,  33 ],
  :bottom_right   => [ 100, 100,  50,  50 ],
  :bottom_right66 => [ 100, 100,  50,  66 ],
  :bottom_right33 => [ 100, 100,  50,  33 ]
}  

# Dmenu settings
@dmenu = "dmenu_run -fn '%s' -nb '%s' -nf '%s' -sb '%s' -sf '%s' -p 'Select:'" % [
  OPTIONS[:font],
  COLORS[:bg_panel], COLORS[:fg_panel], 
  COLORS[:bg_focus], COLORS[:fg_focus]
]

# Host specific
host     = Socket.gethostname
modkey   = "W"
gravkeys = [ "KP_7", "KP_8", "KP_9", "KP_4", "KP_5", "KP_6", "KP_1", "KP_2", "KP_3" ]

if("telas" == host || "mockra" == host)
  gravkeys = [ "q", "w", "e", "a", "s", "d", "y", "x", "c" ]
elsif("test" == host)
  modkey = "A"
end

gravkeys.map! { |g| "#{modkey}-#{g}" }

#
# Grabs
#
GRABS = {
  "1"       => :ViewJump1,
  "2"       => :ViewJump2,
  "3"       => :ViewJump3,
  "4"       => :ViewJump4,
  "5"       => :ViewJump5,

  "F1"      => :ScreenJump1,
  "F2"      => :ScreenJump2,
  "F3"      => :ScreenJump3,
  "F4"      => :ScreenJump4,

  "B1"      => :WindowMove,
  "B2"      => :WindowResize,
  "S-f"     => :WindowFloat,
  "S-space" => :WindowFull,
  "S-s"     => :WindowStick,
  "r"       => :WindowRaise,
  "l"       => :WindowLower,
  "Left"    => :WindowLeft,
  "Down"    => :WindowDown,
  "Up"      => :WindowUp,
  "Right"   => :WindowRight,
  "k"       => :WindowKill,

  "S-F1"    => :WindowScreen1,
  "S-F2"    => :WindowScreen2,
  "S-F3"    => :WindowScreen3,
  "S-F4"    => :WindowScreen4,

  "B1"      => :WindowMove,
  "B3"      => :WindowResize,
  "S-f"     => :WindowFloat,
  "S-space" => :WindowFull,
  "S-s"     => :WindowStick,
  "r"       => :WindowRaise,
  "l"       => :WindowLower,
  "Left"    => :WindowLeft,
  "Down"    => :WindowDown,
  "Up"      => :WindowUp,
  "Right"   => :WindowRight,
  "k"       => :WindowKill,

  gravkeys[0] => [ :top_left,     :top_left66,     :top_left33     ],
  gravkeys[1] => [ :top,          :top66,          :top33          ],
  gravkeys[2] => [ :top_right,    :top_right66,    :top_right33    ],
  gravkeys[3] => [ :left,         :left66,         :left33         ],
  gravkeys[4] => [ :center,       :center66,       :center33       ],
  gravkeys[5] => [ :right,        :right66,        :right33        ],
  gravkeys[6] => [ :bottom_left,  :bottom_left66,  :bottom_left33  ],
  gravkeys[7] => [ :bottom,       :bottom66,       :bottom33       ],
  gravkeys[8] => [ :bottom_right, :bottom_right66, :bottom_right33 ],

  "C-q"     => :SubtleQuit,
  "C-r"     => :SubtleReload,
  "C-s"     => :SubletsReload,

  "b"       => "bashrun",
  "u"       => "uzbl",
  "Return"  => "urxvt",
  "m"       => "midori",
  "g"       => "gvim",
  "o"       => @dmenu,
}.inject({}) { |h, (k,v)| h["#{modkey}-#{k}"] = v; h }

#
# Tags
#
TAGS = {
  "test"    => { :regex => "xephyr", :screen => 0, :geometry => [ 857, 96, 800, 800 ] },
  "void"    => { :regex => "jd-main|gimp|virtual", :gravity => :center, :screen => 1 },
  "terms"   => { :regex => "xterm|urxvt", :gravity => :center, :screen => 1 },
  "browser" => { :regex => "navigator|shiretoko|uzbl|midori", :gravity => :center, :screen => 1 },
  "pdf"     => { :regex => "apvlv|evince", :float => true, :stick => true, :screen => 0 },
  "editor"  => { :regex => "[g]?vim", :gravity => :center, :screen => 1, :resize => true },
  "stick"   => { :regex => "mplayer|display|chrom|skype|xev", :stick => true, :float => true, :screen => 1 },
  "float"   => { :regex => "xephyr|gimp", :float => true, :screen => 1 },
  "one"     => { :regex => "urxvt2", :gravity => :bottom_left, :screen => 0 },
  "two"     => { :regex => "urxvt2", :gravity => :bottom, :screen => 0 },
  "six"     => { :regex => "navigator", :gravity => :right, :screen => 0 },
  "seven"   => { :regex => "urxvt1", :gravity => :top_left, :screen => 0 },
  "eight"   => { :regex => "urxvt1", :gravity => :top, :screen => 0 },
  "bashrun" => { :regex => "bashrun", :geometry => [ 50, 1000, 200, 28 ], :stick => true, :float => true, :urgent => true, :screen => 0 },
  "misc"    => { :regex => "subtly|python|gtk.rb", :float => true, :stick => true }
}  

#
# Views
#
VIEWS = [
  { "terms"  => "eight|two|terms" },
  { "www"    => "eight|two|browser" },
  { "void"   => "eight|two|default|void" },
  { "editor" => "seven|one|six|test|editor" }
#  { "terms"  => "seven|one|terms|test" },
#  { "www"    => "browser" },
#  { "void"   => "default|void" },
#  { "editor" => "editor" }
]

#
# Hooks
#
HOOKS = { }
