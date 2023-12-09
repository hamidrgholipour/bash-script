# add below line to sshd
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile /root/.ssh/authorized_keys

# print pub key
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

