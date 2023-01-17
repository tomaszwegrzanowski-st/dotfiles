require "pathname"

desc "Update git repositories"
task "git:update" do
  git_roots =  %W[. src].flat_map{|x| Pathname(x).glob("*/.git")}.map(&:parent)
  git_roots.each do |path|
    Dir.chdir(path) do
      system "git", "pull"
    end
  end
end
