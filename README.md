# answrk
files to build ansible worker docker image

# Build && Run
```
docker build -t ansibleworker:latest --build-arg SSH_PRV_KEY="$(cat ~/.ssh/id_rsa)" --build-arg SSH_PUB_KEY="$(cat ~/.ssh/id_rsa.pub)" .
```

```
docker run -ti --rm -v $(pwd)/ansible:/etc/ansible -v $(pwd)/playbooks:/playbooks --network=host ansibleworker:latest
```

# etc
```
ansible-galaxy install --roles-path /etc/ansible/roles -r /etc/ansible/requirements.yml
```
