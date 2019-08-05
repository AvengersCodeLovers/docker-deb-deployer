#!/bin/bash
mkdir /root/.ssh
echo -e $PLUGIN_PUBLICKEY > /root/.ssh/id_rsa.pub
echo -e $PLUGIN_PRIVATEKEY > /root/.ssh/id_rsa
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
echo -e "Host $BASTION_SERVER\n\tUser $BASTION_USER\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config
echo -e "Host $PRIVATE_SERVER\n\tUser $PRIVATE_USER\n\tIdentityFile /root/.ssh/id_rsa\n\tProxyCommand ssh $BASTION_USER@$BASTION_SERVER -W %h:%p\n" >> /root/.ssh/config
echo "commandcollapse $PLUGIN_RUN"
$PLUGIN_RUN
echo -e "deploy:\n  comment: false\n  exit_code: $?\n  ignore: false" >> ./.framgia-ci-result.temp.yml
