{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, happstack-server, mtl
      , random, reform, stdenv, text, utf8-string, cabal-install
      }:
      mkDerivation {
        pname = "reform-happstack";
        version = "0.2.5";
        src = ./.;
        libraryHaskellDepends = [
          base bytestring happstack-server mtl random reform text utf8-string cabal-install
        ];
        homepage = "http://www.happstack.com/";
        description = "Happstack support for reform";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
