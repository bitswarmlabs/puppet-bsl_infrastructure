class bsl_infrastructure::aws::resource::iam(
  $policy = '
{
   "Version": "2012-10-17",
   "Statement": [{
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    }
   ]
}',

) {

}