#!/bin/bash
perm() {
	current_folder=$(pwd)
	current_customer=$(echo $current_folder | grep -Po "/home/`whoami`/k/\K\w+")
	find /home/`whoami`/k/${current_customer}/* -user `whoami` -and -group users -exec chown "$(whoami):${current_customer}" {} \;
}

f() {
	[ -z $1 ] && echo 'Set a search query for the branch you are looking for' && return;
	git checkout `git branch | sort | grep $1 | cut -d ' ' -f3 | head -n1`
}

k() {
	[ -z $1 ] && echo 'set customer name' && return;
	cd `find $HOME/k -type l | sort | grep $1 | head -n1`
}

diff_files () {
	list_build_options=""
	for option in $(git diff --name-only); do
		list_build_options="${list_build_options}\"$option\"";
	done
	echo $list_build_options

	whiptail --title "Choose files from diff" --menu "Choose your option" 15 60 4 $list_build_options 3>&1 1>&2 2>&3
}

cd_to_staging_folder()
{
	cd $(pwd | cut -d'/' -f1-5)
}
