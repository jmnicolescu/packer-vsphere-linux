# Using Packer to build a CentOS template for VMware vSphere

This repository contains files used by [Packer][packer] to create a CentOS 7.x image.


### Configuration
```
├── centos7-vsphere.json
├── ks.cfg
├── Redme.md
└── scripts
    ├── 01_juliusn_settings.sh
    ├── 02_configure_httpd.sh
    ├── 03_configure_ntp.sh
    ├── 05_configure_nfs.sh
    ├── 06_configure_powershell.sh
    ├── 08_configure_vnc.sh
    ├── 09_configure_named.sh
    ├── 11_install_python.sh
    ├── 12_install_ansible.sh
    ├── 13_install_ms_code.sh
    ├── 14_install_fio_nmon.sh
    └── 15_install_packer_terraform.sh
```

There are two basic files required to deploy a CentOS 7.x in VMware using Packer:

    1. The centos7-vsphere.json file (the Packer template)

    2. The ks.cfg file (the CentOS7 Kickstart file)

The template has several sections:

    1. Variables (optional): This section is used to defines user variables contained in the template.

    2. Builders (required): This section is the most important and here we define the connection with vCenter, the operating system images, define virtual machine details, and communicators.

    3. Provisioners (optional): This section installs and configures the machine image after booting.

    4. Post-processor (optional): This section configures any post-processing that will be done to images built by the builders. Examples of post-processing would be compressing files, uploading images to a datastore, etc.


### Verify the configuration files are OK

    \> packer validate centos7-vsphere.json

    ]> ksvalidator ks.cfg


### Execute

    Build a CentOS 7.X Template without GUI

    \> packer build centos7-vsphere-noX.json 

    Build a CentOS 7.x Template with GNOME Destop

    \> packer build centos7-vsphere-GNOME.json


### Packer Logging

To setup logging for your image builds, set the following parameters from the terminal.

    export PACKER_LOG_PATH="/tmp/packer.log"

    export PACKER_LOG=10   