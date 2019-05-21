ElectrumX server saltstack formula
==================================

Based on https://github.com/bauerj/electrumx-installer

Tested on Debian 9

Deploy
------

* Change `electrumx_repo` variable in `init.sls`
* Setup pillar (see `pillar-example.sls`)
* This installation requires python3.7 formula as an additional dependency (see `init.sls:include python-alt-37`). You can get it at https://github.com/knek-little-projects/salt-formula-python-alt-37 or change it to another python3.7 formula.
