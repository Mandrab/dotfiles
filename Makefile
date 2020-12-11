.PHONY: install dependencies

# CONSTANTS

INSTALL=dnf install -y
GROUP_INSTALL=dnf group install -y
REMOVE=dnf remove

# BUILD RULES

install: dependencies alacritty bspwm polybar

alacritty: # terminal emulator
	$(INSTALL) alacritty

bspwm:	dependencies polybar # window manager
	git clone https://github.com/baskerville/bspwm.git
	git clone https://github.com/baskerville/sxhkd.git
	$(INSTALL) xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel dmenu rxvt-unicode terminus-fonts # TODO maybe remove last two 
	$(GROUP_INSTALL) "Development Tools"
	cd bspwm; make; make install; cd ..
	cd sxhkd; make; make install; cd ..
	chmod +x ~/.config/bspwm/bspwmrc
	wget https://upload.wikimedia.org/wikipedia/commons/0/0d/Great_Wave_off_Kanagawa2.jpg
	rm -rf bspwm sxhkd

polybar: # status bar
	$(INSTALL) polybar
	chmod +x ~/.config/polybar/launch.sh

dependencies:
	$(INSTALL) feh git picom wget wmname
