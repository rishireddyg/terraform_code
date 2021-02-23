output "arn" {
    value = aws_vpc.vpc.arn
  
}
output "id" {
    value = aws_vpc.vpc.id
      
}
output "ciderblock" {
    value = aws_vpc.vpc.cidr_block
  
}
output "instance_arn" {
    value = aws_instance.instance.arn

    
}
output "instance_state" {
    value = aws_instance.instance.instance_state
  
}
output "instance_public_ip" {
    value = aws_instance.instance.public_ip
  
}
