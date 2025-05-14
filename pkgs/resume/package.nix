{ pkgs, ... }:
pkgs.writeShellApplication rec {
  name = "resume";
  text = builtins.readFile ./${name}.bash;
  runtimeInputs = with pkgs; [
    coreutils # mktemp
    tree
    fd
    gh
    ruby_3_4
  ];
  runtimeEnv = {
    HELPER_PATH = "${./.}";
  };
  meta = {
    description = "Resume to track a running job in console";
  };
}
