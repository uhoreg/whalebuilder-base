#!/usr/bin/ruby

require 'optparse'
require 'erb'

SHARE_DIR = "/usr/share/whalebuilder"

class Templater
  def write (filename)
    b = binding
    result = ERB.new(File.read(File.join(SHARE_DIR, self.class::TEMPLATE_FILE)), nil, "-").result b
    File.open(filename, "w") do |file|
      file.write result
    end
  end
end

class Dockerfile < Templater
  TEMPLATE_FILE = "Dockerfile.base.erb"
  def initialize (options)
    @distribution = options[:distribution]
    @tag = options[:release]
    @maintainer = options[:maintainer]
    @repository = options[:repository]
    @hooks = []
  end
end

options = {}
options[:distribution] = "debian"
options[:release] = "stable"
options[:repository] = nil
options[:maintainer] = "Nobody <nobody@example.com>"

opt_parser = OptionParser.new do |opts|
  opts.banner = "Create a Dockerfile for whalebuilder
Usage: #{opts.program_name} [options] <outputdir>"
  opts.separator ""
  opts.separator "Options:"
  opts.on "-d", "--distribution NAME", "distribution name.  This should match a Docker image name (default: debian)" do |v|
    options[:distribution] = v
  end
  opts.on "-r", "--release NAME", "release name.  This should match a tag for the base Docker image (default: stable)" do |v|
    options[:release] = v
  end
  opts.on "--repository URL", "apt repository to use (default: http://httpredir.debian.org/debian)" do |v|
    options[:repository] = v
  end
  opts.on "--maintainer NAME", "maintainer (default: Nobody <nobody@example.com>)" do |v|
    options[:maintainer] = v
  end
end
opt_parser.parse! ARGV

if ARGV.length == 0
  opt_parser.abort "Error: no output directory specified"
end

Dockerfile.new(options).write(File.join(ARGV.shift, "Dockerfile"))
