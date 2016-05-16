let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
  rustPlatform = pkgs.rustPlatform;
in rec {
  env = rustPlatform.buildRustPackage rec {
    name = "failure";
    src = ./.;
    sourceRoot = "${src}/sub_project";
    depsSha256 = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  };
}
