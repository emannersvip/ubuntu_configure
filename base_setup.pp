# Build New Ubuntu host 2021
#

$homedir = '/home/emanners'

file { "$homedir/Crypto":       ensure => directory, }
file { "$homedir/Crypto/Chia":  ensure => directory, }

#--
package { 'htop':  ensure => installed, }
package { 'iotop':  ensure => installed, }
package { 'screen':  ensure => installed, }
# https://forum.level1techs.com/t/how-to-reformat-520-byte-drives-to-512-bytes-usually/133021
package { 'sg3-utils': ensure => installed, }
package { 'smartmontools':  ensure => installed, }
#--
package { 'vim':  ensure => installed, }
file { "$homedir/.vimrc":
  ensure        => present,
  content       => "colorscheme darkblue\nsyntax on",
}
