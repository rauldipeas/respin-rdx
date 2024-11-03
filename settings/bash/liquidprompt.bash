#!/bin/bash
echo $- | grep -q i 2>/dev/null && . /usr/share/liquidprompt/liquidprompt
lp_theme powerline