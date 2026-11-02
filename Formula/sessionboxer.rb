class Sessionboxer < Formula
  desc "Coding agents (Claude Code, Codex, Cursor, Gemini, Copilot and 8 more) in boxes"
  homepage "https://sessionboxer.talayolabs.com"
  url "https://github.com/talayolabs/sessionboxer/releases/download/v1.8.0/sessionboxer-1.8.0.tgz"
  sha256 "16ca9e583db9d3a273a52f59627b51accc13bca1970d32f4df82ba69ef6a2b07"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Keep only the prebuilt native modules for this OS and CPU.
    native = "#{OS.kernel_name.downcase}-#{Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch}"
    (libexec/"lib/node_modules/sessionboxer/node_modules").glob("*/prebuilds/*").each do |prebuilt|
      rm_r(prebuilt) if prebuilt.basename(".node").to_s != native
    end
  end

  def caveats
    <<~EOS
      Sessionboxer runs each Session in a Docker container, so a Docker engine
      (Docker Desktop, OrbStack, Colima) must be installed and running:
        https://sessionboxer.talayolabs.com/#docker

      Start it with
        sessionboxer serve
      and open the login link it prints (or `sessionboxer service install`
      to keep it running in the background).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessionboxer --version")
    assert_match "sessionboxer serve", shell_output("#{bin}/sessionboxer --help")
  end
end
