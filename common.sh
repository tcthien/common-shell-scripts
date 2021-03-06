#!/bin/bash

export CDPATH=$CDPATH:~/:~/development:~/scripts
export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=350m"
export PATH=$PATH:~/scripts/common-shell-scripts

alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

alias dc="docker-compose"

function logTask(){
    echo "Execute: $1 ---------------------------------------------------------------------------"
}

# Git Util scripts ----------------------------------------------------------------------------
function gitCacheCredential(){
    # Linux
    git config --global credential.helper "cache --timeout=604800"
    # Window
    # git config --global credential.helper wincred
    # Mac OS X
    # git config --global credential.helper osxkeychain
}

# Maven Util scripts ----------------------------------------------------------------------------
function mvnBuild () { 
    logTask "mvn clean install -Dtest"
    mvn clean install -Dtest
}

function mvnBuildOffline () { 
    logTask "mvn clean install -Dtest -o"
    mvn clean install -Dtest -o
}

function mvnTBuild () { 
    logTask "mvn clean install"
    mvn clean install
}

function mvnEclipse () { 
    logTask "mvn eclipse:eclipse"
    mvn eclipse:eclipse
}

function mvnGenProject () { 
    logTask "mvn archetype:generate -DgroupId=${1} -DartifactId=${2} -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
    mvn archetype:generate -DgroupId=${1} -DartifactId=${2} -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
}

function _build(){
    mvnBuild
}
function _ebuild(){
    mvnEclipse
}
function _tbuild(){
    mvnTBuild
}
# End Maven Util scripts ------------------------------------------------------------------------


# Gradle Util scripts ---------------------------------------------------------------------------
function gradlCreateJavaProj () { 
    logTask "gradle init --type java-library"
    gradle init --type java-library
}
function gradlBuild () { 
    logTask "gradle build"
    gradle build
}
function gradlInstall () { 
    logTask "gradle install"
    gradle install
}
function gradlEclipse () { 
    logTask "gradle eclipse"
    gradle eclipse
}
function gradlBuildInstall () { 
    logTask "gradle build install"
    gradle build install
}
# End Gradle Util scripts -----------------------------------------------------------------------


function mkdircd () { 
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

function jdebug_set() {
    jenv shell-options "$JENV_OPTIONS -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n"
}

function jdebug_unset() {
    jenv shell-options --unset
}

function gc_set() {
    jenv shell-options "$JENV_OPTIONS -XX:+PrintGCDetails -Xloggc:gc.log"
}

function gc_unset() {
    jenv shell-options --unset
}

function jrebel_set() {
    jenv shell-options "$JENV_OPTIONS -javaagent:$HOME_BIN/jrebel/jrebel.jar -noverify"
}

function jrebel_unset() {
    jenv shell-options --unset
}

function jprofiler_set() {
    jenv shell-options "$JENV_OPTIONS -javaagent:$HOME_BIN/jprofiler/bin/agent.jar"
}

function jprofiler_unset() {
    jenv shell-options --unset
}

