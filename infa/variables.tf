# Replace default with your aws cli username ex.default
variable "cliProfile" {
  type    = string
  default = "acg_sand"
}

# Replace with name for tagging ex. deion.davis
variable "yourNameTag" {
  type    = string
  default = "deion.davis"
}

# name of your key file
variable "keyName" {
  type    = string
  default = "dedeKeyPair"
}

# Added your name -securityGroup is appended to the end of whatever you input
variable "securityGroupName" {
  type    = string
  default = "Dede"
}

#input your ip address so that you can ssh into the ec2 insance
variable "ipAddresses" {
  type    = list(any)
  default = ["184.57.36.105/32", "23.120.103.1/32"]
}
# input name of your userdatafile
variable "userData" {
  type    = string
  default = "jenkinsScript.sh"
}
/*
variable "keyContent" {
  type = string
  default = "${file("${path.cwd}/public_DD_KeyPair.txt")}"
}
*/
variable "targetRegion" {
  type    = string
  default = "us-east-1"
}

variable "tomcatData" {
  type    = string
  default = "ec2Deploy.sh"
}