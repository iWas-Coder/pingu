# === Start Xorg when logged in (tty1) and display detected === #
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
