# ansible-docker-swarm-playbook
An Ansible playbook to setup and configure a Docker Swarm with Consul as the backend

**Step 1**

Edit inventory file: `swarm_cluster` to suite your environment

**Step 2:**

Run the `infrastructure.yml` playbook:

```
ansible-playbook infrastructure.yml -i swarm_cluster
```

This will setup the infrastructure required to make the swarm work.  It will install docker, consul, and ensure that basic utilities are in place.

**Step 3:**

Run the `swarm.yml` playbook:

```
ansible-playbook swarm.yml -i swarm_cluster
```

You should now have a swarm up and running.  Additionally each worker node in the cluster will be running the registrator container to ensure that started services end up registered in Consul.

Read the original blog post: [Docker Swarm with Ansible](http://blog.toast38coza.me/docker-swarm-with-ansible-a-late-swarmweek-entry/)


