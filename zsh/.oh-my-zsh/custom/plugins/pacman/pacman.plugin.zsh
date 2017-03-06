usercmd=(Ss Si Sg Sw Qs Qo Ql Qk Qc Qd Qe Qem Qme Qm Qi Qkk Qu Qdt Qtd)
aurcmd=(Ssa Sas Sa Sia Sai Syua Sau Sua Swa Saw)
sudocmd=(S Syu Rns Sy Syy Syyu U Sc)

for c in $usercmd; do; alias $c="pacman -$c"; done
for c in $aurcmd; do; alias $c="pacaur -$c"; done
for c in $sudocmd; do; alias $c="sudo pacman -$c"; done
