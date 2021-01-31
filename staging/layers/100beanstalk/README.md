# 100beanstalk

This layer creates the compute resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | The account ID you are building into. | string | n/a | yes |
| environment | The name of the environment, e.g. Production, Development, etc. | string | `"Development"` | no |
| region | The AWS region the state should reside in. | string | `"ap-southeast-2"` | yes |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'.. | string | n/a | yes |
| name | Solution name, e.g. 'app' or 'jenkins'. | string | n/a | yes |
| description | Short description of the Environment. | string | n/a | yes |
| solution\_stack\_name | Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html. | string | n/a | yes |
| loadbalancer\_type | Load Balancer type, e.g. 'application' or 'classic'. | string | n/a | yes |
| updating\_max\_batch | Maximum number of instances to update at once. | string | n/a | yes |
| updating\_min\_in\_service | Minimum number of instances in service during update. | string | n/a | yes |
| autoscale\_max | Maximum instances to launch. | string | n/a | yes |
| autoscale\_min | Minumum instances to launch. | string | n/a | yes |
| instance\_type | EC2 Instances type. | string | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| elastic\_beanstalk\_application\_name | Elastic Beanstalk Application name. |
| elastic\_beanstalk\_environment\_hostname | DNS hostname. |
| elastic\_beanstalk\_environment\_id | ID of the Elastic Beanstalk environment. |
| elastic\_beanstalk\_environment\_name | Elastic Beanstalk Environment Name. |
| elastic\_beanstalk\_environment\_security\_group\_id | Security group id. |
| elastic\_beanstalk\_environment\_elb\_zone\_id | ELB zone id. |
| elastic\_beanstalk\_environment\_application | The Elastic Beanstalk Application specified for this environment. |
| elastic\_beanstalk\_environment\_endpoint | TFully qualified DNS name for the environment. |
| elastic\_beanstalk\_environment\_load\_balancers | Elastic Load Balancers in use by this environment. |
