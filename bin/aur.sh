rm -rf *.src.tar.gz
makepkg --source -f
aurploader *.src.tar.gz
