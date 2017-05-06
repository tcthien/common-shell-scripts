#!/bin/bash

# Common function -------------------------------
appendToBashrc()
{
    echo ${1} >> ~/dev-env.sh
}
indent() 
{
  echo -n '    '
}
download()
{
  local url=$2
  local file=$1
  echo "Downloading $file"
  wget --progress=dot $url >/dev/null 2>&1
  #wget $3 $url
}
installingApp()
{
  local tool_name=$1
  local file=$2
  local url=$3
  local link_src=$4
  local link_target=$5
  cd ~/bin/
  echo "Installing $tool_name"
  indent; download $file $url
  indent; echo -n "Extracting $file"
  if [[ "$file" =~ .*tar.gz$ || "$file" =~ .*tgz$ ]]
  then 
    echo " using tar"
    tar xvzf $file >/dev/null 2>&1
    #tar xvzf $file 
  else
    if [[ "$file" =~ .*zip$ ]]
    then
      echo " using unzip"
      unzip $file >/dev/null 2>&1
      #unzip $file 
    else
      echo
      indent; indent; echo "Can't extract $file. Unknown ext"
    fi
  fi
  indent; echo 'Cleaning'
  rm $file
  indent; echo "Creating symbolic link $link_target"
  ln -s $link_src $link_target
}

# User function ---------------------------------
installingMvn()
{
  installingApp 'apache-maven' \
    apache-maven-3.3.9-bin.tar.gz \
    http://www.eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    'apache-maven*' \
    apache-maven
}

installingMvn
appendToBashrc ''
appendToBashrc '# Variable for Maven software'
appendToBashrc 'export MAVEN_HOME=~/bin/apache-maven'
appendToBashrc 'export PATH=$MAVEN_HOME/bin:$PATH'
