provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

data "github_user" "owner" {
  username = "${var.github_user}"
}


resource "github_repository" "powershell" {
  name        = "${var.repo_name}"
  description = "${var.repo_description}"

  private = true
}

resource "null_resource" "pushtemplates" {
  provisioner "local-exec" {
    command = "md ./temp/;cd ./temp;git clone ${github_repository.powershell.ssh_clone_url};cd ./${var.repo_name};Copy-Item ../../templates/* -destination ./"
    interpreter = ["PowerShell", "-Command"]
  }
}

/*
resource "github_branch_protection" "foo_master" {
  repository = "foo"
  branch = "master"
  enforce_admins = true

  required_status_checks {
    strict = false
    contexts = ["ci/jenkins"]
  }

}
*/
