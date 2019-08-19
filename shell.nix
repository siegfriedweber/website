let
  bootstrap = import <nixpkgs> { };

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  pkgs = import src { };

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "a85ee748097fb70caaa953cb15bd18f81e4f85a1";
    sha256 = "16xmsgjvwwxsf05n5wwpa63vjhr5y3bplkzhc5hcv99ns9x76m8x";
  }) {
    inherit pkgs;
  };

in
  pkgs.mkShell {
    buildInputs = [
      easy-ps.purs
      easy-ps.spago
      pkgs.git
      (pkgs.haskellPackages.ghcWithPackages (self: [
        self.hjsmin
        self.shake
      ]))
      pkgs.nodejs
      pkgs.nodePackages.bower
      pkgs.openssh
    ];
  }

