erlang:
  pkgrepo.managed:
    - name: deb https://packages.erlang-solutions.com/ubuntu xenial contrib
    - humanname: Erlang repo
    - gpgcheck: 1
    - key_url: salt:///erlang/key.pub
  pkg.installed:
    - skip_verify: True

/usr/bin/rebar3:
  file.managed:
    - source: https://s3.amazonaws.com/rebar3/rebar3
    - mode: 755
    - skip_verify: True

git:
  pkg.installed: []

https://github.com/goncalotomas/FMKe.git:
  git.latest:
    - target: /opt/FMKe


make select-antidote:
  cmd.run:
    cwd: /opt/FMKe

make bench-antidote:
  cmd.run:
    cwd: /opt/FMKe
