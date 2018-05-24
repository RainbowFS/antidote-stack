{% from "antidote/map.jinja" import host_confs_leader_only with context %}

  
connect all dcs:
  cmd.run:
    - name: docker exec  antidote /bin/bash -c "/root/antidote-contrib/join_nodes.erl 'connectdcs' {{ host_confs_leader_only |join(" ") }}"




