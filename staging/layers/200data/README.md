# 100data

This layer creates the RDS and S3 resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | The account ID you are building into. | string | n/a | yes |
| environment | The name of the environment, e.g. Production, Development, etc. | string | `"Development"` | no |
| region | The AWS region the state should reside in. | string | `"ap-southeast-2"` | yes |
| db\_identifier | The name of the RDS instance. | string | n/a | yes |
| db\_name | The name of the database to create when the DB instance is created. | string | n/a | yes |
| db\_username | Username for the master DB user. | string | n/a | yes |
| db\_password | Password for the master DB user. | string | n/a | yes |
| db\_instance\_class | The instance type of the RDS instance. | string | n/a | yes |
| db\_engine | The database engine to use. | string | n/a | yes |
| db\_engine\_version | The engine version to use. | string | n/a | yes |
| db\_allocated\_storage | The amount of allocated storage. | string | n/a | yes |
| bucket1\_name | Name of the first S3 bucket to be created. | string | n/a | yes |
| force\_destroy\_bucket1 | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | string | n/a | yes |
| bucket2\_name | Name of the first S3 bucket to be created. | string | n/a | yes |
| force\_destroy\_bucket2 | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| rds\_address | The hostname of the RDS instance. |
| rds\_sg\_id | The hostname of the RDS instance. |
| bucket1\_id | The Id of the first bucket. |
| bucket2\_id | The Id of the second bucket. |
