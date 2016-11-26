usercmd=(Ss Si Sg Qs Qo Ql Qk Qc Qd Qe Qem Qm Qi Qkk Qu Qdt)
aurcmd=(Ssa Sa Sia Syua Sua)
sudocmd=(S Syu Rns Syy Syyu)

for c in $usercmd; do; alias $c="pacman -$c"; done
for c in $aurcmd; do; alias $c="pacaur -$c"; done
for c in $sudocmd; do; alias $c="sudo pacman -$c"; done
