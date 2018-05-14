open_mode: True
auto_accept: True
file_recv: True
file_roots:
  base:
    - /srv/salt
fileserver_backend:
  - minion
  - roots
  - git
gitfs_provider: gitpython
gitfs_remotes:
  - https://gricad-gitlab.univ-grenoble-alpes.fr/herbautn/monitoring-formula.git
  - https://gricad-gitlab.univ-grenoble-alpes.fr/herbautn/docker-formula.git
  - https://github.com/nherbaut/bind9-formula.git
