resource "aws_route_table_association" "rt_association_public_1a" {
  route_table_id = aws_route_table.custom-rt.id
  subnet_id = aws_subnet.financial-management-public-us-east-1a.id
}

resource "aws_route_table_association" "rt_association_public_1b" {
  route_table_id = aws_route_table.custom-rt.id
  subnet_id = aws_subnet.financial-management-public-us-east-1b.id
}