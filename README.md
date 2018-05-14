#what's in here?

This repository contains a collection of salt receipes that install and configure antidtedb to run on a cluster of machines. It uses salt for easy operations and optionally use mcc for easy installation

# where to start

## installing salt

salt is a tool used to define a infrastructure as a document, and sync the real infrastructure with the document by installing component, launching service, writing configuration files and so on.
To get started, you can refer to the saltstack documentation (https://docs.saltstack.com/en/latest/topics/installation/index.html#quick-install) or use mcc, as show on the next paragraph.

* On the master and minions, install git and pip (apt-get install git python-pip --yes) then from pip install the docker python lib (pip install docker netifaces).
* use provided master configuration file template mcc/master.tpl to configure the master
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

## installing salt with mcc

mcc (multi-cloud console) is a tool that aims at making the test environment provisionning easier, working with grid5000 for the moment but expensible to any cloud provider through libcloud.
mcc uses a settings.yaml file to gather all the information required to complete the steps.

* edit ./mcc/settings.yaml and change the informations about your private and poublic key and your g5k login and password.
* run

```
cd mcc
./install-with-mcc.sh
```

to allocate the machines, install everything and configure antidote.


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
