config_nfs: {
  'server' : 'salt',
  'exports': {
      '/data': {
        'user'       : 'www-data', # The directory owner of the mount
        'address'    : '192.168.168.0/24',
        'permissions': 'rw,async,no_root_squash,no_subtree_check',
        'clients'    : '.*'
      },
      '/uploads': {
        'user'       : 'www-data', # The directory owner of the mount
        'address'    : '192.168.169.0/24',
        'permissions': 'rw,async,no_root_squash,no_subtree_check',
        'clients'    : '^web.*'
      }
  }
}
