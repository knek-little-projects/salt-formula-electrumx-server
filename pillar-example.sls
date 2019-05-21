{% set username = "USERNAME" %}
{% set password = "PASSWORD" %}
{% set address = "electrumx.yourcompany.com:18332" %}

electrumx:
  repo:
    electrumx:
      url: https://github.com/kyuupichan/electrumx
      hash: d2fe2728f27998334b298028e4b4f8ac797db710
  config:
    # See http://electrumx.readthedocs.io/en/latest/environment.html for
    # information about other configuration settings you probably want to consider.

    # Bitcoin Node RPC Credentials
    DAEMON_URL: http://{{ username }}:{{ password }}@127.0.0.1:18332
    COIN: BitcoinSegwit
    DB_DIRECTORY: /db
    RPC_HOST: 127.0.0.1

    # Ports will open when electrumx is fully synchronized with the btc deamon
    TCP_PORT: 50001

    SSL_CERTFILE: /etc/vault_pki/live/{{ salt['grains'].get('id') }}/cert.pem
    SSL_KEYFILE: /etc/vault_pki/live/{{ salt['grains'].get('id') }}/privkey.pem
    SSL_PORT: 50002

    # Leave empty to listen on all interfaces:
    HOST: ""

    MAX_SESSIONS: 2000
    MAX_SEND: 5000000
    MAX_SUBS: 500000
    MAX_SESSION_SUBS: 500000
    BANDWIDTH_LIMIT: 100000000
    SESSION_TIMEOUT: 1800

    PEER_ANNOUNCE: ""
    PEER_DISCOVERY: self
    CACHE_DB: 2000

