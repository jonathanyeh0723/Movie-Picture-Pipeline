# AWS CI/CD
Basically the code is ready. But the configuration may need to be updated for the credentials.

Take a look.

## Frontend CI and Backend CI
No need to change. Just manually run the workflow. It would succeed.

## Frontend CD and Backend CD
First, open the terminal to configure aws.
```
aws configure

AWS Access Key ID [****************4ID4]: <your-aws-access-key>
AWS Secret Access Key [****************vuBu]: <your-aws-secret-key>
Default region name [us-east-2]: 
Default output format [json]: 
```

Check:
```
aws configure list

      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************3GPZ shared-credentials-file    
secret_key     ****************O2RX shared-credentials-file    
    region                us-east-2      config-file    ~/.aws/config
```

Go ahead to configure aws session token
```
aws configure set aws_session_token <your-aws-session-token>
```

OK. Now let's create a EKS kubernetes cluster.
```
eksctl create cluster --name cluster --nodes=2 --version=1.29 --instance-types=t2.micro --region=us-east-2
```

Note the cluster name is `cluster` to match what we address in the .yaml code `frontend-cd.yaml` and `backend-cd.yaml`. Specifically, the parts:
```
    - name: Update kubeconfig for EKS
      run: |
        aws eks --region us-east-2 update-kubeconfig --name cluster 
```

Output logs:
```
2024-06-20 16:16:33 [ℹ]  eksctl version 0.177.0
2024-06-20 16:16:33 [ℹ]  using region us-east-2
2024-06-20 16:16:34 [ℹ]  setting availability zones to [us-east-2a us-east-2b us-east-2c]
2024-06-20 16:16:34 [ℹ]  subnets for us-east-2a - public:192.168.0.0/19 private:192.168.96.0/19
2024-06-20 16:16:34 [ℹ]  subnets for us-east-2b - public:192.168.32.0/19 private:192.168.128.0/19
2024-06-20 16:16:34 [ℹ]  subnets for us-east-2c - public:192.168.64.0/19 private:192.168.160.0/19
2024-06-20 16:16:34 [ℹ]  nodegroup "ng-9a7c0e68" will use "" [AmazonLinux2/1.29]
2024-06-20 16:16:34 [ℹ]  using Kubernetes version 1.29
2024-06-20 16:16:34 [ℹ]  creating EKS cluster "cluster" in "us-east-2" region with managed nodes
2024-06-20 16:16:34 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial managed nodegroup
2024-06-20 16:16:34 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-east-2 --cluster=cluster'
2024-06-20 16:16:34 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "cluster" in "us-east-2"
2024-06-20 16:16:34 [ℹ]  CloudWatch logging will not be enabled for cluster "cluster" in "us-east-2"
2024-06-20 16:16:34 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=us-east-2 --cluster=cluster'
2024-06-20 16:16:34 [ℹ]  
2 sequential tasks: { create cluster control plane "cluster", 
    2 sequential sub-tasks: { 
        wait for control plane to become ready,
        create managed nodegroup "ng-9a7c0e68",
    } 
}
2024-06-20 16:16:34 [ℹ]  building cluster stack "eksctl-cluster-cluster"
2024-06-20 16:16:36 [ℹ]  deploying stack "eksctl-cluster-cluster"
2024-06-20 16:17:06 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:17:36 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:18:37 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:19:38 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:20:39 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:21:40 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:22:40 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:23:41 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:24:42 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-cluster"
2024-06-20 16:26:48 [ℹ]  building managed nodegroup stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:26:49 [ℹ]  deploying stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:26:50 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:27:20 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:28:04 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:29:41 [ℹ]  waiting for CloudFormation stack "eksctl-cluster-nodegroup-ng-9a7c0e68"
2024-06-20 16:29:42 [ℹ]  waiting for the control plane to become ready
2024-06-20 16:29:42 [✔]  saved kubeconfig as "/home/openvino/.kube/config"
2024-06-20 16:29:42 [ℹ]  no tasks
2024-06-20 16:29:42 [✔]  all EKS cluster resources for "cluster" have been created
2024-06-20 16:29:42 [✔]  created 0 nodegroup(s) in cluster "cluster"
2024-06-20 16:29:43 [ℹ]  nodegroup "ng-9a7c0e68" has 2 node(s)
2024-06-20 16:29:43 [ℹ]  node "ip-192-168-17-124.us-east-2.compute.internal" is ready
2024-06-20 16:29:43 [ℹ]  node "ip-192-168-69-74.us-east-2.compute.internal" is ready
2024-06-20 16:29:43 [ℹ]  waiting for at least 2 node(s) to become ready in "ng-9a7c0e68"
2024-06-20 16:29:43 [ℹ]  nodegroup "ng-9a7c0e68" has 2 node(s)
2024-06-20 16:29:43 [ℹ]  node "ip-192-168-17-124.us-east-2.compute.internal" is ready
2024-06-20 16:29:43 [ℹ]  node "ip-192-168-69-74.us-east-2.compute.internal" is ready
2024-06-20 16:29:43 [✔]  created 1 managed nodegroup(s) in cluster "cluster"
2024-06-20 16:29:44 [ℹ]  kubectl command should work with "/home/openvino/.kube/config", try 'kubectl get nodes'
2024-06-20 16:29:44 [✔]  EKS cluster "cluster" in "us-east-2" region is ready
```

Check it is working.
```
kubectl get node

NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-17-124.us-east-2.compute.internal   Ready    <none>   55s   v1.29.3-eks-ae9a62a
ip-192-168-69-74.us-east-2.compute.internal    Ready    <none>   60s   v1.29.3-eks-ae9a62a
```

Update the kubeconfig.
```
aws eks --region us-east-2 update-kubeconfig --name cluster
```

Now it is very important! You will need to go to your GitHub account to update the secrets. These are:
 - `AWS_ACCESS_KEY_ID`: The same you configure previously in command line.
 - `AWS_SECRET_ACCESS_KEY`: The same you configure previously in command line.
 - `AWS_SESSION_TOKEN`: The same you configure previously in command line.
 - `AWS_ACCOUNT_ID`: Note that you can get this info by running the aws cli:
    ```
    aws sts get-caller-identity \
    --query Account \
    --output text
    ```
 - `FRONTEND_REPO_NAME`: You will need to revisit the AWS web console, navigate to Amazon Elastic Container Registry. Create a new one if it is not existed. And then reflect this repo name to your secret. For example, the `frontend` is chosen.
 - ``: Again, you will need to revisit the AWS web console, navigate to Amazon Elastic Container Registry. Create a new one if it is not existed. And then reflect this repo name to your secret. For example, the `backend` is chosen.

!
!
!
!

Once it's done, you can run the workflow manually! It should work successfully.

After the workflows have been completed, back to the command line to check.
```
kubectl get deploy

NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    1/1     1            1           2m52s
frontend   1/1     1            1           16m
```

