/tmp/docker.sh:
  file.managed:
    - skip_verify: True
    - source: http://get.docker.com
    - mode: 777
  cmd.run: []
