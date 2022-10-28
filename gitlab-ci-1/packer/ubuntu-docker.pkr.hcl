# Define variables
variable "mv_folder_id" {
  type    = string
  default = ""
}

variable "mv_service_account_key_file" {
  type    = string
  default = ""
}

variable "mv_image_family" {
  type    = string
  default = ""
}

variable "mv_source_image_family" {
  type    = string
  default = ""
}

variable "mv_username" {
  type    = string
  default = ""
}

# Define functions
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


source "yandex" "image" {
  folder_id                = "${var.mv_folder_id}"
  image_family             = "${var.mv_image_family}"
  image_name               = "${var.mv_image_family}-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${path.root}/${var.mv_service_account_key_file}"
  source_image_family      = "${var.mv_source_image_family}"
  ssh_username             = "${var.mv_username}"
  use_ipv4_nat             = true
}

build {
  sources = ["source.yandex.image"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    pause_before     = "30s"
    inline = [
        #
        "echo debconf debconf/frontend select Noninteractive | sudo debconf-set-selections",
        # Official guide: https://docs.docker.com/engine/install/ubuntu/
        "sudo apt-get -y update",
        "sudo apt-get -y upgrade",
        "sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release",
        # Setup repo
        "sudo mkdir -p /etc/apt/keyrings",
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
        "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
        # Update repo
        "sudo apt-get -y update",
        # Install latest docker
        "sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin mc htop tmux",
        # Cleanup
        "sudo apt-get -y autoremove",
        "sudo apt-get -y clean"
    ]
  }
}
