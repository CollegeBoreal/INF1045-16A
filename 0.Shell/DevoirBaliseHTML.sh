#!/bin/sh

lefichier='Gary_forms.html'

BAL[0]="<abbr"
BAL[1]="<address"
BAL[2]="<b"
BAL[3]="<bdi"
BAL[4]="<bdo"
BAL[5]="<blockquote"
BAL[6]="<center"
BAL[7]="<cite"
BAL[8]="<code"
BAL[9]="<del"
BAL[10]="<dfn"
BAL[11]="<em"
BAL[12]="<i"
BAL[13]="<ins"
BAL[14]="<kbd"
BAL[15]="<mark"
BAL[16]="<meter"
BAL[17]="<pre"
BAL[18]="<progress"
BAL[19]="<q"
BAL[20]="<s"
BAL[21]="<samp"
BAL[22]="<small"
BAL[23]="<strong"
BAL[24]="<sub"
BAL[25]="<sup"
BAL[26]="<time"
BAL[27]="<u"
BAL[28]="<var"
BAL[29]="<wbr"

for i in ${BAL[@]}
do
   echo $@ "Oui"
   cat | grep "$i" $lefichier
done 