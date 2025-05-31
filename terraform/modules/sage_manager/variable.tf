variable "app_name" {
  description = "Name of the SageMaker app"
  type        = string
}

variable "app_type" {
  description = "Type of the SageMaker app (e.g., JupyterServer, TensorBoard)"
  type        = string
  default = "TensorBoard"

}
