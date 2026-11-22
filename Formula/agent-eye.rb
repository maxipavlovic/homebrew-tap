class AgentEye < Formula
  desc "Find, sort, resume and finish your coding-agent sessions, even overnight: local index, terminal picker and board"
  homepage "https://maxipavlovic.github.io/agent-eye/"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.3.1/agent-eye-aarch64-apple-darwin.tar.xz"
      sha256 "07b799695020a85de6ebb0f67bd5407c57da803e69bb5237904178c54b970b21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.3.1/agent-eye-x86_64-apple-darwin.tar.xz"
      sha256 "4a20cb7ebd5c8f47a066ed33e517b4f6d0e351221652a37ef5caf4c17e27a5f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.3.1/agent-eye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9752bc22e12868f5c901ead028285e16f9e52155c4241c58752210c4d97dfe53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maxipavlovic/agent-eye/releases/download/v0.3.1/agent-eye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d2ff154e5297ff97ac4a77c1a74b615e2f9867962c96d44ca0d93dfc2ed1e52"
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
