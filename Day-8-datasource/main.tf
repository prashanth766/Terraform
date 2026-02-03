
   ####### with data source ###########
data "aws_subnet" "subnet1" {
    filter {
      name = "tag=Name"
      values = [ subnet1 ]
    }
  
}
data "aws_subnet" "subnet2" {
    filter {
      name = "tag:name"
      values = [ subnet2 ]
    }
    
  
}
resource "aws_db_subnet_group" "sub-prp" {
    name = "customsubnetgrup"
    subnet_ids = [ data.aws_subnet.subnet1,data.aws_subnet.subnet2 ]
    tags = {
      Name ="my subnet group"
    }
  
}