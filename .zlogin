# Maybe attach tmux session.
if [[ -z "${TMUX}" && ! -f tmux-inhibit ]]; then
  # TODO: handle 'tmx' properly
  TMUX_CMD=${TMUX_CMD:-tmux}
  if (( $+commands[${TMUX_CMD}] )); then
    if [[ -n "${SSH_CONNECTION}" ]]; then
      SESSION_FILE=${HOME}/.tmux-attach-session-ssh
      FALLBACK_SESSION_NAME='tmp-ssh'
    else
      SESSION_FILE=${HOME}/.tmux-attach-session
      FALLBACK_SESSION_NAME='tmp'
    fi
    if [[ -r ${SESSION_FILE} ]]; then
      sname=$(<${SESSION_FILE})
    else
      sname=${FALLBACK_SESSION_NAME}
    fi
      ${TMUX_CMD} has-session -t ${sname} && ${TMUX_CMD} attach-session -t ${sname} || ${TMUX_CMD} new-session -s ${sname}
  fi
fi
