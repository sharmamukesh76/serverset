TODO: Reference to CI/CD category and the previous CD article.

This exercise will attempt to provide one possible solution for reliable, fast and automatic continuous deployment with ability to test new release before it becomes available to general users and rollback back easily if something goes wrong. On top of that, we'll try to accomplish zero-downtime. No matter how many times we deploy our application, there should never be a single moment when it is not operational.

Therefore, our goals are:

* to deploy as often as needed
* to be fast
* to be automated
* to be able to rollback
* to have zero-downtime

Setting up the stage
====================

Let's set-up the technological part of the story. Application will be deployed as a [Docker](TODO) container. TODO: Short description of Docker.

While Docker can be deployed an any operating system, my preference is to use [CoreOS](TODO). TODO: Short description of CoreOS. An advantage CoreOS has over others is that it is very light. It has only few tools and they are just those we need for continuous deployment. We'll use [Vagrant](TODO) create an virtual machine with CoreOS.

TODO: Short description of etcd. It is already pre-installed on CoreOS.

TODO: Short description of systemd. It is already pre-installed on CoreOS.

TODO: Short description of confd.

We'll use [nginx](TODO) as our reverse proxy. TODO: Short description of nginx.

Finally, as an example application we'll deploy (many times) [BDD Assistant]. TODO: Short description of BDD Assistant.

CoreOS
======

If you do not already have an instance of CoreOS up and running, [TODO: Repo name](TODO) contains Vagrantfile that can be used to bring one up. Please clone that repo or download and uncompress the code from [here](TODO). To run the OS, please install [Vagrant](TODO) and run the following command from the directory with cloned (or uncompressed) repo.

```bash
vagrant up
```

Once creation and startup of the VM is finished, we can enter it using:

```bash
vagrant ssh
```

From now on you should be inside CoreOS.

Docker
======

We'll use [BDD Assistant](TODO) as an example simulation of continuous deployment. As a start, we'll run it directly with Docker. Further on we'll refine the deployment to be more resilient.

> I'm looking for early adopters of the application. If you're interested, please contact me and I'll provide all the help you might need.

Let's run it with Docker. Once the command below is executed it will start downloading the container images. First run might take a while. Good news is that images are cashed and later on it will update very fast when there is new version and run in a matter of milliseconds. 

```bash
# Run container technologyconversationsbdd and expose port 9000
docker run --name bdd_assistant -d -p 9000:9000 vfarcic/technologyconversationsbdd
```

To see the result, open [http://localhost:9000/](http://localhost:9000/) in your browser.

That was easy. With one command we downloaded fully operational application with AngularJS front-end, Play! web server, REST API, etc. The container itself is self-sufficient and immutable. New release would be a whole new container. There's nothing to configure (except the port application is running on) and nothing to update when new release is made. It simply works. 


etcd
====

Let's start the etcd.

```bash
etcd &
```

From now on, we can use it to store and retrieve information we need. As an example, we can store the port **BDD Assistant** is running. That way, any application that would need to use it, can retrieve the port and, for example, use it to invoke the application API.

```bash
# Set value for a give key
etcdctl set /bdd-assistant/port 9000
# Retrive stored value
etcdctl get /bdd-assistant/port
```

That was a very simple (and fast) way to store any key/value that we might need. It will come in handy very soon.

nginx
=====

At the moment, our application is running on port 9000. However, it would be even better if it would run without any port (actually default 80). Instead of opening localhost:9000 (or whatever port it's running) it would be better if it would simply run on localhost. We can use nginx reverse proxy to accomplish that.

This time we won't call Docker directly but run it as a service through systemd.

TODO: Continue

```bash
# Create directories for configuration files
sudo mkdir -p /etc/nginx/{sites-enabled,certs-enabled}
# Create directories for logs
sudo mkdir -p /var/log/nginx
# Copy nginx service
sudo cp /vagrant/nginx.service /etc/systemd/system/nginx.service
# Enable nginx service
sudo systemctl enable /etc/systemd/system/nginx.service
```

[nginx.service](TODO) file tells systemd what to do when we want to start, stop or restart some service. In our case, all services are created from Docker nginx container. First time it is started it might take a while until all Docker images are downloaded. From there on, starting and stopping an service is very fast.

Let's start the nginx.

```bash
# Start nginx service
sudo systemctl start nginx.service
# Check whether nginx is running as Docker container
docker ps
```

As you can see, nginx is running as a Docker container. Let's stop it.

```bash
# Stop nginx service
sudo systemctl stop nginx.service
# Check whether nginx is running as Docker container
docker ps
```

Now it disappeared from Docker processes. It's as easy as that. We can start and stop any Docker container in no time (assuming that images we're already downloaded).
 
We'll need nginx up and running for the rest of the article so let's start it again.

```bash
sudo systemctl start nginx.service
```

confd
=====

We need something to tell our nginx what port to redirect to when BDD Assistant is requested. We'll use confd for that. Let's  set it up.

```bash
# Download confd
wget -O confd https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64
# Put it to the bin directory so that it is easily accessible
sudo cp confd /opt/bin/.
# Give it execution permissions
sudo chmod +x /opt/bin/confd
```

Next step is to configure it to modify nginx routes and reload it every time we deploy our application.

```bash
# Create configuration and templates directories
sudo mkdir -p /etc/confd/{conf.d,templates}
# Copy configuration
sudo cp /vagrant/bdd_assistant.toml /etc/confd/conf.d/.
# Copy template
sudo cp /vagrant/bdd_assistant.conf.tmpl /etc/confd/templates/.
```

Both [bdd_assistant.toml](TODO) and [bdd_assistant.conf.toml](TODO) are in the repo you already downloaded.

Let's see how it works.

```bash
sudo confd -onetime -backend etcd -node 127.0.0.1:4001
cat /etc/nginx/sites-enabled/bdd_assistant.conf
```

We just updated nginx template to use the port previously set in etcd. Now you can open [http://localhost/](http://localhost/) in your browser. Even though the application is running on port 9000, we setup nginx to redirect call on the default port 80 to the port 9000.

Let's stop and remove the BDD Assistant container. We'll create it again but using all the tools we saw by now.

```bash
docker stop bdd_assistant
docker rm bdd_assistant
```

BDD Assistant Deployer
======================

Now that you are familiar with the tools, it's time to tie them all together.

We will practive [Blue Green Deployment](TODO). That means that we will have one release up and running (blue), when new release is to be deployed, it will be run in parallel (green). Once it's up and running, nginx will redirect all requests to it instead to the old one. Each consecutive release will follow the same process. Deploy over blue, redirect requests from green to blue, deploy over green, redirect requests from blue to green, etc. Rollback will be easy to do. We would just need to change the reverse proxy. There will be zero-down time since new release will be up and running before we start redirecting requests. Everything will be fully automated and very fast. With all that in place, we'll be able to deploy as often as we want (preferably on every commit to the repository). 

```bash
sudo cp /vagrant/bdd_assistant.service /etc/systemd/system/bdd_assistant_blue@9001.service
sudo cp /vagrant/bdd_assistant.service /etc/systemd/system/bdd_assistant_green@9002.service
sudo systemctl enable /etc/systemd/system/bdd_assistant_blue@9001.service
sudo systemctl enable /etc/systemd/system/bdd_assistant_green@9002.service
sudo systemctl daemon-reload
etcdctl set /bdd-assistant/instance none
sudo chmod 744 /vagrant/deploy_bdd_assistant.sh
sudo cp /vagrant/deploy_bdd_assistant.sh /opt/bin/.
```

We just created two services for deploying the [BDD Assistant](TODO): blue and green. Each of them will run on a different ports (9001 and 9002) and store relevant information to etcd.

Let's try it out.

```bash
sudo deploy_bdd_assistant.sh
```

After each run of the script deploy_bdd_assistant.sh, new release will be deployed. We can confirm that by checking what value is stored in etcd, looking at Docker processes and, finally, running the application in browser.

```bash
docker ps
etcdctl get /bdd-assistant/port
```

Docker process should change from running **blue** deployment on port 9001 to running green on port 9002 and the other way around. Port stored in etcd should be changing from 9001 to 9002 and vice versa. Whichever version is deployed, [http://localhost/](http://localhost/) will always be working in your browser no matter whether we are in the process of deployment or already finished it.

Repeat the execution of the script deploy_bdd_assistant.sh as many times as you like. It should always deploy a new version (actually the same one in this example since we are not changing the code).

For brevity of this article I excluded functional and integration tests from scripts. In "real world", after new container and run and before reverse proxy is set to point to it, we should run all sorts of tests (functional, integration and stress) that would validate that changes to the code are correct.

Continuous Deployment and Delivery
==================================

The process described above should be tied to your CI/CD application ([Jenkins](TODO), [Bamboo](TODO), [GoCD](TODO), etc). One possible complete continuous delivery procedure would be:

1. Commit the code to VCS ([GIT](TODO), [SVN](TODO), etc).
2. Run all [static analysis](TODO)
3. Run all [unit tests](TODO)
4. Deploy to the test environment.
   1. Run the container with the new version
   2. Run automated functional, integration and stress tests
   3. Perform manual tests
   4. Change the reverse proxy to point to the new container
5. Deploy to production environment.
   1. Run the container with the new version
   2. Run automated functional, integration and stress tests
   3. Change the reverse proxy to point to the new container

Ideally, there should be no manual tests and in that case point 4 is not necessary. In that case we would have [Continuous Deployment](TODO) that would automatically deploy to production every single commit that passed all tests. If manual verification is unavoidable, we have [Continuous Delivery](TODO) to test environments and software would be deployed to production on a click of a button in CI/CD application we're using.

Summary
=======

No matter whether we choose continuous delivery or deployment, when our process is (almost) completely automated (both tests and deployment itself), we can spend time working on things that bring more value while letting scripts do the work for us. Time to market should increase drastically since we can have features available to users as soon as code is committed to the repository. It's a very powerful and valuable concept.

For those who had trouble following the exercises, you can skip them go directly to running the deploy_bdd_assistant.sh script. Just remove comments (#) from the Vagrantfile.

If VM is already up and running, destroy it.

```bash
vagrant destroy
```

Create new VM and run the deploy_bdd_assistant.sh script.

```bash
vagrant up
vagrant ssh
sudo deploy_bdd_assistant.sh
```

Hopefully you can see the value in Docker. It's a game changer when compared to more traditional ways of packaging and deploying software. New doors have been opened for us and we should step through them.

[BDD Assistant](TODO) and it's deployment with Docker can be even better. We can split it into smaller microservices. It could, for example have front-end as one container. Back-end can be split into smaller services (stories managements, stories runner, etc). Those microservices can be deployed to the same or different machines and orchestrated with [Fleet](TODO). This will be the topic of the next articles.