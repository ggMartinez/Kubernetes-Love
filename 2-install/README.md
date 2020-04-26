# Installing Kubernetes

Ah.. installing Kubernetes... as simple as it sounds... and it can be such a nightmare...

Kubernetes does a lot of things to make us happier and more productives, but going deep down to its techincal aspects are not a trivial thing. And, installing it, aren't neither.

Today, fortunatelly, Kubernetes does not have to be manually installed the old way, doing hard work on the command line, writting lot of crazy commands, on most cases, for both test and production environments.

Right now, we can have a nice Kubernetes cluster running using one (or more, if you prefer, or need) of this solutions:
- **Running it on a single VM, only locally, for testing and development pruposes**
	- If you use Windows or Mac, [Docker for Desktop](https://www.docker.com/products/docker-desktop) includes a single node, minimal,Kubernetes cluster. It only works locally, but for most development and testing tasks, is more than enough. You only have to enable it on the software's settings, and you are ready to go.
	- If you use Linux, you can use [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/). It's a tool that allows to do pretty much the same that Docker for Desktop does: install a very minimal cluster for doing testing and development stuff locally. It has some minor differences with Docker for Desktop. Also, this relies on lot of Hypervisors (Like Virtual Box) to work, and it is multiplatform, so you can use this option also for Windows or Mac if you like.
	
-  **Running it on a single (Bare Metal or VM) host, that accept connections from other host in your network, again, for testing and development pruposes.** 
	- You run some commands, do some nasty stuff that you wouldn't do on a production environment, and you can have a single VM similar to that of Minikube, but that has connectivity from all hosts on your network, or, for example, if you want to install it on an server running an Hypervisor, or even a single physical PC or Server that you would like to use for this.

- **Running in on multiple (Bare Metal or VM) hosts, pretty much like the last one, but having redundancy with more than one hosts, and thus, being suitable for Production.**
	- This is the **MOST DIFFICULT** setup to do. Only do it if you don't have other option.
    - This is the most manual installation in the cosmos. You have at least 5 hosts running Linux and Docker, and use them to install Kubernetes. They can be VMs (wheter on your own hypervisor, or instances running on a cloud privider, like AWS EC2 for example) and/or Physical servers. Even they can be, for example, in separated networks if you want. The only condition here is that all of them has connectivity between each others.

- **Using some Cloud Providers that offers Kubernetes-as-a-Service, save time, butt pain, and be happier**
	- With this method, you only use the Kubernetes Service that some cloud providers offers to you.
	- You don't need to install anything on your end. You only will get an endpoint for accesing the cluster, and you only have Worker Nodes. Don't even need to worry about managing and administrating the Master servers, the provider will do it for you.
	- This is the recommended way to use kubernetes in production.

Well then, let's go to some steps!

## Docker for Desktop
The easiest way. Download Docker for Desktop from its website, install it, when the Docker service is running, right click on its Icon, go to Settings, to the Kubernetes section, and presto. It will install kubernetes in your computer, install the CLI tool for using kubernetes (kubectl), and configure it so you can start using your local kubernetes.

Same thing applies for both Windows or Mac.

## Minikube

## Single Node Kubernetes Install (testing)

## Multiple node Kubernetes Install (production)

## Kubernetes-as-a-service

There's no much to say here. Just register to your favorite Cloud Services provider, create a cluster using its service, whatever name it has, and done.
They have different names, and some differences between them, but for the most part, you use it all the same.
- Amazon Web Services offers Elastic Kubernetes Service (EKS)
- Microsoft Azure offers Azure Kubernetes Service (AKS)
- Google offers Google Kubernetes Engine
- Others providers may offer Kubernetes-as-a-service, but these are the most used ones. No sponsoring! 

Wheter to use one or another, it's up to you if the differences between them mean something to you. Your choice. What I'm about to cover will work on them mostly, I can't keep up with their changes, so, it's up to you also to choice the best one for you if you need it.