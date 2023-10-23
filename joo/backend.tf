terraform {
  backend "remote" {
    organization = "hcta-juiceb"

    workspaces {
      name = "github-actions-juiceb-workspace"
    }
  }
}
