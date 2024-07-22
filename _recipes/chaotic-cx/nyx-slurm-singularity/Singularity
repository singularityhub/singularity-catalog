Bootstrap: docker
From: nixpkgs/cachix-flakes:latest

%post
  stee() { command tee "$@" >/dev/null; }

  stee -a '/etc/nix/nix.conf' <<EOF
accept-flake-config = true
sandbox-fallback = false
system-features = big-parallel gccarch-x86-64-v3

keep-outputs = true
keep-derivations = true

max-substitution-jobs = 64
http-connections = 96
EOF

  nix run nixpkgs#gnused -- -i -e '/^build-users-group =/d' -e 's/max-jobs =.*/max-jobs = 8/g' /etc/nix/nix.conf

