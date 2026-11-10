class AgentEye < Formula
  desc "Find, sort and resume your coding-agent sessions: local index, terminal picker and board"
  homepage "https://maxipavlovic.github.io/agent-eye/"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.1/agent-eye-aarch64-apple-darwin.tar.xz"
      sha256 "e6765cd35ae7ae2860a4020b959bedfccb2d9ed3c6893107304687b1decf151f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.1/agent-eye-x86_64-apple-darwin.tar.xz"
      sha256 "3e386b370efa744103370ff825068a395beb121e26050c4276ee92d8a4fb02f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.1/agent-eye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc9d70031bcd2160ecb51296b1ca91446027051be607ecff27b071712349ea5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.1/agent-eye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e98a89071bcb03a13d4308b739a663a4784328175e5816c958c29282ec92bd9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      "agent-eye": [
        "eye",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      "agent-eye": [
        "eye",
      ],
    },
    "x86_64-apple-darwin":       {
      "agent-eye": [
        "eye",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      "agent-eye": [
        "eye",
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "agent-eye"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "agent-eye"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "agent-eye"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "agent-eye"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
