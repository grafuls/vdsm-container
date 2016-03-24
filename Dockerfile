FROM centos:7
MAINTAINER "Tolik Litovsky" <tlitovsk@redhat.com>
ENV container docker

RUN yum -y update; yum clean all;
RUN yum -y install yum-utils

# Libvirt install section libvirt install
# fix language
RUN yum -y install libvirt-daemon-driver-* libvirt-daemon libvirt-daemon-kvm qemu-kvm  qemu-kvm-tools openssh-server wget && yum clean all; \
	localedef -i en_US -c -f UTF-8 en_US.UTF-8 ;\
	systemctl enable libvirtd
VOLUME [ "/sys/fs/cgroup" ]
# libvirt installed

#sshd install
RUN yum install -y openssh-server && yum clean all; \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
	echo 'root:12345' | chpasswd; \
	systemctl enable sshd

RUN echo 'SELINUX=permissive' > /etc/sysconfig/selinux ;\
	echo 'SELINUXTYPE=targeted' >> /etc/sysconfig/selinux

#sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/sysconfig/selinux ;/virtua
# VDSM install
RUN yum install -y http://resources.ovirt.org/pub/yum-repo/ovirt-release36.rpm ;\
 	sed -i 's/pub.key/rsa.pub/' /etc/yum.repos.d/ovirt-3.6-dependencies.repo ;\
 	yum -y install vdsm vdsm-cli tuned kexec-tools iptables-services && yum clean all; \
	sed -i 's/multipathd.service/ /' /usr/lib/systemd/system/vdsmd.service

RUN rm -rf /etc/yum.repos.d/*
# we need to dsable selinux
# fixresolv .conf
#



EXPOSE 22
EXPOSE 54231

CMD ["/usr/sbin/init"]

