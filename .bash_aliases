#!/bin/sh
# This script stores aliases that are frequently used.

# Nvim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vims='nvim -S Session.vim'
alias vis='nvim -S Session.vim'
alias vs='nvim -S Session.vim'
alias vil='nvim leetcode.nvim'
# Toggle markdown browser
alias tmb="sed -i -E 's/google-chrome/brave-browser/;t; s/brave-browser/google-chrome/' $HOME/.config/nvim/lua/plugins/markdown-preview.lua"

# ROS
alias gk="pkill -f gzclient; pkill -f gzserver; pkill -f gazebo; pkill -f 'gz sim'"
alias rk='for i in $(pgrep -f ros/$ROS_DISTRO); do kill $i; done; pkill -f ros-args; pkill -f rviz'
alias rgk='rk && gk'
export ROS_CONFIG_DIR="$HOME/.config/ros"
alias ross='source $ROS_CONFIG_DIR/ros_env'
alias ros='ross' # Keeping for your convenience :)
alias drone='source $ROS_CONFIG_DIR/drone_env'
alias drone2='source $ROS_CONFIG_DIR/drone_env2'
alias eloquent='source $ROS_CONFIG_DIR/ros2_env eloquent'
alias foxy='source $ROS_CONFIG_DIR/ros2_env foxy'
alias galactic='source $ROS_CONFIG_DIR/ros2_env galactic'
alias humble='source $ROS_CONFIG_DIR/ros2_env humble'
alias iron='source $ROS_CONFIG_DIR/ros2_env iron'
alias jazzy='source $ROS_CONFIG_DIR/ros2_env jazzy'
alias gzweb='source $ROS_CONFIG_DIR/gzweb_env'
alias rosdepinstall='rosdep install --from-paths src --ignore-src -r -y'
alias eros='nvim $ROS_CONFIG_DIR/ros_env'
alias eross='nvim $ROS_CONFIG_DIR/../p_aliases/ros_setup'
alias eros2='nvim $ROS_CONFIG_DIR/ros2_env'
alias eross2='nvim $ROS_CONFIG_DIR/../p_aliases/ros2_setup'
alias rtg="rostopic list | grep "
alias ros2cd="source get-ros2-pkg-path-local"

# VPN
alias vpn='/opt/cisco/anyconnect/bin/vpn  connect nexus.a-star.edu.sg'
alias vpnd='/opt/cisco/anyconnect/bin/vpn disconnect'
alias vpns='/opt/cisco/anyconnect/bin/vpn state'

# Bri's Favourite Aliases
alias ccb='colcon build'
alias ccbs='colcon build --symlink-install'
alias ccbr='colcon build --cmake-args -DCMAKE_BUILD_TYPE=release'
alias ccbri='colcon build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'
alias ccbrs='colcon build --cmake-args -DCMAKE_BUILD_TYPE=release --symlink-install'
alias cct='colcon test --event-handlers console_direct+ --packages-select'
alias cctc='GTEST_COLOR=1 colcon test --event-handlers console_direct+ --ctest-args -R "test" --packages-select'
alias cb='catkin build'
alias cbr='catkin build -DCMAKE_BUILD_TYPE=release'
alias cm='catkin_make'
alias cmt='catkin_make run_tests'
alias cmr='catkin_make -DCMAKE_BUILD_TYPE=release'
alias cmi='catkin_make_isolated'
# alias dr='bash $HOME/restart.bash'
# alias dj='bash $HOME/join.bash'
alias mrccc20='cp $HOME/.config/mrccc/tasksdef_user.txt.ros1 $HOME/.config/mrccc/tasksdef_user.txt'
alias mrccc22='cp $HOME/.config/mrccc/tasksdef_user.txt.ros2 $HOME/.config/mrccc/tasksdef_user.txt'

# Git aliases
alias g='git'
alias ga='git add'
alias gcl='git clone'
alias gcb='git clone --bare'
alias gs='git status'
alias gci='git commit'
alias gco='git checkout'
alias gcob='git checkout branch'
alias gb='git branch'
alias gp='git push'
alias grm='git rm'
alias gl='git log --graph --decorate'
alias gls="git log --graph --decorate --date=short --pretty=format:'%C(auto)%h %an %ad %s %d%Creset' --color"
alias gd='git diff'
alias gw='git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gsb='gsa bri'
alias gsc='gsa cjl'
alias gr='cd $(git rev-parse --show-toplevel)'
alias gu='git-fetch-all'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cf='config'
alias cfa='config add'
alias cfs='config status'
alias cfci='config commit'
alias cfco='config checkout'
alias cfcob='config checkout branch'
alias cfb='config branch'
alias cfp='config push'
alias cfrm='config rm'
alias cfl='config log'
alias cfd='config diff'
alias cff='config fetch'
alias cffa='config fetch --all'

# Safe remove
alias rm='rm -i'

# TMUX
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tad='tmux attach -d -t'
alias tns='tmux new-session -s'
alias tks='tmux kill-session'
alias tkser='tmux kill-server'
alias td='tmux detach-client'
alias tsls='lsof -U | grep tmp/tmux'
alias tj='tmux-jump'

# Ghostty
ghostty-ssh-setup() {
  infocmp -x | ssh "$1" -- tic -x -
}

# Others
alias sane='stty sane'
alias gwd='pwd | xargs echo -n | xsel -i -b'
alias copyfile='xsel -i -b < '
alias cls='clear; ls'
alias cll='clear; ll'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias doc="cd $HOME/Documents/"
alias dow="cd $HOME/Downloads/"
alias vid="cd $HOME/Videos/"
alias pit="cd $HOME/Pictures/"
# alias fd='export DISPLAY=:1' # clashes with fd
alias ebal="nvim $HOME/.bash_aliases"
alias sbal="source $HOME/.bash_aliases"
alias lg="ll | grep"
alias eg="env | grep"
alias hyperjump="source jump"
alias file-permission='stat -c "%a %n"'
alias autoenv='touch .autoenv.zsh .autoenv_leave.zsh'
alias mm='micromamba'

# i3
alias lock='i3lock -c 000000'

# fzf
SCRIPT_EXTENSION=''
if test -n "$ZSH_VERSION"; then
  SCRIPT_EXTENSION="zsh"
elif test -n "$BASH_VERSION"; then
  SCRIPT_EXTENSION="bash"
  # Duplications
  bind -x '"\C-f": "tmux-sessionizer"'
  bind '"\C-k": "hyperjump\r"' # Hyperspace jump
  bind -x '"\ek": "tmux-run"' # Hyperspace jump
fi
FZF_KEYBIND_PATH=$HOME/.local/share/nvim/site/pack/packer/start/fzf/shell/key-bindings.$SCRIPT_EXTENSION
FZF_COMP_PATH=$HOME/.local/share/nvim/site/pack/packer/start/fzf/shell/completion.$SCRIPT_EXTENSION
test -f $FZF_KEYBIND_PATH && source $FZF_KEYBIND_PATH
test -f $FZF_COMP_PATH && source $FZF_COMP_PATH

P_ALIASES_PATH=$HOME/.config/p_aliases/.ssh_aliases
test -f $P_ALIASES_PATH && source $P_ALIASES_PATH

# enable rust
alias rust="source $HOME/.cargo/env"
