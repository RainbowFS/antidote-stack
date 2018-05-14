open_mode: True
auto_accept: True
file_recv: True
file_roots:
  base:
    - /srv/salt
    - /srv/formulas/monitoring-formula
    - /srv/formulas/docker-formula
    - /srv/formulas/bind9-formula
fileserver_backend:
  - minion
  - roots
  - git
gitfs_provider: gitpython
