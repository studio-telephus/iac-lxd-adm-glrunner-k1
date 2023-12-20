module "container_glrunner_k1" {
  source    = "github.com/studio-telephus/tel-iac-modules-lxd.git//instance?ref=develop"
  name      = "container-glrunner-k1"
  image     = "images:debian/bookworm"
  profiles  = ["limits", "fs-dir", "nw-adm"]
  autostart = true
  nic = {
    name = "eth0"
    properties = {
      nictype        = "bridged"
      parent         = "adm-network"
      "ipv4.address" = "10.0.10.130"
    }
  }
  mount_dirs = [
    "${path.cwd}/filesystem-shared-ca-certificates",
    "${path.cwd}/filesystem",
  ]
  exec = {
    enabled     = true
    entrypoint  = "/mnt/install.sh"
    environment = {
      RANDOM_STRING                  = "d4a101e8-e4c1-4382-a9db-c63bdac6b773"
      GITLAB_RUNNER_REGISTRATION_KEY = var.gitlab_runner_registration_key
      GIT_SA_USERNAME                = var.git_sa_username
      GIT_SA_TOKEN                   = var.git_sa_token
    }
  }
}