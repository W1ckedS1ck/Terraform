
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

provider "google" {
  credentials = file("GCP.json")
  project = "myproject-334822"
  region = "us-central1"
  zone = "us-central1-a"
}
resource "google_compute_instance" "Instance-1" {
  name = "gcp-by-terraform"
  machine_type = "g1-small"
  boot_disk {
    initialize_params {
        image = "ubuntu-minimal-2004-lts"
    }
  }
  network_interface {
    network = "default"
  }
}