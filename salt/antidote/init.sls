{%- set dns_server = salt["pillar.get"]("bind:config:dns-server:host") -%}


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
