use Irssi 20020101.0250 ();
$VERSION = "1";
%IRSSI = (
    authors     => 'Timo Sirainen, Ian Peters, David Leadbeater',
    contact     => 'dgl@dgl.cx',
    name        => 'Nick Color',
    description => 'assign a different color for each nick',
    license     => 'GPL',
);

use strict;

my %saved_colors;
my %session_colors = {};
my @colors = qw/2 3 4 5 6 7 9 10 11 12 13/;

sub load_colors {
  open COLORS, "$ENV{HOME}/.irssi/saved_colors";

  while (<COLORS>) {
    # I don't know why this is necessary only inside of irssi
    # $/ used to be set wrong - this is fixed now

      chomp;
      my($nick, $color) = split ":";
      $saved_colors{$nick} = $color;
  }

  close COLORS;
}

sub save_colors {
  open COLORS, ">$ENV{HOME}/.irssi/saved_colors";

  foreach my $nick (keys %saved_colors) {
    print COLORS "$nick:$saved_colors{$nick}\n";
  }

  close COLORS;
}

# If someone we've colored (either through the saved colors, or the hash
# function) changes their nick, we'd like to keep the same color associated
# with them (but only in the session_colors, ie a temporary mapping).

sub sig_nick {
  my ($server, $newnick, $nick, $address) = @_;
  my $color;

  $newnick = substr ($newnick, 1) if ($newnick =~ /^:/);

  if ($color = $saved_colors{$nick}) {
    $session_colors{$newnick} = $color;
  } elsif ($color = $session_colors{$nick}) {
    $session_colors{$newnick} = $color;
  }
}

# This gave reasonable distribution values when run across
# /usr/share/dict/words

sub simple_hash {
  my ($string) = @_;
  chomp $string;
  my @chars = split //, $string;
  my $counter;

  foreach my $char (@chars) {
    $counter += ord $char;
  }

  $counter = $colors[$counter % (scalar @colors)];

  return $counter;
}

# FIXME: breaks /HILIGHT etc.
sub sig_public {
  my ($server, $msg, $nick, $address, $target) = @_;

  # Has the user assigned this nick a color?
  my $color = $saved_colors{$nick};

  # Have -we- already assigned this nick a color?
  if (!$color) {
    $color = $session_colors{$nick};
  }

  # Let's assign this nick a color
  if (!$color) {
    $color = simple_hash $nick;
    $session_colors{$nick} = $color;
  }

  $color = "0".$color if ($color < 10);
  #$server->command('/^format pubmsg {pubmsgnick $2 {pubnick '.chr(3).$color.'$0}}$1');
  $server->command('/^format pubmsg {pubmsgnick $2 {pubnick '.chr(3).$color.'$[-11]0}}$1');
}

sub sig_private {
  my ($server, $msg, $nick, $address, $target) = @_;

  # Has the user assigned this nick a color?
  my $color = $saved_colors{$nick};

  # Have -we- already assigned this nick a color?
  if (!$color) {
    $color = $session_colors{$nick};
  }

  # Let's assign this nick a color
  if (!$color) {
    $color = simple_hash $nick;
    $session_colors{$nick} = $color;
  }

  $color = "0".$color if ($color < 10);
  $server->command("/^format msg_private {privmsg \003$color" .'$0 $1}$2');
}

sub cmd_color {
  my ($data, $server, $witem) = @_;
  my ($op, $nick, $color) = split " ", $data;

  $op = lc $op;

  if (!$op) {
    Irssi::print ("No operation given (save/set/clear/list/preview)");
  } elsif ($op eq "save") {
    save_colors;
  } elsif ($op eq "set") {
    if (!$nick) {
      Irssi::print ("Nick not given");
    } elsif (!$color) {
      Irssi::print ("Color not given");
    } elsif ($color < 2 || $color > 14) {
      Irssi::print ("Color must be between 2 and 14 inclusive");
    } else {
      $saved_colors{$nick} = $color;
    }
  } elsif ($op eq "clear") {
    if (!$nick) {
      Irssi::print ("Nick not given");
    } else {
      delete ($saved_colors{$nick});
    }
  } elsif ($op eq "list") {
    Irssi::print ("\nSaved Colors:");
    foreach my $nick (keys %saved_colors) {
      Irssi::print (chr (3) . "$saved_colors{$nick}$nick" .
		    chr (3) . "1 ($saved_colors{$nick})");
    }
  } elsif ($op eq "preview") {
    Irssi::print ("\nAvailable colors:");
    foreach my $i (2..14) {
      Irssi::print (chr (3) . "$i" . "Color #$i");
    }
  }
}

load_colors;

Irssi::command_bind('color', 'cmd_color');

Irssi::signal_add('message public', 'sig_public');
Irssi::signal_add('message private', 'sig_private');
Irssi::signal_add('event nick', 'sig_nick');
