class AgentEye < Formula
  desc "Find, sort, resume and finish your coding-agent sessions, even overnight: local index, terminal picker and board"
  homepage "https://maxipavlovic.github.io/agent-eye/"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.1/agent-eye-aarch64-apple-darwin.tar.xz"
      sha256 "cafcd20509c950e5dce33b40cbd1de9188c88f4f7fd2db567801a9a31163b220"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.1/agent-eye-x86_64-apple-darwin.tar.xz"
      sha256 "36a6fe8e4c7c13f276432a1f31121d08cbf962aa02650b6aa4a4a415466460f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.1/agent-eye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "96826ea8d6e6eb5e2561d9c18246b2d4baf75b91ca07e67063909cbac2d505a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.4.1/agent-eye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1cd5247408b66b5f1e0cd50c9e240990378a076678cdf282cdcc1b927245ca71"
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
