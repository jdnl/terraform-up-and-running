# homer.0, homer.1 homer.3
resource "aws_iam_user" "example" {
  count = 3
  name = "homer.${count.index}"
}

# homer, marge, lisa, bart
# Warning: In the state, the users are mapped to the index
#          if you delete marge at index 1, lisa becomes index 1
#          so marge would be renamed to lisa instead of marge being deleted
variable "user_names" {
  description = "IAM users with these names will be creaed"
  type = list(string)
  default = ["homer", "marge", "lisa", "bart"]
}

resource "aws_iam_user" "simpsons" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}

output "first_simpson_arn" {
  description = "The ARN For the first simpson in the list"
  value       = aws_iam_user.simpsons[0].arn
}

output "all_simpson_arns" {
  description = "The ARNs for all simpsons in the list"
  value       = aws_iam_user.simpsons[*].arn
}

#### Issues with count:
#    - cannot be used to loop over inline blocks (ex: trying to make dynamic tags)
#    - deleting a user from a list shifts everything to the left in an array (see "user_names" above)
