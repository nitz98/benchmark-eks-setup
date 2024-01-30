ssh_sg_name                  = "ssh_sec_group"
jenkins_sg_name = "jenkins_sg_group"
ingress_with_cidr_blocks_ssh = [{ from_port = 22, to_port = 22, protocol = "tcp", description = "For Ssh from local", cidr_blocks = "103.51.136.95/32" }, { from_port = 22, to_port = 22, protocol = "tcp", description = "For Ssh from local", cidr_blocks = "103.51.136.96/32" }]
ingress_with_cidr_blocks_jenkins = [{ from_port = 8080, to_port = 8080, protocol = "tcp", description = "Jenkins-port", cidr_blocks = "103.51.136.95/32" }]