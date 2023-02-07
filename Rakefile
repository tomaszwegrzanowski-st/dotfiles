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
    `git status --porcelain`.empty? and `git branch --show-current`.chomp == "master"
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
      .CFUserTextEncoding
      .DS_Store
      .Trash
      .asdf
      .aws
      .bundle
      .cache
      .cargo
      .config
      .docker
      .gem
      .gnupg
      .kube
      .lesshst
      .local
      .mongodb
      .node_repl_history
      .osquery
      .python_history
      .rd
      .ssh
      .tool-versions
      .tsh
      .vim
      .viminfo
      .vscode
      .wget-hsts
      .yarn
      .yarnrc
      .zcompdump
      .zsh_history
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
