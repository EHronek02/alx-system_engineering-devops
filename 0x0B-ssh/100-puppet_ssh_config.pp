#set up coniguration file so that you can connect to a server
# without typing a password
file_line { 'TUrn off passwd-auth':
  ensure  => 'present',
  path    => '/etc/ssh/ssh_config',
  line    => 'PasswordAuthentication no',
}

file_line { 'Declaring IdentiyFile':
  ensure  => 'present',
  path    => '/etc/ssh/ssh_config',
  line    => 'IdentityFile ~/.ssh/school',
}
