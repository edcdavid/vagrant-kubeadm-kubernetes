#! /bin/bash
set -x
systemctl enable docker
service docker start

/bin/bash /tmp/k8s/configs/join.sh -v

cp -i /tmp/k8s/configs/config $HOME/.kube/
chown 1000:1000 $HOME/.kube/config
NODENAME=$(hostname -s)
kubectl label node $(hostname -s) node-role.kubernetes.io/worker=worker-new
tail -f /dev/null
