# app-deployment-tf
### Terraform module to deploy applicatoin in high availablity in asia-pacific region in AWS

## Resources

- VPC
- Subnets
- NAT Gateway
- Elastic IPs
- Ubuntu Instances
- Load Balancer

## Usage
```
module "app_deployment" {
    source = "github.com/yp969803/app-deployment-tf"
    private_ec2_instance_type = "t2.micro"
    public_ec2_instance_type="t2.micro" 
    key_name="newKey" 
}

```

```
outputs :
public_ip_ec2_a
public_ip_ec2_b
alb_dns
```
