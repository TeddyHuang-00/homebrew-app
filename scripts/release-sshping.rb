# Adpoted from https://github.com/oven-sh/homebrew-bun/blob/main/scripts/release.rb

require "net/http"
require "json"
require "digest"

version = ARGV[0]
if version == nil
  abort "Usage: release-sshping.rb [x.y.z]"
else
  version = version.gsub(/[a-z-]*/i, "")
end

puts "Releasing sshping on Homebrew: v#{version}"

url =
  "https://api.github.com/repos/TeddyHuang-00/sshping/releases/tags/v#{version}"
response = Net::HTTP.get_response(URI(url))
unless response.is_a?(Net::HTTPSuccess)
  abort "Did not find release: bun-v#{version} [status: #{response.code}]"
end

release = JSON.parse(response.body)
puts "Found release: #{release["name"]}"

url = "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
begin
  response = Net::HTTP.get_response(URI(url))
  url = response["location"]
end while response.is_a?(Net::HTTPRedirection)

unless response.is_a?(Net::HTTPSuccess)
  abort "Did not find source tarball [status: #{response.code}]"
end

sha256 = Digest::SHA256.hexdigest(response.body).strip
puts "Found source tarball [sha256: #{sha256}]"

formula = ""
File.open("Formula/sshping.rb", "r") do |file|
  file.each_line do |line|
    query = line.strip

    new_line =
      if query.start_with?("version")
        line.gsub(/"[0-9\.]{1,}"/, "\"#{version}\"")
      elsif query.start_with?("sha256")
        line.gsub(/"[A-Fa-f0-9]{1,}"/, "\"#{sha256}\"")
      else
        line
      end

    formula += new_line
  end
end

versioned_class = "class SshpingAT#{version.gsub(/\./, "")}"
versioned_formula = formula.gsub(/class Sshping/, versioned_class)
File.write("Formula/sshping@#{version}.rb", versioned_formula)
puts "Saved Formula/sshping@#{version}.rb"

File.write("Formula/sshping.rb", formula)
puts "Saved Formula/sshping.rb"

readme = File.read("README.md")
new_readme =
  readme.gsub(/sshping@[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}/, "sshping@#{version}")
File.write("README.md", new_readme)
puts "Saved README.md"

puts "Done"
