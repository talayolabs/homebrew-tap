class Sessionboxer < Formula
  desc "Coding agents (Claude Code, Codex, Cursor, Devin) in Docker boxes"
  homepage "https://sessionboxer.talayolabs.com"
  url "https://github.com/talayolabs/sessionboxer/releases/download/v1.4.1/sessionboxer-1.4.1.tgz"
  sha256 "4ef5160e389cf20f577326a5c731bac0f3aae7b295b94bb361ab97c5214e0463"
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
