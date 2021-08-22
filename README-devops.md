### Topology
Project forked from Kippo, which initially sounded like a promising Honeypot. 

A Kubernetes cluster was set up from scratch, using CloudFormation templates for some of its common resources needed. An IAM user was created for the purpose and is currently the only one permitted to manage EKS resources with kubectl.

CircleCI was then used to set up a CICD pipeline, the code of which is kept in `.circleci/config.yml`. It's connected to the forked GitHub repository and on every single push to it, it builds a Docker image and pushes it into the Docker Hub after authenticating using environment variable. 
The Dockerfile itself sets up the environment required by Kippo, including a Virtual Environment executed by a non-root user, as appropriate for a honeypot. It also sets up some basic logging.

Two YAML files have been produced to be used with `kubectl apply`:
1. A deployment definition, creating a K8s resource of type deployment using the custom image build and pushed by the CircleCI process. It also starts the honeypot process, ensuring resilience across pod restarts. 
2. A service definition, setting up a load balancer and forwarding the usual port 22 to the non-root port Kippo is running on 

### Usage
While the honeypot proved to be inadequate for modern SSH connections, you can verify the honeypot is running either by:
1. `nc -v aae49941f5bc64f809f299265048c9e3-2094867361.eu-west-1.elb.amazonaws.com 22`
2. `ssh ubuntu@aae49941f5bc64f809f299265048c9e3-2094867361.eu-west-1.elb.amazonaws.com `
If your ssh is ancient, you might even be able to get in instead of getting a Kex error.

### Further work
A TODO file has been produced, detailing further design decisions that have been identified and current limitations.