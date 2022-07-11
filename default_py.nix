with import <nixpkgs> { };

let
    setupEnv = python: (mkShell {
        name = "py${python.version} venv";

        buildInputs = with python.pkgs; [
            numpy
            scipy
            pandas
            tensorflow
            jupyterlab
            matplotlib
        ];
        venvDir = "venv${python.version}";
        postShellHook = ''
            # pip install
        '';
    });
in
{
    py3   = setupEnv python3;
    py36  = setupEnv python36;
    py37  = setupEnv python37;
    py38  = setupEnv python38;
    py39  = setupEnv python39;
    py310 = setupEnv python310;
    py311 = setupEnv python311;
}
