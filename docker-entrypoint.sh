#!/bin/bash
set -e

# 如果传了 USER_ID/GROUP_ID，创建对应用户并切换
if [ -n "$USER_ID" ] && [ -n "$GROUP_ID" ]; then
    groupadd -g "$GROUP_ID" -o claw 2>/dev/null || true
    useradd -u "$USER_ID" -g "$GROUP_ID" -o -m claw 2>/dev/null || true
    
    chown -R "$USER_ID:$GROUP_ID" /home/user/.nanobot 2>/dev/null || true
    
    exec gosu "$USER_ID:$GROUP_ID" "$@"
else
    exec "$@"
fi
