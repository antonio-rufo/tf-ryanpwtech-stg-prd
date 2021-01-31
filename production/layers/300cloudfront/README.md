# 300cloudfront

This layer creates the CloudFront distribution.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | The account ID you are building into. | string | n/a | yes |
| environment | The name of the environment, e.g. Production, Development, etc. | string | `"Production"` | no |
| region | The AWS region the state should reside in. | string | `"ap-southeast-2"` | yes |
| origin\_id | A unique identifier for the origin. | string | n/a | yes |
| acm\_certificate\_arn | SSL certificate ARN. The certificate must be present in AWS Certificate Manager.. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_arn | The ARN (Amazon Resource Name) for the distribution. |
| cloudfront\_id | The identifier for the distribution. |
| cloudfront\_domain\_name | The domain name corresponding to the distribution. |
