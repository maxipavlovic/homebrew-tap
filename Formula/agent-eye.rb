class AgentEye < Formula
  desc "Find, sort and resume your coding-agent sessions: local index, terminal picker and board"
  homepage "https://maxipavlovic.github.io/agent-eye/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.0/agent-eye-aarch64-apple-darwin.tar.xz"
      sha256 "a1b409f96282cb1ec588d5c7003e15a2c3a3f7a01b1f078220168e9713f3234f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.0/agent-eye-x86_64-apple-darwin.tar.xz"
      sha256 "3432216c592b01983f541b4e94bceee6f57454b96f680e52612635b1c1a2cb87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.0/agent-eye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa6d2d209f793aad4ef8a07767cfbd8bc1a1b19043d917b97d41cbeac0044a07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.1.0/agent-eye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e99e43f2d24d6052806ab3159215ecb840219866b9e79489e89884cc85085bd8"
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
