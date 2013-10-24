base:
  '*':
    - nfs
  salt:
    - match: nodegroup
    - nfs.server
