{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "porymap";
  version = "6.3.1";

  src = pkgs.fetchFromGitHub {
    owner = "huderlem";
    repo = "porymap";
    rev = version;
    sha256 = "sha256-EG09aOgJrIe5X+e/SKcZn+mxkZ2N4mBmRxlEV3LYvgo=";
  };

  nativeBuildInputs = with pkgs; [
    git
    qt6.qtdeclarative
    qt6.qtcharts
    qt6.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    qt6.qtdeclarative
    qt6.qtcharts
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp porymap $out/bin/
    wrapQtApp $out/bin/porymap  # Wrap the binary to include Qt plugins
  '';

  buildPhase = ''
    qmake
    make -j$NIX_BUILD_CORES
  '';
}