# firewalld2iptables

This module takes care of performing the conversion described at
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Using_Firewalls.html#sec-Using_iptables

## Parameters:

`manage_package`        

Installs the iptables-services package when true,
which is the default value.  
type: boolean

`iptables_ensure`

This value is passed to the ensure key of the
resource. This should be 'present' or 'latest'.
The default value is 'present'.

`iptables_enable`

Determines if iptables is enabled.
Defaults to true.  
type: boolean

`ip6tables_enable`

Determines if ip6tables is enabled.
Defaults to true.  
type: boolean

## Usage:

### Simple usage:

```puppet
include ::firewalld2iptables
```

In manifests that also utilize `puppetlabs-firewall` or other methdods of configuring iptables you
need to ensure that this is run first. To do that, just change the include line to require like so:

```puppet
require ::firewalld2iptables
```

### Manage the iptables-services package elsewhere

```puppet
class { '::firewalld2iptables': $manage_package => false, }
```
