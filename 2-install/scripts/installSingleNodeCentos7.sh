#!/bin/bash
# Not the best bash script in the world, but does the job.

clear
echo ''
echo '#######################################################################'
echo '#######################################################################'
echo '###                                                                ####'
echo '###    WARNING: THIS IS NOT FOR PRODUCTION USE.                    ####'
echo '###    THIS WILL DO LOT OF CRAP THAT I AM NOT PROUD OF             ####'
echo '###    AND I WILL NOT TAKE ANY RESPONSABILITY OF THE HELL          ####'
echo '###    THIS COULD UNLEASH TO YOUR LIFE.                            ####'
echo '###                                                                ####'
echo '###                                                                ####'
echo '###    THIS WILL DO THOSE THINGS FOR TEST PRUPORSES:               ####'
echo '###       - Disable swap (Needed for kubernetes)                   ####'
echo '###       - Disable firewall (firewalld or iptables)               ####'
echo '###       - Disable SELinux (Dont need to focus on that right now) ####'
echo '###                                                                ####'
echo '###                                                                ####'
echo '###    ARE YOU ABSOLUTELY SURE TO CONTINUE? YOU SWEAR TO USE       ####'
echo '###    THIS SERVER ONLY FOR TESTING?                               ####'
echo '###                                                                ####'
echo '#######################################################################'
echo '#######################################################################'

echo ''
echo ''
read -p 'YOUR ANSWER (say "yes" to continue): ' beSure

if [ $beSure != 'yes' ]
    then 
    echo 'ABORTING ALL!!!...'
    exit 1
fi 

echo "Disabling Firewall"
echo ""
chkconfig firewalld off
chkconfig iptables-services off
echo ""

echo "Disabling SELinux"
echo ""
setenforce 0


echo "Installing Docker"
echo ""
yum install -y docker
service docker start
chkconfig docker on

echo "Doing some nasty things with sysctl"
echo ""
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
echo ""

echo "Adding Kubernetes Repo"
echo ""
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
echo ""

echo "Installing Kubelet, Kubeadm and Kubectl"
echo ""
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet
systemctl start kubelet
echo ""

echo "Creating Cluster"
echo ""
kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p /root/.kube
cp /etc/kubernetes/admin.conf /root/.kube/config

echo "Installing Flannel Network"
echo ""
kubectl apply -f  https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
echo ""

echo "Removing running workloads on this master node restriction"
echo ""
kubectl taint nodes --all node-role.kubernetes.io/master-
echo ""

echo "Installing Kubectx and Kubens tools"
echo ""
curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens > /bin/kubens
curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx > /bin/kubectx
chmod +x /bin/kubectx && chmod +x /bin/kubens
echo ""

# Ingress controller reference: https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal"
#
echo "Installing Nginx Ingress Controller"
echo ""
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
echo ""

# If you want Load Balacing with specific IP address, you can use MetalLB (https://metallb.universe.tf/installation/)
