{% from "antidote/map.jinja" import host_confs with context %}

  
{% for dc_index, host_conf in host_confs.items() %}
create dc {{dc_index}}:
  cmd.run:
    - name: docker exec  antidote /bin/bash -c "/root/antidote-contrib/join_nodes.erl 'createdc' {{ host_conf |join(" ") }}"


{% endfor %}


