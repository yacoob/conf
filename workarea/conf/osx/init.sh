#!/usr/bin/env bash
#set -x
source ~/.yacoob-conf
BASEDIR=${CONFDIR}/osx

# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

# Homebrew
if [[ "${LOCATION}" == "office" ]]; then
  BREW_PREFIX=~/brew
else
  BREW_PREFIX=/usr/local
fi
BREW=${BREW_PREFIX}/bin/brew
BREWFILE=Brewfile
# Install homebrew if it's not already there.
if [[ ! -x "${BREW}" ]]; then
  if [[ "${BREW_PREFIX}" == "/usr/local" ]]; then
    ${DEBUG} /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ${DEBUG} mkdir -p ${BREW_PREFIX}
    ${DEBUG} curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${BREW_PREFIX}
  fi
fi
export HOMEBREW_NO_ANALYTICS=1
${DEBUG} ${BREW} update
${DEBUG} ${BREW} analytics off
${DEBUG} ${BREW} bundle --file=${BREWFILE}.any
f=${BREWFILE}.${LOCATION}
[[ -r $f ]] && ${DEBUG} ${BREW} bundle --file=$f
${DEBUG} ${BREW} cleanup -s
ZSH=${BREW_PREFIX}/bin/zsh
grep -q "${ZSH}" /etc/shells
if [[ $? -ne 0 ]]; then
    echo "${ZSH}" | sudo tee -a /etc/shells
fi

# Apply OSX tweaks.
while read line; do
  [[ ! "${line}" =~ ^\ *# ]] && ${DEBUG} defaults write ${line}
done < ${BASEDIR}/tweaks

# Make sure ~/.yacoob-conf is available for gui apps (ie. MacVim)
grep -q '.yacoob-conf' /etc/zshenv
if [[ $? -ne 0 ]]; then
  echo 'source ~/.yacoob-conf' | sudo tee -a /etc/zshenv
  ${DEBUG} chmod a+r /etc/zshenv
fi

# Link iTerm's remotes
d="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
[[ -d "$d" ]] || mkdir -p "${d}"
${DEBUG} ln -sf "${BASEDIR}/iterm.remotes" "${d}/remotes"

# Drop in plists.
for file in ${BASEDIR}/plists/*.plist; do
  ${DEBUG} cp -f ${file} ${HOME}/Library/Preferences/${file##*/}
done
