{% set config_nfs = pillar['config_nfs'] %}

nfs-kernel-server:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nfs-kernel-server
    - watch:
      - file: nfs-kernel-server
  file.managed:
    - name: /etc/exports
    - source: salt://templates/etc/exports
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
      config_nfs: {{ config_nfs }}
    - require:
      - pkg: nfs-kernel-server

{% for export, export_values in config_nfs['exports'].items() %}
{{ export }}:
  file.directory:
    - user: {{ export_values['user'] }}
    - group: {{ export_values['user'] }}
    - dir_mode: 0755
    - require_in:
      - file: nfs-kernel-server
{% endfor %}
