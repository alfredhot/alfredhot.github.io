FROM gitpod/workspace-full

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/

# RUN bundle install -j4
ENV PROJECT_ROOT /workspace/alfredhot.github.io

RUN mkdir ${PROJECT_ROOT}/tmp
RUN mkdir ./temp_dir
