variable "web_linux_instance_count" {
  description = "web linux instance count"
  type = map(string)
  default = {
    "boba" = "feet",
    "skywalker" = "feet"
  }
}