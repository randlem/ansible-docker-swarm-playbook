# ansible-docker-swarm-playbook
An Ansible playbook to setup and configure a Docker Swarm with Consul as the backend

**Step 1:**

Edit inventory file: `swarm_cluster` to suite your environment

**Step 2:**
Generate the TLS keys and place them in `ca/`

```
# start_ca.sh - run this if you need to generate the root CA certs
gen_node_cert.sh [name]
```

Certs need to be generated for the following items: client, swarm manager, and each docker instance.  The can be created with any name but "client" is recommended.  The swarm manager cert needs to be created with the name manager.  For the docker instances, the name should be that nodes hostname.  By default the script will generate all the files in the `ca/` directory.  The ansible scripts look for the keys on this path.

**Step 3:**

Run the `infrastructure.yml` playbook:

```
ansible-playbook infrastructure.yml -i swarm_cluster
```

This will setup the infrastructure required to make the swarm work.  It will install docker, consul, and ensure that basic utilities are in place.

**Step 4:**

Run the `swarm.yml` playbook:

```
ansible-playbook swarm.yml -i swarm_cluster
```

You should now have a swarm up and running.  Additionally each worker node in the cluster will be running the registrator container to ensure that started services end up registered in Consul.

Read the original blog post: [Docker Swarm with Ansible](http://blog.toast38coza.me/docker-swarm-with-ansible-a-late-swarmweek-entry/)

**Step 5:**

Install the client certs to connect to the swarm

```
mkdir -p ~/.docker/swarm
cp ca/ca.pem ~/.docker/swarm
cp ca/client-priv-key.pem ~/.docker/swarm/key.pem
cp ca/client-cert.pem ~/.docker/swarm/cert.pem
export DOCKER_CERT_PATH=~/.docker/swarm
```