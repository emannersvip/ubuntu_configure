# Build New Ubuntu host 2021
#
$user    = 'emanners'
$homedir = "/home/$user"
$codedir = "$homedir/Code"

file { "/btrfs":                ensure => directory, }
file { "$homedir/Code":         ensure => directory, owner => $user, group => $user }
file { "$homedir/Crypto":       ensure => directory, owner => $user, group => $user }
file { "$homedir/Crypto/Chia":  ensure => directory, owner => $user, group => $user, require => File["$homedir/Crypto"] }
file { "$homedir/Crypto/Chia/logs": ensure => link, target => "$homedir/.chia/mainnet/log", require => File["$homedir/Crypto/Chia"] }

#--
package { 'htop':  ensure => installed, }
package { 'iotop':  ensure => installed, }
package { 'mlocate':  ensure => installed, }
package { 'nfs-common':  ensure => installed, }
package { 'screen':  ensure => installed, }
# https://forum.level1techs.com/t/how-to-reformat-520-byte-drives-to-512-bytes-usually/133021
package { 'sg3-utils': ensure => installed, }
package { 'smartmontools':  ensure => installed, }
#--Miscellaneous files
#
#--Vim
package { 'vim':  ensure => installed, }
file { "$homedir/.vimrc":
  ensure        => present,
  owner         => $user,
  group         => $user,
  content       => "colorscheme darkblue\nsyntax on",
}
if $hostname != 'threeleaf-4u' {
  # https://docs.huihoo.com/puppet/references/stable/type.html#mount
  mount { "btrfs_nfs":
    ensure  => 'mounted',
    name    => '/btrfs',
    device  => '192.168.1.86:/btrfs/Plots',
    fstype  => 'nfs',
    options => 'defaults,_netdev',
    dump    => 0,
    pass    => 0,
  }
}
