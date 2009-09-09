#!/usr/bin/env perl

use Getopt::Std;

$KeyFrame = 16;
$NormFrame = 0;

sub writeint {
	my $fh = shift;
	my $i = shift;

	print $fh pack "i",$i;
}

sub readint {
	my $fh = shift;
	my $buf;

	read $fh,$buf,4;
	return unpack "i",$buf;
}

if (!getopts('vbd') || $#ARGV < 0)
{
	die <<"END";
Usage: $0 [-v] [-b[d]] avifile ...
         -v: verbose, progress meter
         -b: keep backup
         -d: discard bad parts (only valid with -b)
END
}
$KeepBackup = $opt_b;
$DiscardBadParts = $opt_d;
$verbose = $opt_v;

foreach $filename (@ARGV) {
	$InputSize = -s $filename;
	$OutputName = $filename . ".tmp.idx";
	$BackupName = $filename . ".DivFix";

	open Input,"+<$filename"  or  die "Cannot open $filename: $!\n";
	open Output,"+>$OutputName"  or  die "Cannot open temporary file $OutputName: $!\n";
	if ($KeepBackup) {
		  open Backup,">$BackupName"  or  do {
			unlink $OutputName;
			die "Cannot open $BackupName: $!\n";
			}
		  }

	seek Input,8,0;
	read Input,$ChunkName,8;
	if ($ChunkName ne 'AVI LIST') { die "$filename: not an AVI file.\n"; }
	if ($verbose) { print "Rebuilding index of $filename...\n"; }
	$Position=16;
	$Size=0;
	do {
	  $Position += $Size;
	  seek Input,$Position,0;
	  $Size = readint(Input);
	  read Input,$ChunkName,4;
	  $Position += 8;
	} until ($ChunkName eq 'movi');
	$StreamStart=$Position-4;
	$StreamSize=$Size;
	$ChunkName='idx1';
	print Output $ChunkName;
	writeint(Output,$Size);
	$Position=4;
	$i=0;
	$Frame=0;
	$Difference=0;
	$Interleaved=0;
	seek Input,0,0;
	if ($KeepBackup)
	{
	  read Input,$Buffer,$StreamStart+4;
	  print Backup $Buffer;
	}
	do {
	  if ($verbose) {
		  printf "%2.1f%     \r", $Position * 100.0 / $InputSize;
		  }
	  seek Input,$StreamStart+$Position,0;
	  if (! eof Input) {
		BStartRead:
		read Input,$ChunkName,4;
		if ($ChunkName eq 'LIST')
		{
		  seek Input,8,1;
		  $Position += 12;
		  goto BStartRead;
		}
		if ($ChunkName eq 'JUNK')
		{
		  $Size = readint(Input);
		  $Position += $Size+8;
		  seek Input,$StreamStart+$Position,0;
		  goto BStartRead;
		}
		if ((substr($ChunkName,0,2) eq 'ix') || (substr($ChunkName,2,2) eq 'ix'))
		{
		  seek Input,12,1;
		  $Position += 16;
		  seek Input,$StreamStart+$Position,0;
		  $Interleaved=1;
		  goto BStartRead;
		}
		if (! eof Input)
		{
		  # if ((($ChunkName[1] In Number) && ($ChunkName[2] In Number)) && ((Copy($ChunkName,3,2) eq 'dc') || (Copy($ChunkName,3,2) eq 'db') || (Copy($ChunkName,3,2) eq 'wb')))
		  if ($ChunkName =~ m/^\d\d(dc|db|wb)/o)
		  {
			$Frame++;
			if ($Interleaved)
			{
			  seek Input,-16,1;
			  $Position -= 16;
			  $Interleaved=0;
			}
			$Temp = read Input,$TempBuf,4;
			$Size = unpack "i",$TempBuf;
			if (($Size<0) && ($Temp==4))
			{
			  $Position += 4;
			  seek Input,$StreamStart+$Position,0;
			  read Input,$ChunkName,4;
			  if ($ChunkName eq 'LIST')
			  {
				seek Input,8,1;
				$Position += 12;
				goto BStartRead;
			  }
			  if ($ChunkName eq 'JUNK')
			  {
				$Size = readint(Input);
				$Position += $Size+8;
				seek Input,$StreamStart+$Position,0;
				goto BStartRead;
			  }
			  seek Input,$StreamStart+$Position,0;
			  goto BError;
			}
			if (! eof Input)
			{
			  read Input,$FrameType,1;
			  $j=((($Position+$Size) >> 1)+(($Position+$Size) % 2))*2+8;
			   seek Input,$StreamStart+$j-1,0;
			   if (! eof Input) {
				  if (length($ChunkName) != 4) {
					$ChunkName = substr($ChunkName . "    ",0,4);
					}
				print Output $ChunkName;
				# if (((Copy($ChunkName,3,2) eq 'dc') || (Copy($ChunkName,3,2) eq 'db') || (Copy($ChunkName,3,2) eq 'wb')) && (($ChunkName[1] In Number) && ($ChunkName[2] In Number)) && (($FrameType & 64)==0))
				if ($ChunkName =~ m/^\d\d(dc|db|wb)/o && (($FrameType & 64)==0)) {
				  	writeint(Output,$KeyFrame)
					}
				else {
				  	writeint(Output,$NormFrame);
					}
				if ($DiscardBadParts) {
				  $j=$Position-$Difference;
				  writeint(Output,$j)
				}
				else {
					  writeint(Output,$Position);
				  }
				writeint(Output,$Size);
				$j=$Position;
				$Position=((($Position+$Size) >> 1)+(($Position+$Size) % 2))*2+8;
				seek Input,$StreamStart+$j,0;
				if ($KeepBackup)
				{
				  if ($Position-$j>32768)
				  {
					for ($k=1;$k <= int (($Position-$j) / 32768);$k++)
					{
					  read Input,$Buffer,32768;
					  print Backup $Buffer;
					}
					read Input,$Buffer,(($Position-$j) % 32768);
					print Backup $Buffer;
				  }
				  else
				  {
					read Input,$Buffer,$Position-$j;
					print Backup $Buffer;
				  }
				}
				$i++;
			   }
			 }
		  }
		  else {
			BError:
			if ($ChunkName ne 'idx1')
			{
				print "  Corrupted data detected at frame $$Frame\n";
				print "  Error offset: ",$StreamStart+$Position,"\n";
				# Shouldn't this > be a >= 
			  if (tell Output > 16) { seek Output,-16,1; }
			  $j=$Position;
			  do {
				seek Input,$StreamStart+$Position,0;
				if (! eof Input)
				{
				  read Input,$Buffer,32768;
				  $k=1;
				  do {
					if (((substr($Buffer,$k-1,1) eq 'd') || (substr($Buffer,$k-1,1) eq 'w')) && (! eof Input))
					{
					  if (((substr($Buffer,$k,1) eq 'c') || (substr($Buffer,$k,1) eq 'b')) && (! eof Input))
					   {
						seek Input,$StreamStart+$Position+$k-3,0;
						 if (! eof Input) {read Input,$ChunkName,4; }
					   }
					 }
					$k++;
				  # right-brace until ((((Copy($ChunkName,3,2) eq 'dc') || (Copy($ChunkName,3,2) eq 'db') || (Copy($ChunkName,3,2) eq 'wb')) && (($ChunkName[1] In Number) && ($ChunkName[2] In Number))) || ($ChunkName eq 'idx1') || ($k>32768));
				  } until (($ChunkName =~ m/^\d\d(dc|db|wb)/o) || ($ChunkName eq 'idx1') || ($k>32768));
				}
				$Position += $k-3;
			  # right-brace until ((((Copy($ChunkName,3,2) eq 'dc') || (Copy($ChunkName,3,2) eq 'db') || (Copy($ChunkName,3,2) eq 'wb')) && (($ChunkName[1] In Number) && ($ChunkName[2] In Number))) || ($ChunkName eq 'idx1') || eof Input);
			  } until (($ChunkName =~ m/^\d\d(dc|db|wb)/o) || ($ChunkName eq 'idx1') || eof Input);
			   if (! eof Input) { $Position--; }
			  if ($KeepBackup)
			  {
				if (!($DiscardBadParts))
				{
				  seek Input,$StreamStart+$j,0;
				  if ($Position-$j>32768)
				  {
					for ($k=1; $k <= int (($Position-$j) / 32768);$k++)
					 {
					  read Input,$Buffer,32768;
					  print Backup $Buffer;
					 }
					 read Input,$Buffer,(($Position-$j) % 32768);
					  print Backup $Buffer;
				  }
				  else
				  {
					read Input,$Buffer,$Position-$j;
					print Backup $Buffer;
				  }
				}
				else { $Difference+=$Position-$j; }
			  }
			}
			else
			{
			  seek Input,6,1;
			  read Input,$ChunkName,2;
			  seek Input,-8,1;
			  if (($ChunkName eq 'dc') || ($ChunkName eq 'wb') || ($ChunkName eq 'db'))
			  {
				$ChunkName='idx1';
			  }
			  else
			  {
				$ChunkName='0000';
				goto BError;
			  }
			}
		  }
		}
	  }
	} until ((eof Input) || ($ChunkName eq 'idx1'));
	$Size=$i*16;
	seek Output,4,0;
	writeint(Output,$Size);
	if ($KeepBackup)
	{
	  seek Backup,0,2;
	  $StreamSize=tell(Backup) - $StreamStart;
	  seek Backup,$StreamStart-4,0;
	  writeint(Backup,$StreamSize);
	  seek Backup,$StreamStart+$StreamSize,0;
	  seek Output,0,0;
	  do {
		 $Temp = read Output,$Buffer,32768;
		 print Backup $Buffer;
	  } until (!($Temp==32768));
	  truncate Backup, tell Backup;
	  close Backup;
	}
	else
	{
	  seek Input,0,2;
	  $StreamSize=tell(Input) - $StreamStart;
	  seek Input,$StreamStart-4,0;
	  writeint(Input,$StreamSize);
	  seek Input,$StreamStart+$StreamSize,0;
	  seek Output,0,0;
	  do {
		 $Temp = read Output,$Buffer,32768;
		 print Input $Buffer;
	  } until (!($Temp==32768));
	  truncate Input, tell Input;
	}
	close Input;
	close Output;
	unlink $OutputName;
	if ($verbose) { print "Done. \n"; }
}
