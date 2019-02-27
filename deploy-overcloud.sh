#!/bin/bash
# name: overcloud-deploy.sh
#-----------------------------------------------------------------------------------------------------------------------------
#   Copyright 2018 Ken Holden <kholden@redhat.com>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#-----------------------------------------------------------------------------------------------------------------------------
# ensure script run as stack user and in stack’s home directory
if [ "$USER" != "stack" ]; then
  echo "MUST BE RUN AS stack USER"
  exit 1
fi
if [ "$PWD" != "/home/stack" ]; then
  echo "MUST BE IN THE STACK USER'S HOME DIRECTORY!!!"
  exit 1
fi





time openstack overcloud deploy --templates \
-r ~/templates/roles_data.yaml \
-n ~/templates/network_data.yaml \
-e ~/templates/containers-prepare-parameter.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-environment.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e ~/templates/network.yaml \
-e ~/templates/scheduler_hints_env.yaml \
-e ~/templates/node-info.yaml \
-e ~/templates/ips-from-pool-all.yaml \
-e ~/templates/fixed-ip-vips.yaml \
-e ~/templates/inject-trust-anchor-hiera.yaml \
-e ~/templates/enable-tls.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ssl/tls-endpoints-public-ip.yaml \
-e ~/templates/ceph-custom-config.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-rgw.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/octavia.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/disable-telemetry.yaml \
-e ~/templates/misc-settings.yaml
