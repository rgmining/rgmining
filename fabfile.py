# pylint: skip-file
#
# fabfile.py
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
from fabric.api import *
from fabric.contrib.project import rsync_project
env.use_ssh_config = True

PACKAGE = "rgmining"


@task
def build():
    """Build a Docker image.
    """
    run("mkdir -p " + PACKAGE)
    rsync_project(
        local_dir=".", remote_dir=PACKAGE, exclude=['.git'])
    with cd(PACKAGE):
        run("docker build -t rgmining/{0} .".format(PACKAGE))
