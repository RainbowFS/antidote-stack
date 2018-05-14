mine_interval: 1
hostsfile:
  alias: controlpath_ip
mine_functions:
  network.ip_addrs: [{{ salt_host_control_iface }}]
  datapath_ip:
    - mine_function: network.ip_addrs
    - {{salt_host_control_iface}}
  controlpath_ip:
    - mine_function: network.ip_addrs
    - {{salt_host_control_iface}}
  docker_spy:
    - mine_function: dspy.dump
    - {{salt_host_control_iface}}


