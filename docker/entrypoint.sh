#!/usr/bin/env bash
set -e

# Xauthority が指定されていたら作成
if [ -n "${XAUTHORITY}" ] && [ ! -f "${XAUTHORITY}" ]; then
  touch "${XAUTHORITY}"
  xauth_list=$(xauth nlist "$DISPLAY" 2>/dev/null || true)
  if [ -n "$xauth_list" ]; then
    echo "$xauth_list" | sed -e 's/^..../ffff/' | xauth -f "$XAUTHORITY" nmerge -
  fi
fi

# ROS と catkin_ws のセットアップを読み込む
source /opt/ros/noetic/setup.bash || true
if [ -f "$HOME/catkin_ws/devel/setup.bash" ]; then
  source "$HOME/catkin_ws/devel/setup.bash"
fi

# 初回の rosdep（ネットワーク内で必要に応じて）
rosdep update >/dev/null 2>&1 || true

# 環境表示（デバッグ用）
echo "User: $(whoami)"
echo "ROS_DISTRO: ${ROS_DISTRO:-noetic}"
echo "Workspace: $HOME/catkin_ws"
echo "DISPLAY: ${DISPLAY}"

exec "$@"
