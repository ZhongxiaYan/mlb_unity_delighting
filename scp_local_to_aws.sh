# scp from local to aws
# "bash scp_local_to_aws.sh local_source_path remote_dest_path"
# local_source_path: something like a/b/c/file.txt
# remote_dest_path: something like ~/output_dir/file.txt
scp -r -i berkeley_unity_delighting.pem $1 ubuntu@ec2-35-163-238-38.us-west-2.compute.amazonaws.com:$2
