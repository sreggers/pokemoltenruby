{ pkgs ? import <nixpkgs> {} }:

let
  porymap = pkgs.callPackage ./porymap.nix {};
  python = pkgs.python3.withPackages (
    python-pkgs: []
  );
in
  pkgs.mkShell {
    packages = [
      pkgs.pkgsCross.arm-embedded.stdenv.cc
      pkgs.git
      pkgs.pkg-config
      pkgs.libpng
      pkgs.go
      python
      porymap
    ];
}