# %{ if <CONDITION> }<TRUEVAL>%{ endif }

variable "names" {
  default = ["adam", "bob", "craig", "daniel"]
}

# Remove final comma, but adds newlines
output "for_directive_index_if" {
  value = <<EOF
%{for i, name in var.names}
${name}%{if i < length(var.names) - 1}, %{endif}
%{endfor}
EOF
}

# Remove newlines
output "for_directive_index_if_strip" {
  value = <<EOF
%{~for i, name in var.names~}
${name}%{if i < length(var.names) - 1}, %{endif}
%{~endfor~}
EOF
}

# Add a trailing period after last value with "else"
# %{ if <CONDITION> }<TRUEVAL>%{ else }<FALSEVAL>%{ endif }
output "for_directive_if_else_strip" {
  value = <<EOF
%{~for i, name in var.names~}
${name}%{if i < length(var.names) - 1}, %{else}.%{endif}
%{~endfor~}
EOF
}
