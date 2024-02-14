require "pathname"
require "pry"

def git_roots
  @git_roots ||= %W[. src].flat_map{|x| Pathname(x).glob("*/.git")}.map(&:parent)
end

def doc_roots
  %W[. bin Desktop Documents Downloads].map{|x| Pathname(x)}
end

def git_clean?(path)
  Dir.chdir(path) do
    `git status --porcelain`.empty? and `git branch --show-current`.chomp =~ /\A(master|main)\z/
  end
end

desc "Update git repositories"
task "git:update" do
  git_roots.each do |path|
    Dir.chdir(path) do
      system "git", "pull"
    end
  end
end

desc "Update everything"
task "update" => "git:update"

desc "Print list of items that need doing"
task "status" do
  inbox = []
  git_roots.each do |path|
    next if git_clean?(path)
    inbox << path
  end

  doc_roots.flat_map(&:children).each do |path|
    next if path.symlink?
    case path.to_s
    when *%W[
      .asdf
      .aws
      .bundle
      .cache
      .cargo
      .CFUserTextEncoding
      .clickhouse-client-history
      .cocoapods
      .config
      .docker
      .DS_Store
      .gem
      .gnupg
      .kube
      .lesshst
      .local
      .mongodb
      .node_repl_history
      .npm
      .osquery
      .proxyman
      .proxyman-data
      .python_history
      .rd
      .ssh
      .swiftpm
      .tool-versions
      .Trash
      .tsh
      .vim
      .viminfo
      .vscode
      .vscode-cli
      .wget-hsts
      .yarn
      .yarnrc
      .zcompdump
      .zsh_history
      Applications
      Library
      Movies
      Music
      Pictures
      Public
      ]
      # irrelevant
      next
    when *%W[bin Desktop Documents Downloads src]
      # doc/git roots
      next
    when *git_roots.map(&:to_s)
      next
    end
    inbox << path
  end

  puts *inbox.sort
end

desc "Production tunnel"
task "tunnel" do
  Dir.chdir("adblock-web") do
    sh "./bin/start-production-tunnel"
  end
end

desc "Prevent laptop sleep"
task "cafe" do
  sh "caffeinate -d"
end

desc "Start docker"
task "docker" do
  Dir.chdir("adblock-web") do
    sh "docker-compose up"
  end
end
