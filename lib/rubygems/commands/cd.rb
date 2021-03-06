require 'rubygems'
class Gem::Commands::CdCommand < Gem::Command
  def initialize
    super 'cd', "CD to the gem directory."
  end

  def arguments
    "GEM       gem to cd too"
  end

  def execute
    gem = options[:args].first
    raise Gem::CommandLineError, 'Usage: gem cd GEM' unless gem

    gem = `gem list | grep #{gem} | awk '{print $1}'`.gsub(/\n/, "")
    puts "found gem: #{gem}"
    Dir.chdir("#{Gem::Specification.find_by_name(gem).full_gem_path}")
    exec ENV['SHELL']
  end
end
