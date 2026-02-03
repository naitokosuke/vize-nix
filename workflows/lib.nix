# Reusable components for GitHub Actions workflows
{
  # Action versions
  actions = {
    checkout = "actions/checkout@v4";
    installNix = "cachix/install-nix-action@v31";
    magicNixCache = "DeterminateSystems/magic-nix-cache-action@main";
    cachix = "cachix/cachix-action@v16";
    createPullRequest = "peter-evans/create-pull-request@v6";
  };

  # Runner images
  runners = {
    ubuntuLatest = "ubuntu-latest";
    macosLatest = "macos-latest";
  };

  # Common steps
  steps = {
    checkout = {
      uses = "actions/checkout@v4";
    };

    installNix = {
      name = "Install Nix";
      uses = "cachix/install-nix-action@v31";
    };

    magicNixCache = {
      name = "Setup Magic Nix Cache";
      uses = "DeterminateSystems/magic-nix-cache-action@main";
    };

    setupCachix = { name, authTokenSecret ? "CACHIX_AUTH_TOKEN" }: {
      name = "Setup Cachix";
      uses = "cachix/cachix-action@v16";
      "with" = {
        inherit name;
        authToken = "\${{ secrets.${authTokenSecret} }}";
      };
    };
  };

  # Trigger helpers
  triggers = {
    schedule = crons: {
      schedule = map (cron: { inherit cron; }) crons;
    };

    workflowDispatch = {
      workflow_dispatch = null;
    };

    push = { branches ? null, tags ? null, paths ? null }:
      let
        base = { };
        withBranches = if branches != null then base // { inherit branches; } else base;
        withTags = if tags != null then withBranches // { inherit tags; } else withBranches;
        withPaths = if paths != null then withTags // { inherit paths; } else withTags;
      in
      { push = withPaths; };

    pullRequest = { branches ? null, paths ? null }:
      let
        base = { };
        withBranches = if branches != null then base // { inherit branches; } else base;
        withPaths = if paths != null then withBranches // { inherit paths; } else withBranches;
      in
      { pull_request = withPaths; };
  };

  # Permissions
  permissions = {
    contents = {
      read = "read";
      write = "write";
    };
    pullRequests = {
      read = "read";
      write = "write";
    };
  };
}
