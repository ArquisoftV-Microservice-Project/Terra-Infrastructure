resource "helm_release" "nginx_ingress" {
  name       = "nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = var.namespace
  set = [{
    name  = "controller.service.type"
    value = "LoadBalancer"
  }]
}
