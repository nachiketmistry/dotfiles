base_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
home_dir=$(eval echo ~${SUDO_USER})

force=0
if [ "$1" == "-f" ]; then
  force=1
fi

# echo base_dir=$base_dir home_dir=$home_dir

for file in $base_dir/{path,aliases,bash_profile,bashrc,dircolors,bash_prompt,exports,functions,extra,splunkrc,vimrc}; 
do
  fname=$(basename $file)
  dotfname="$home_dir/.$fname"
  echo -n "Linking $file to $dotfname ..."
  if [[ -L $dotfname || -f  $dotfname ]] && [[ $force == 0 ]]
  then
    echo "Failed. File exists, pass -f to force replace."
  else
    [ -L $dotfname ] && unlink $dotfname
    [ -f  $dotfname ] && rm $dotfname
    out=$(ln -s $file $dotfname)
    echo "OK."
  fi
done
unset file
