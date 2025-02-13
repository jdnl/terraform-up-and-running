# For each appears to be generally better than using count
# - loop over lists, sets, and maps (but only sets and maps on resources)
# - works in inline blocks for resources (unlike count)

# toset() converts list -> set
resource "aws_iam_user" "mario_bros" {
  for_each = toset(var.mario_characters)
  name = each.value
}

# Can delete users from the list without impacting other users now (no shift-left from using count)
variable "mario_characters" {
  description = "IAM users to be created"
  type = list(string)
  default = ["Mario", "Luigi", "Peach", "Bowser"]
}

output "all_mario_bros_arns" {
  value = values(aws_iam_user.mario_bros)[*].arn
}

# Note: order is not guaranteed to be "Mario" because its a map under the hood
output "first_unordered_mario_bros_arn" {
  value = values(aws_iam_user.mario_bros)[0].arn
}

# Mapping
# for <ITEM> in <LIST> : <OUTPUT>
output "upper_mario_bros_names" {
  value = [for name in var.mario_characters : upper(name)]
}

# Filtering
# for <ITEM> in <LIST> : <OUTPUT> if <CONDITION_MET>
output "filtered_upper_mario_bros_names" {
  value = [for name in var.mario_characters : upper(name) if length(name) < 6]
}

variable "paw_patrol_jobs" {
  description = "A map of paw patrol characters and their jobs"
  type        = map(string)
  default     = {
    marshall = "fire dog"
    chase    = "police dog"
    sky      = "pilot dog"
    zuma     = "water dog"
  }
}
output "paw_patrol_bios_list" {
  value = [for pup, job in var.paw_patrol_jobs : "${upper(pup)} is a ${job}"]
}

output "paw_patrol_bios_map" {
  value = {for pup, job in var.paw_patrol_jobs : upper(pup) => job}
}

# Looping over strings with %{}
# Might be useful for filling user_data or config files
# Doesn't seem like it would be used frequently
variable "some_names" {
  description = "Names to print"
  type        = list(string)
  default     = ["adam", "bob", "craig"]
}

output "for_directive" {
  value = "%{ for name in var.some_names }${name}, %{ endfor }"
}

output "for_directive_with_index" {
  value = "%{ for i, name in var.some_names }Index: ${i} Name: ${name}, %{ endfor }"
}
