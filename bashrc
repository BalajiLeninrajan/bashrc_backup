# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

crun() {
	echo "-> Compiling $1.c to ./$1"
	gcc -o $1 $1.c
	if [ $? -ne 0 ]; then
		echo "-> Compilation Failed"
	else
		echo "-> Compilation Complete"
		echo "-> Executing ./$1"
		echo "========Output========"
		./$1
		if [ $? -ne 0 ]; then
			echo ""
			echo "======================"
			echo "-> Execution Failed"
		else
			echo ""
			echo "======================"
			echo "-> Execution Complete"
		fi
	fi
}

cgrind() {
	echo "-> Compiling $1.c to ./$1"
	gcc -o $1 $1.c
	if [ $? -ne 0 ]; then
		echo "-> Compilation Failed"
	else
		echo "-> Compilation Successful"
		echo "-> Executing ./$1"
		echo ""
		valgrind ./$1
	fi
}

cpprun() {
	echo "-> Compiling $1.cpp to ./$1"
	g++ -o $1 $1.cpp
	if [ $? -ne 0 ]; then
		echo "-> Compilation Failed"
	else
		echo "-> Compilation Complete"
		echo "-> Executing ./$1"
		echo "========Output========"
		./$1
		if [ $? -ne 0 ]; then
			echo ""
			echo "======================"
			echo "-> Execution Failed"
		else
			echo ""
			echo "======================"
			echo "-> Execution Complete"
		fi
	fi
}

cppgrind() {
	echo "-> Compiling $1.cpp to ./$1"
	g++ -o $1 $1.cpp
	if [ $? -ne 0 ]; then
		echo "-> Compilation Failed"
	else
		echo "-> Compilation Successful"
		echo "-> Executing ./$1"
		echo ""
		valgrind ./$1
	fi
}

alias la="eza -l -a -h --git"
alias ll="eza -l -h --git"
alias cdc="cd ~/Documents/code"
alias py="python"
alias rust="rustc"
alias speedtest="speedtest-cli"
alias betterdiscord-update="DISC_CONFIG=\"\$HOME/.var/app/com.discordapp.Discord/config/discord\" && BD_ASAR=betterdiscord.asar && wget --timestamping -P \"\$HOME/.var/app/com.discordapp.Discord/config/BetterDiscord/data\" -- \"https://github.com/BetterDiscord/BetterDiscord/releases/latest/download/\${BD_ASAR}\" && DISC_VER=\"\$(ls --sort=time --time=creation \"\${DISC_CONFIG}\" | grep -E -m 1 '^[0-9]+\\.[0-9]+\\.[0-9]+\$')\" && echo -e \"require('../../../../BetterDiscord/data/\${BD_ASAR}');\\nmodule.exports = require('./core.asar');\" | tee \"\${DISC_CONFIG}/\${DISC_VER}/modules/discord_desktop_core/index.js\" && echo -e \"\\nBetterDiscord installed. Restart Discord if currently running.\" || echo -e \"\\nInstallation failed.\""
alias spotx-update="bash <(curl -sSL https://spotx-official.github.io/run.sh)"
alias vi="nvim"
alias venv_activate="source ./venv/bin/activate"
alias top="btop"
alias cat="bat"
alias rmdir="rm -rf"
alias neofetch="fastfetch --logo ~/Pictures/ProfilePicture.png --logo-height 25"

unset rc

EDITOR=code
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export CHROME_EXECUTABLE="/usr/bin/firefox"

export ANDROID_HOME=$HOME/.local/share/Android
export PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
