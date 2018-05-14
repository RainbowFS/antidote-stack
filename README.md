#what's in here?

This repository contains a collection of salt receipes that install and configure antidtedb to run on a cluster of machines. It uses salt for easy operations and optionally use mcc for easy installation

# where to start

first, decide whether you want to install and configure salt and this repository manually (installing salt) or do it automatically (installing with mcc)

## installing salt

salt is a tool used to define a infrastructure as a document, and sync the real infrastructure with the document by installing component, launching service, writing configuration files and so on.
To get started, you can refer to the saltstack documentation (https://docs.saltstack.com/en/latest/topics/installation/index.html#quick-install) or use mcc, as show on the next paragraph.

* On the master and minions, install git and pip (apt-get install git python-pip --yes) then from pip install the docker python lib (pip install docker netifaces).
* use provided master configuration file template mcc/master.tpl to configure the master
* clone the formulas as specified in the settings.yaml in /srv/formulas
* use provided minion configuration file template mcc/minion.tpl to configure the minions (replace the salt_host_control_iface  variable with the name of the interface used for master/minion communication)
* clone this repository in /srv to install all the receipes
* copy and tweak the ./mcc/*.sls files to /src/pillar to reflect the configuration you want for antidote

After salt installation (masters+minions) is ready, on the master issue a

```
salt "*" test.ping
```

to make sure that all the minions are reachable. Issuing a

```
salt-run state.orchestrate orch
```

will install and configure everything to run antidote.

## installing with mcc

mcc installation: https://gricad-gitlab.univ-grenoble-alpes.fr/vqgroup/mcc/wikis/home

mcc (multi-cloud console) is a tool that aims at making the test environment provisionning easier, working with grid5000 for the moment but expensible to any cloud provider through libcloud.
mcc uses a settings.yaml file to gather all the information required to complete the steps.

* edit ./mcc/settings.yaml and change the informations about your private and poublic key and your g5k login and password.
* run

```
cd mcc
./install-with-mcc.sh
```

to allocate the machines, install everything and configure antidote.
Each host will be associated with a hostname h\[0-9\]+ where h0 is the master and the other h_n are the minions.


# architecture of the salt recipes



## formulas

the antidote-stack recipes relies on custom formulas:

* https://gricad-gitlab.univ-grenoble-alpes.fr/herbautn/monitoring-formula.git to install the flow-matrix monitoring tools
* https://gricad-gitlab.univ-grenoble-alpes.fr/herbautn/monitoring-formula.git to install docker and configure the registry
* https://github.com/nherbaut/bind9-formula.git to install and configure the dns server

## orchestration

the installation and configuration and orchestrated in salt/orch/init.sls. It uses the formulas and the antidote state to configure the cluster.
The antidote cluster is configured through the salt/antidote/init.sls. Moreover, a file containing the command to connect all the antidote instances is generated on every cluster node in /root/connect.

## pillars

several pillars are used to configure the clusters:

```
.
├── antidote.sls  --> where to install antidote
├── dns.sls --> where to install the dns server and which dns server to forward
├── docker.sls --> which docker image should be pre-provisionned in the registry
├── monitoring.sls --> where to install the moni
├── placement.sls --> place each antidote instance named hX.rainbowfs.fr on a specific host
└── top.sls --> top file to reference all other pillars
```

## monitoring

monitoring is exposed on the port 5011 on the first host (h0).

if using mcc to install antidote, you can directly access the data on your local machine by issuing the following commands.
for this to work, you need to configure ssh proxycommand as explained in grid5000 wiki (https://www.grid5000.fr/mediawiki/index.php/SSH#Using_SSH_with_ssh_proxycommand_setup_to_access_hosts_inside_Grid.275000)

```
$> source alias
$>  ssh0
```

which will forward the h0 5011 port on the http://localhost:5011/. 