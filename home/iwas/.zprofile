# === Start Xorg when logged in and display detected === #
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx &>/dev/null
fi
