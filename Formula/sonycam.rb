class Sonycam < Formula
  desc "Agent-friendly CLI and daemon for Sony cameras (Camera Remote SDK)"
  homepage "https://github.com/talayolabs/sonycam"
  url "https://github.com/talayolabs/sonycam/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "4e048a7b50bf6aefa40bdf175aeff337602d4907e9c8b9d574b775cec6ea21a7"
  head "https://github.com/talayolabs/sonycam.git", branch: "main"

  depends_on "cmake" => :build

  def install
    args = std_cmake_args
    if ENV["SONY_SDK_DIR"]
      args << "-DSONY_SDK_DIR=#{ENV["SONY_SDK_DIR"]}"
    end
    system "cmake", "-B", "build", *args
    system "cmake", "--build", "build"
    bin.install "build/sonycam", "build/sonycamd"
  end

  def caveats
    <<~EOS
      This build includes the fake camera backend only. To control a real
      camera, download the Sony Camera Remote SDK (license-gated, cannot be
      redistributed) from
        https://support.d-imaging.sony.co.jp/app/sdk/en/index.html
      and reinstall with the SDK path exported:
        SONY_SDK_DIR=/path/to/CrSDK brew reinstall --build-from-source sonycam
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/sonycam --help")
    ENV["SONYCAM_SOCKET"] = (testpath/"test.sock").to_s
    assert_match "iso", shell_output("#{bin}/sonycam --fake props")
    system bin/"sonycam", "--fake", "daemon", "stop"
  end
end
