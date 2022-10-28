# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "mv_folder_id" {
  type    = string
  default = ""
}

variable "mv_service_account_key_file" {
  type    = string
  default = ""
}

variable "mv_source_image_family" {
  type    = string
  default = ""
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "yandex" "autogenerated_1" {
  folder_id                = "${var.mv_folder_id}"
  image_family             = "${var.mv_image_family}"
  image_name               = "${var.mv_image_family}-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${var.mv_service_account_key_file}"
  source_image_family      = "${var.mv_source_image_family}"
  ssh_username             = "ubuntu"
  use_ipv4_nat             = "true"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.yandex.autogenerated_1"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo {{ .Path }}"
    pause_before     = "1m0s"
    script           = "scripts/install_docker.sh"
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo {{ .Path }}"
    script           = "scripts/cleanup.sh"
  }

}
