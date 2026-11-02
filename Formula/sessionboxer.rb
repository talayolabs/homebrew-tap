class Sessionboxer < Formula
  desc "Coding agents (Claude Code, Codex, Cursor, Gemini, Copilot and 8 more) in boxes"
  homepage "https://sessionboxer.talayolabs.com"
  url "https://github.com/talayolabs/sessionboxer/releases/download/v1.7.0/sessionboxer-1.7.0.tgz"
  sha256 "7d07dd6b0b2201b0c6d427ea12ccef44e1915c16657bc7aa20d5a0a15b5d4598"
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
