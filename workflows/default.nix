# GitHub Actions workflow generation
{ pkgs }:
let
  lib = import ./lib.nix;

  # Import workflow definitions
  workflows = {
    "update-vize" = import ./update-vize.nix { inherit lib; };
  };

  # Convert a workflow to YAML using yj
  workflowToYaml = name: workflow:
    pkgs.runCommand "${name}.yml" {
      nativeBuildInputs = [ pkgs.yj ];
      passAsFile = [ "json" ];
      json = builtins.toJSON workflow;
    } ''
      yj -jy < "$jsonPath" > "$out"
    '';

  # Generate all workflows into a directory
  allWorkflows = pkgs.runCommand "github-workflows" {} ''
    mkdir -p $out
    ${builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs (name: drv: "cp ${drv} $out/${name}.yml") workflowDerivations))}
  '';

  # Individual workflow derivations
  workflowDerivations = builtins.mapAttrs workflowToYaml workflows;
in
{
  inherit allWorkflows workflowDerivations workflows;

  # Default output is all workflows
  default = allWorkflows;
}
