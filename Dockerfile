FROM centos:7
MAINTAINER "Tolik Litovsky" <tlitovsk@redhat.com>
ENV container docker

RUN yum -y update; yum clean all;
RUN yum -y install yum-utils

# Libvirt install section libvirt install
# fix language
RUN yum -y install libvirt-daemon-driver-* libvirt-daemon libvirt-daemon-kvm qemu-kvm  qemu-kvm-tools  && yum clean all; \
	localedef -i en_US -c -f UTF-8 en_US.UTF-8 ;\
	systemctl enable libvirtd
VOLUME [ "/sys/fs/cgroup" ]
# libvirt installed

# VDSM install
RUN yum install -y http://resources.ovirt.org/pub/yum-repo/ovirt-release36.rpm
RUN yum -y install vdsm vdsm-cli && yum clean all;
RUN	systemctl enable vdsmd

# Prefetching host deploy requirments
RUN yum install -y tuned kexec-tools iptables-services && yum clean all

CMD ["/usr/sbin/init"]
