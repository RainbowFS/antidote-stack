


mine_interval: 1
hostsfile:
  alias: controlpath_ip
mine_functions:
  network.ip_addrs: [{{ interface_name }}]
  datapath_ip:
    - mine_function: network.ip_addrs
    - {{interface_name}}
  controlpath_ip:
    - mine_function: network.ip_addrs
    - {{interface_name}}
  docker_spy:
    - mine_function: dspy.dump
    - {{interface_name}}


