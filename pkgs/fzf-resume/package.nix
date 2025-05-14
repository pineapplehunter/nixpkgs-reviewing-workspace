{ pkgs, ... }:
pkgs.writeShellApplication rec {
  name = "fzf-resume";
  text = builtins.readFile ./${name}.bash;
  runtimeInputs = with pkgs; [
    gh
    fzf
    (pkgs.callPackage ../resume/package.nix { })
  ];
  meta = {
    description = "Select a job and report the result on console";
  };
}
