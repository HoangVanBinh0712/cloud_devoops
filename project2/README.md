# Diagram
You can view the diagram online. <a href="https://drive.google.com/file/d/10q8ydJuQbt6C79Q0Zs8A-wcXBDxqAHew/view?usp=sharing">Click here </a>
# Infrastructure
<p>To run the script follow the instructions below.</p>

1. Go to the AWS console, then create the key pair named "udacity_ssh" and save this key pair to your local machine we may use it to connect to bastion host then connect to private instance to debug.
2. Open git bash in the folder contains "README.md" file, then add the aws profile with name "admin" or if you already have aws profile in you computer just modify the run.sh file at "--profile admin" to "--profile [your_profile_name]".
3. Run this command to create the network:
   <p>./run.sh deploy us-east-1 network-stack yml/network.yml param/network-parameters.json</p>
4. Then Run this command to create the Udagram (server):
   <p>./run.sh deploy us-east-1 udagram-stack yml/udagram.yml param/udagram-parameters.json</p>
5. Wait util the aws created the resources. Go to the aws console then go to the CloudFormation check that there are 2 stacks created.
6. Select "udagram-stack" -> Open "Resources" tab to review all the resources created by this stack.
7. Open the physicalId of row that LogicalId is "MyCloudFrontDistribution". Copy the domain name and paste to the browser. You will see the website here.
8. You can review another resource like WebAppLB, S3Bucket,... for further information.
9. If you want to delete resource use command (You must delete the "udagram-stack" first).: 
   <p>./run.sh delete us-east-1 udagram-stack</p>
   <p>./run.sh delete us-east-1 network-stack</p>

# Debug

<div>After running this script we have 5 instances (4 instances for load balance and 1 for bastion host).</div>
<div>The Bastion host instance can connect with ssh by this "udacity_ssh.pem" that you created and downloaded before.</div>
<div>Run this command:</div>
   <p>* ssh-add ./udacity_ssh.pem</p>
   <p>* ssh -A -i ./udacity_ssh.pem ubuntu@[Bastion IP]</p>
<div>Then in the Bastion host instance run: ssh ubuntu@[WebApp Instance IP]</div>
<div>Now you can check that the nginx is running well or not.</div>