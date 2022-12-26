if test -d ${HOME}/.config/profile.d/; then
	for profile in ${HOME}/.config/profile.d/*; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi
