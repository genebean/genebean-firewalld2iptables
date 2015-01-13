[![Puppet Forge][pf-img]][pf-link] [![GitHub tag][gh-tag-img]][gh-link]

# firewalld2iptables

#### Table of Contents

1. [Overview](#overview)
2. [Parameters](#parameters)
3. [Usage](#usage)
4. [Limitations](#limitations)
5. [License](#license)
6. [Contributing](#contributing)

## Overview

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

## Limitations

This module is targeted at systems that are known to include `firewalld`. Right now, that is solely the Red Hat 7 family
of OS's. Contributions to expand coverage to other OS's are welcome.

## License

This is released under the New BSD / BSD-3-Clause license. A copy of the license
can be found in the root of the module.

## Contributing

Pull requests are welcome!

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-firewalld2iptables.svg
[gh-link]: https://github.com/genebean/genebean-firewalld2iptables
[pf-img]: https://img.shields.io/puppetforge/v/genebean/firewalld2iptables.svg
[pf-link]: https://forge.puppetlabs.com/genebean/firewalld2iptables
