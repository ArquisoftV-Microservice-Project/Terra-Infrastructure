resource "helm_release" "nginx_ingress_static_ip" {
  name       = "nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = var.namespace

  set = [
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
    },
    {
      name  = "controller.service.loadBalancerIP"
      value = var.static_ip
    },
    {
      name  = "controller.ingressClassResource.name"
      value = "nginx"
    }
  ]
}