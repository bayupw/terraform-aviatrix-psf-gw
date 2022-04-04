output "psf_gateway" {
  description = "The created Aviatrix PSF gateway as an object with all of it's attributes."
  value       = aviatrix_gateway.this
  sensitive = true
}