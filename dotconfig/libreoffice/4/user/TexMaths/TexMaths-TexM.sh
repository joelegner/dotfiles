#!/bin/bash
#
# This script is part of the TexMaths package
# http://roland65.free.fr/texmaths
#
# Roland Baudin (roland65@free.fr)

# Function used to generate system log
SystemLog(){
syslog=${UserDir}System.log
uname -a > $syslog
echo "" >> $syslog
echo "osType=$osType" >> $syslog
echo "cpuType=$cpuType" >> $syslog
echo "" >> $syslog
echo "PATH=$PATH" >> $syslog
echo "" >> $syslog
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> $syslog
echo "DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH" >> $syslog
}

# Definition of PATH and binary paths
cpu=$(uname -p)
mac=$(uname -m)
sys=$(uname -s)
[ "$cpu" = "powerpc" -o "$mac" = "ppc" ] && cpuType=ppc || cpuType=i386 
[ "$sys" = "Darwin" ] && osType=MacOSX || osType=Linux 
UserDir="/home/joe/.config/libreoffice/4/user/TexMaths/"
PkgDir="/usr/lib64/libreoffice/program/../share/extensions/TexMaths/"

PATH="${PkgDir}bin/${osType}${cpuType}:$PATH"
PATH="/bin/:/bin/::$PATH"
export PATH

if [ "$osType" = "MacOSX" ]
then
   DYLD_LIBRARY_PATH="${PkgDir}lib/${cpuType}/"
   export DYLD_LIBRARY_PATH
else
   LD_LIBRARY_PATH="${PkgDir}lib/${cpuType}/"
   export LD_LIBRARY_PATH
fi

# Process the options
ext=$1
dpi=$2
Trans="$3"
tmpPath="$4"
filename=tmpfile

# Generate system log
SystemLog

# Go to the tmp directory
if [ "$tmpPath" != "" ] 
then
   [ ! -d "$tmpPath" ]  && mkdir -p "$tmpPath"
   cd "$tmpPath"
fi

# Remove old files but not the tex file
rm ${filename}.{dvi,out,bsl,dat,log,aux,png,svg} &> /dev/null

# Creation of the DVI file
latex -shell-escape -interaction=nonstopmode ${filename}.tex  > ${filename}.out


# Conversion of the DVI file to a PNG image
if [ -f ${filename}.dvi ]
then
if [ "${ext}" = "png" ]
then
if [ "${Trans}" = "TRUE" ]
then
   dvipng -q -T tight -bg Transparent --width --height --depth -D ${dpi} -o ${filename}.png ${filename}.dvi > ${filename}.dat
else
   dvipng -q -T tight --width --height --depth -D ${dpi} -o ${filename}.png ${filename}.dvi > ${filename}.dat
fi
fi
fi
