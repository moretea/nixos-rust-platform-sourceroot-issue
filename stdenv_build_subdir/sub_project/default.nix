let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
in rec {
  env = stdenv.mkDerivation rec {
    buildInputs = with pkgs; [automake autoconf];
    name = "failure";
    src = ./../.;
    sourceRoot = "${src}/sub_project";
    dontMakeSourcesWritable = 1;
  };
}
