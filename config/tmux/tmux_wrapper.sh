#!/bin/sh

sess=session1

# test if the session has windows
is_closed(){ 
    n=$(tmux ls 2> /dev/null | grep "^$sess" | wc -l)
    [[ $n -eq 0 ]]
}

# either create it or attach to it
if is_closed ; then
  tmux start-server \; source-file ~/.config/tmux/$sess
  tmux attach -t $sess
else
  tmux attach -t $sess
fi

# the session is now either closed or detatched
if is_closed ; then
  tmux kill-session -t $sess
fi
