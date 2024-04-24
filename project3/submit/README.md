#How I build this project

Create a cluster => node group
\
Create DB by running these script in the db folder.
   + kubectl apply -f pv.yaml
   + kubectl apply -f pvc.yaml
   + kubectl apply -f postgresql-deployment.yaml
   + kubectl apply -f postgresql-service.yaml

Then in the repository they provided me the sql to create data for database. 

I am using windows, so I run these commands to insert data:
   + To forward: kubectl port-forward service/postgresql-service 5433:5432
   + Get-Content 1_create_tables.sql | psql --host 127.0.0.1 -U myuser -d mydatabase -p 5433
   + Get-Content 2_seed_users.sql | psql --host 127.0.0.1 -U myuser -d mydatabase -p 5433
   + Get-Content 3_seed_tokens.sql | psql --host 127.0.0.1 -U myuser -d mydatabase -p 5433

Build docker file for application:
 + Note that relate to the architecture of instance we launch (adm64, arm64) we will have to modify the Docker file to make the container compatible with that architecture.

Create a codebuild on aws and link it to the github repository that I pushed the code.

Create ECR repository then add the env variable that the buildspec.yaml will use to push the images.

Use the template code provide in the "Build the Analytics Application" section. Modify the URI to repository.
 + Create config-map.yaml to create some environment variables.
 + Create secret.yaml to store secret. 
 + Create deployment.yaml: This file will config the template for pods running our application. Add the config above to the "analytics-deployment.yaml" in the env section.
 + Create service.yaml that will create a load balancer for nodes.

(1) Enter commands in order :
+ kubectl apply -f config-map.yaml
+ kubectl apply -f secret.yaml
+ kubectl apply -f analytics-deployment.yaml
+ kubectl apply -f analytics-service.yaml

(2) If you would like to change the template or change the config file, you must delete the current service, deployment, pods.
Then do the step (1). It will create a new deployments, service, pods that will apply your change.

If you want to build another docker images of this app. Change the code then push to github.
+ Go to codebuild -> build.
+ Go to repository -> copy the new image uri => apply to the analytics-deployment.yaml
+ Then do the step (2).

Here is the problem that I faced in this project:

+ I follow the video on this course, the selected the instance linux (arm64) but my dockerfile does not have the --platform=linux/arm64
So My pods is not running (logs: exec /usr/local/bin/python: exec format error).
+ This time I checked again my template, service, deployment and see nothing wrong. I searched for a while.
After I try another Architecture of linux (amd64) it works.

