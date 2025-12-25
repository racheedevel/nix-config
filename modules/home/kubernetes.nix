{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    k9s
    stern
    kubectx
    kustomize
    talosctl
    cilium-cli
    fluxcd
  ];

  home.sessionVariables = {
    KUBECONFIG = config.home.homeDirectory + "/.kube/config";
    TALOSCONFIG = config.home.homeDirectory + "/.talos/talosconfig";
  };

  xdg.configFile."k9s/config.yaml".text = ''
    k9s:
        refreshRate: 2
        maxConnRetry: 5
        enableMouse: true
        headless: false
        ui:
            enableMouse: true
            skin: dracula
  '';
}
