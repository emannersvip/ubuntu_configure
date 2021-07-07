# https://linuxize.com/post/how-to-install-and-configure-vnc-on-ubuntu-20-04/

package {'tigervnc-standalone-server': ensure => installed}
package {'xfce4': ensure => installed}
package {'xfce4-goodies': ensure => installed}

$user = 'emanners'

file {'vnc_dir':
  ensure => directory,
  owner  => $user,
  path   => '/home/emanners/.vnc',
}

file {'vnc_passwd':
  ensure => present,
  path   => '/home/emanners/.vnc/passwd',
  mode   => '600',
  owner  => $user,
  source => '/home/emanners/Code/ubuntu_configure/puppet_files/passwd',
}

file {'vnc_xstartup':
  ensure => present,
  path   => '/home/emanners/.vnc/xstartup',
  mode   => '700',
  owner  => $user,
  source => '/home/emanners/Code/ubuntu_configure/puppet_files/xstartup',
}

file {'vnc_config':
  ensure => present,
  path   => '/home/emanners/.vnc/config',
  mode   => '700',
  owner  => $user,
  source => '/home/emanners/Code/ubuntu_configure/puppet_files/config',
}

exec {'vncserver':
  path        => '/bin:/usr/bin',
  environment => [ "HOME=/home/$user" ],
  command     => 'vncserver -localhost no',
  unless      => 'pgrep vncserver',
  require     => Package['tigervnc-standalone-server'],
}
