# Packer templates for Fedora

### Overview

This repository contains Packer templates for creating Fedora Vagrant boxes.

## Building the Vagrant boxes with Packer

To build all the boxes, you will need [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

We make use of JSON files containing user variables to build specific versions of Ubuntu.
You tell `packer` to use a specific user variable file via the `-var-file=` command line
option.  This will override the default options on the core `fedora.json` packer template,
which builds Fedora 25 by default.

For example, to build Fedora 27 Server, use the following:

    $ packer build -var-file=fedora27-server.json fedora.json

If you want to make boxes for a specific desktop virtualization platform, use the `-only`
parameter.  For example, to build Fedora 27 Server for VirtualBox:

    $ packer build -only=virtualbox-iso -var-file=fedora27-server.json fedora.json

The boxcutter templates currently support the following desktop virtualization strings:

* `virtualbox-iso` - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) desktop virtualization

### Proxy Settings

The templates respect the following network proxy environment variables
and forward them on to the virtual machine environment during the box creation
process, should you be using a proxy:

* http_proxy
* https_proxy
* ftp_proxy
* rsync_proxy
* no_proxy

### Tests

The tests are written in [Serverspec](http://serverspec.org) and require the
`vagrant-serverspec` plugin to be installed with:

    vagrant plugin install vagrant-serverspec

Possible values for the CM variable are:

* `nocm` - No configuration management tool
* `chef` - Install Chef
* `puppet` - Install Puppet
* `salt`  - Install Salt

You can also specify a variable `CM_VERSION`, if supported by the
configuration management tool, to override the default of `latest`.
The value of `CM_VERSION` should have the form `x.y` or `x.y.z`,
such as `CM_VERSION := 11.12.4`

The variable `UPDATE` can be used to perform OS patch management.  The
default is to not apply OS updates by default.  When `UPDATE := true`,
the latest OS updates will be applied.

The variable `HEADLESS` can be set to run Packer in headless mode.
Set `HEADLESS := true`, the default is false.

The variable `PACKER` can be used to set the path to the packer binary.
The default is `packer`.

The variable `ISO_PATH` can be used to set the path to a directory with
OS install images.  This override is commonly used to speed up Packer
builds by pointing at pre-downloaded ISOs instead of using the default
download Internet URLs.

### Acknowledgments

Blatantly cloned and modified from the great Boxcutter repo: https://github.com/boxcutter/fedora So all credit goes to them for their awesome work. I trimmed down their repo for my purposes and reorganized JSON by building on their hard work.
