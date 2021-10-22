FROM ubuntu:latest

ENV WORKDIR=/root
WORKDIR ${WORKDIR}

# apt deps
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
RUN apt-get update
RUN apt-get install -y \
    autoconf \
    automake \
    curl \
    fonts-firacode \
    git \
    libncurses5-dev \
    nano \
    npm \
    python3-pip \
    sudo \
    unzip \
    wget \
    zsh

# zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN pip install pygments
RUN npm install -g pure-prompt --unsafe-perm

# asdf
ARG ASDF=.asdf/bin/asdf
RUN git clone https://github.com/asdf-vm/asdf.git .asdf --branch v0.8.1
RUN ${ASDF} plugin-add erlang && \
    KERL_CONFIGURE_OPTIONS="--without-javac" ${ASDF} install erlang 23.3 && \
    ${ASDF} global erlang 23.3 && \
    ${ASDF} reshim erlang
RUN ${ASDF} plugin-add rebar && \
    PATH="${PATH}:${WORKDIR}/.asdf/shims" ${ASDF} install rebar 3.16.0 && \
    ${ASDF} reshim rebar
RUN ${ASDF} plugin-add elixir && \
    ${ASDF} install elixir 1.12.1-otp-23 && \
    ${ASDF} reshim elixir

# setup shell conf
COPY conf .
CMD ["zsh"]
