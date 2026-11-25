class AgentEye < Formula
  desc "Find, sort, resume and finish your coding-agent sessions, even overnight: local index, terminal picker and board"
  homepage "https://maxipavlovic.github.io/agent-eye/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.0/agent-eye-aarch64-apple-darwin.tar.xz"
      sha256 "d0be9e1d11f139830344e556f868eb99995e6f2fdc938670a86ea638de3cc7b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.0/agent-eye-x86_64-apple-darwin.tar.xz"
      sha256 "368322fe260ceff789d63b08dd76ab615d9377c2a9a4b8b360ea5f56c18ec963"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.0/agent-eye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f4e3e0e1a378e410f676357c9addb490af27c935f88b681aa50426031173001"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.0/agent-eye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d501adaee369e44e3f4a55d0a2d0cd160aa10be5cb1f22592d09b3d7ebd52ddf"
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
