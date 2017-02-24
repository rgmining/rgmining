#
# Dockerfile
#
# Copyright (c) 2017 Junpei Kawamoto
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
FROM ubuntu:latest
MAINTAINER Junpei Kawamoto <kawamoto.junpei@gmail.com>

ENV TERM vt100
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /workdir

# Install packages.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential python python-pip python-dev && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
RUN pip install --upgrade pip pip-tools setuptools

# Install rgmining packages.
ADD ./requirements.in /root/
RUN pip-compile /root/requirements.in
RUN pip install -r /root/requirements.txt

# Import and set the startup script.
ADD ./entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
