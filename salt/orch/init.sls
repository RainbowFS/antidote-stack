install_docker:
  salt.state:
    - tgt: "*"
    - sls:
      - docker
      - docker.unsecure_registry

pull_docker_images:
  salt.state:
    - tgt: 'h0'
    - sls:
      - docker.load_registry

disseminate_docker_images:
  salt.state:
    - tgt: '*'
    - sls:
      - docker.pull_local_registry


dns_server:
  salt.state:
    - tgt: 'h0'
    - sls:
      -  bind9.server

dns_client:
  salt.state:
    - tgt: '*'
    - sls:
      - bind9.client

launch_tickstack:
  salt.state:
    - tgt: "h0"
    - sls:
      - monitoring.tickstack
      - monitoring.nftables
      - monitoring.telegraf

launch_antidote:
  salt.state:
    - tgt: "*"
    - sls:
      - antidote


sync_modules:
  salt.function:
    - name: saltutil.sync_all
    - tgt: "*"

refresh_mine:
  salt.function:
    - name: mine.update
    - tgt: '*'

nftables:
  salt.state:
    - tgt: "*"
    - sls:
      - monitoring.nftables
      - monitoring.telegraf

