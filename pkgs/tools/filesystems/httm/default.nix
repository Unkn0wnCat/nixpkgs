{ lib
, fetchFromGitHub
, rustPlatform
, installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "httm";
  version = "0.17.7";

  src = fetchFromGitHub {
    owner = "kimono-koans";
    repo = pname;
    rev = version;
    sha256 = "sha256-ejDHQoL7YCcBQdS4zcavrHdyFoTIV0/FZPkaT15aFgo=";
  };

  cargoSha256 = "sha256-Z5v/Jke50T8BI7nO0FVZHFFbOyN4PhQnrugrz4mZmdw=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage httm.1

    installShellCompletion --cmd httm \
      --zsh scripts/httm-key-bindings.zsh
  '';

  meta = with lib; {
    description = "Interactive, file-level Time Machine-like tool for ZFS/btrfs";
    homepage = "https://github.com/kimono-koans/httm";
    license = licenses.mpl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ wyndon ];
  };
}
