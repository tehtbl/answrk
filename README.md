# answrk

Files to build a docker image to work with Ansible

# Local Build && Run

```
docker build -t tehtbl/answrk:latest .
```

```
docker run -ti --rm --network=host \
  -v $(pwd)/ansible:/etc/ansible \
  -v $(pwd)/playbooks:/playbooks \
  -v ${HOME}/.ssh:/root/.ssh:ro \
  tehtbl/answrk:latest
```
