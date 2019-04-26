let
  bootstrap = import <nixpkgs> { };

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  pkgs = import src { };

in
  pkgs.stdenv.mkDerivation  {
    name = "website";
    buildInputs = with pkgs; [
      git
      haskellPackages.purescript
      (haskellPackages.ghcWithPackages (self: [
        self.shake
      ]))
      nodejs
      nodePackages.bower
      openssh
    ];
  }

