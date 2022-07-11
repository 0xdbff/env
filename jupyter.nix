with import <nixpkgs> { };

let
    jupyter = import (builtins.fetchGit {
        url = https://github.com/tweag/jupyterWith;
        # Example working revision, check out the latest one.
        # rev = "c9a780f2c5b0533ca16582073f474482f197d449";
    }) {};

     Python = jupyter.kernels.iPythonWith {
        name = "3.9";
        packages = p: with p; [ 
            pandas
            scipy
            matplotlib
            numpy
            tensorflow
        ];
        #python3 = pkgs.python310Packages;
        #ignoreCollisions = false;
    };

    Rust = jupyter.kernels.rustWith {
        name = "";
        # Extra packages that can be used by the kernel and imported crates
        packages = with pkgs; [ openssl pkgconfig ];
    };

    Js = jupyter.kernels.iJavascript {
        name = "";
    };

    Nix = jupyter.kernels.iNixKernel {
        name = "";
    };

    R= jupyter.kernels.iRWith {
        name = "";
        # Libraries to be available to the kernel.
        packages = p: with p; [ p.ggplot2 ];
        # Optional definition of `rPackages` to be used.
        # Useful for overlaying packages.
        rPackages = pkgs.rPackages;
    };

    Ruby = jupyter.kernels.iRubyWith {
        name = "";
        # Libraries to be available to the kernel.
        packages = p: with p; [ ];
    };

    Bash = jupyter.kernels.bashKernel {
        name = "";
    };

    Go = jupyter.kernels.gophernotes {
        name = "";
    };

    Ansi = jupyter.kernels.ansibleKernel {
        name = "";
    };

    Haskell = jupyter.kernels.iHaskellWith {
        name = "";
        packages = p: with p; [ hvega formatting ];
    };

    jupyterEnvironment = jupyter.jupyterlabWith {
        kernels = [ Python Rust Js Nix Haskell R Ruby Bash Go Ansi];
        ## The directory is generated here
        directory = ./.jupyterlab;
    };
in
    jupyterEnvironment.env
