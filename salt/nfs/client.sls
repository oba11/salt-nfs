{% set config_nfs = pillar['config_nfs'] %}

nfs-common:
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
      - pkg: nfs-common
    - watch:
      - file: nfs-common
  file.managed:
    - name: /etc/default/nfs-common
    - source: salt://files/etc/default/nfs-common
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: nfs-common

{% for export, export_values in config_nfs['exports'].items() %}
{{ export }}:
  file.directory:
    - user: {{ export_values['user'] }}
    - group: {{ export_values['user'] }}
    - dir_mode: 0755
    - require:
      - file: nfs-common
{% if grains['host'] is matching(export_values['clients']) %}
  mount.mounted:
    - device: {{ config_nfs['server'] }}:{{ export }}
    - fstype: nfs
    - opts:
      - defaults,rw
    - persist: True
    - require:
      - file: {{ export }}
{% endif %}
{% endfor %}
