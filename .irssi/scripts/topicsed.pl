#!/usr/pkg/bin/perl
#
# Topicsed edits channel topics by perl regexps via the command /topicsed.
#

use Irssi;
use Irssi::Irc;

use vars %IRSSI;
%IRSSI =
(
	authors		=> "Gabor Nyeki",
	contact		=> "bigmac\@vim.hu",
	name		=> "topicsed",
	description	=> "editing channel topics by regexps",
	license		=> "public domain",
	changed		=> "Fri Jan  9 19:00:38 CET 2004"
);


sub topicsed
{
	my ($regexp, $server, $winit) = @_;
	return if (!$regexp ||
		!$server || !$server->{connected} ||
		!$winit || $winit->{type} != 'CHANNEL');
	my $topic = $winit->{topic};
	my $x = $topic;

	eval "\$x =~ $regexp";

	
	if ($x eq $topic)
	{
		Irssi::print("topicsed:error: The topic wouldn't be changed.");
		return;
	}

	$server->send_raw("TOPIC $winit->{name} :$x");
}

Irssi::command_bind('topicsed', 'topicsed');
