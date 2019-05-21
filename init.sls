{% set electrumx_repo = pillar["electrumx"]["repo"]["electrumx"] %}

include:
  - python-alt-37

electrumx_dependencies:
  pkg.installed:
    - pkgs:
      - git
      - gcc
      - build-essential
      - libsnappy-dev
      - zlib1g-dev
      - libbz2-dev
      - libgflags-dev
      - libffi-dev
      - libleveldb-dev

download_electrumx:
  git.latest:
    - target: /tmp/electrumx
    - name: "{{ electrumx_repo["url"] }}"
    - rev: "{{ electrumx_repo["hash"] }}"
    - require:
      - pkg: electrumx_dependencies

adduser:
  user.present:
    - name: electrumx
    - groups:
      - cert-access

/db:
  file.directory:
    - user: electrumx
    - group: electrumx
    - makedirs: True
    - require:
      - user: adduser

install_electrumx:
  cmd.run:
    - name: |
        cd /tmp/electrumx
        sed -i "s:usr/bin/env python3:usr/bin/env python3.7:" electrumx_rpc
        sed -i "s:usr/bin/env python3:usr/bin/env python3.7:" electrumx_server
        pip3.7 install . --upgrade
        cp contrib/systemd/electrumx.service /etc/systemd/system/electrumx.service
        touch /var/log/ELECTRUMX-INSTALLED
    - unless: test -f /var/log/ELECTRUMX-INSTALLED
    - require:
      - cmd: python37_altinstall
      - git: download_electrumx

/etc/electrumx.conf:
  file.managed:
    - source: salt://electrumx/templates/electrumx.conf.jinja
    - template: jinja
    - require:
      - cmd: install_electrumx

electrumx:
  service.running:
    - enable: True
    - require:
      - cmd: install_electrumx
      - file: /etc/electrumx.conf
      - file: /db
    - watch:
      - file: /etc/electrumx.conf