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

# User function ---------------------------------
downloadJdks()
{
  cd ~/bin
  #jdk8
  jdk="jdk1.8.0_112"
  if [ -e $jdk ] 
  then
    indent; echo "$jdk is available"
    return 1 
  fi

  echo "Downloading jdks"
  jdk="jdk-8u112-linux-x64.tar.gz"
  if [ ! -e $jdk ] 
  then
    indent; echo "There is no $jdk"
    indent; indent; wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/$jdk >/dev/null 2>&1
    if [ ! -e $jdk ] 
    then
        indent; indent; echo "Failed to download $jdk"
    else
        indent; indent; echo "Download successfully $jdk"
    fi
  else
    indent; echo "$jdk is available"
  fi
}
installJdks()
{
  downloadJdks

  jdk="jdk1.8.0_112"
  if [ ! -e $jdk ]
  then
    echo 'Installing jdks'
    for file in `ls jdk*.tar.gz`
    do 
      indent; echo "Extracting $file"
      tar xvzf ./$file >/dev/null 2>&1
      file $file
    done
    indent; echo 'Cleaning jdks'
    rm jdk*.tar.gz
    ls
    appendToBashrc 'export JAVA_HOME=~/bin/jdk1.8.0_112'
    appendToBashrc 'export PATH=$JAVA_HOME/bin'
  fi
}

installJdks
