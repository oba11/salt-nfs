include:
  - .client

/etc/idmapd.conf:
  file.managed:
    - source: salt://files/etc/idmapd.conf
    - user: root
    - group: root
    - mode: 0644
