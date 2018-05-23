{%- set dns_server = salt["pillar.get"]("bind:config:dns-server:host") -%}

{% if grains.id in salt["pillar.get"]("antidote:nodes") %}


/root/antidote-contrib/join_nodes.erl:
  file.managed:
    - template: jinja
    - makedirs: True
    - source: salt://antidote/join_nodes.erl
    - mode: 755

antidote:
  docker_container.running:
    - image: antidotedb/antidote
    - name: antidote
    - port_bindings:
      - 4369:4369
      - 8085-8087:8085-8087
      - 8099:8099
      - 9100:9100
    - environment:
      - SHORT_NAME: "true"
      - NODE_NAME: "antidote@{{grains.id}}"
      - IP: {{ salt["mine.get"]("*","network.ip_addrs")[grains.id][0] }}
    - dns: {{ salt["mine.get"]("*","network.ip_addrs")[dns_server][0] }}
    - dns_search: rainbowfs.fr
    - binds: /root/antidote-contrib:/root/antidote-contrib:ro

{% endif %}

/root/connect:
  file.managed:
    - template: jinja
    - source: salt://antidote/connect.tpl
    
