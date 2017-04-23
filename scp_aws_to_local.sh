# scp from aws to local
# "bash scp_aws_to_local.sh remote_source_path local_dest_path"
# remote_source_path: something like ~/c/file.txt
# local_dest_path: something like a/b/output_dir/file.txt
scp -i berkeley_unity_delighting.pem ubuntu@ec2-52-38-158-227.us-west-2.compute.amazonaws.com:$1 $2
