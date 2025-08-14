# Ubuntu 20.04 + ROS Noetic (フル)
FROM osrf/ros:noetic-desktop-full

# ---- build args でホストのUID/GID/ユーザ名を渡して非root運用 ----
ARG USERNAME=ros
ARG UID=1000
ARG GID=1000
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo \
    SHELL=/bin/bash \
    LANG=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8

# 必要ツールや日本語ロケールなど
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo locales tzdata git curl wget vim nano \
        build-essential cmake python3-pip python3-rosdep \
        python3-rosinstall python3-rosinstall-generator python3-wstool \
        libgl1-mesa-glx libglu1-mesa mesa-utils \
        udev usbutils \
    && locale-gen ja_JP.UTF-8 \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

# 非rootユーザ作成
RUN groupadd --gid ${GID} ${USERNAME} && \
    useradd  --uid ${UID} --gid ${GID} -m ${USERNAME} -s /bin/bash && \
    usermod -aG sudo,video,dialout ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-${USERNAME}

# catkin ワークスペース作成
RUN mkdir -p /home/${USERNAME}/catkin_ws/src
WORKDIR /home/${USERNAME}
ENV CATKIN_WS=/home/${USERNAME}/catkin_ws

# rosdep 初期化（rootで一度だけ）
RUN rosdep init || true
# ユーザに切替
USER ${USERNAME}
RUN rosdep update || true

# コンテナ起動時にROS環境を読み込むエントリポイント
COPY --chown=${USERNAME}:${USERNAME} entrypoint.sh /home/${USERNAME}/entrypoint.sh
RUN chmod +x /home/${USERNAME}/entrypoint.sh

# よく使うセットアップをデフォルトで読み込む
SHELL ["/bin/bash", "-lc"]
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo "[ -f ${CATKIN_WS}/devel/setup.bash ] && source ${CATKIN_WS}/devel/setup.bash" >> ~/.bashrc

WORKDIR ${CATKIN_WS}

ENTRYPOINT ["/home/ros/entrypoint.sh"]
CMD ["bash"]
