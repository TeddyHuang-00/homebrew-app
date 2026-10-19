# frozen_string_literal: true

# Adpoted from https://github.com/oven-sh/homebrew-bun/blob/main/scripts/release.rb

require "net/http"
require "json"
require "digest"

package = ARGV[0]
version = ARGV[1]
if package.nil?
  abort "Usage: release.rb [package] [x.y.z]"
end
if version.nil?
  abort "Usage: release.rb [package] [x.y.z]"
else
  version = version.gsub(/[a-z-]*/i, "")
end

puts "Releasing #{package} on Homebrew: v#{version}"

url =
  "https://api.github.com/repos/TeddyHuang-00/#{package}/releases/tags/v#{version}"
response = Net::HTTP.get_response(URI(url))
abort "Did not find release: [status: #{response.code}]" unless response.is_a?(Net::HTTPSuccess)

release = JSON.parse(response.body)
puts "Found release: #{release["name"]}"

url = "https://github.com/TeddyHuang-00/#{package}/archive/refs/tags/v#{version}.tar.gz"
loop do
  response = Net::HTTP.get_response(URI(url))
  url = response["location"]
  break unless response.is_a?(Net::HTTPRedirection)
end

abort "Did not find tarball [status: #{response.code}]" unless response.is_a?(Net::HTTPSuccess)

sha256 = Digest::SHA256.hexdigest(response.body).strip
puts "Found tarball [sha256: #{sha256}]"

formula = ""
File.open("Formula/#{package}.rb", "r") do |file|
  file.each_line do |line|
    new_line =
      if line.match?(/^  version /)
        line.gsub(/"[0-9.]{1,}"/, "\"#{version}\"")
      elsif line.match?(/^  sha256 /)
        line.gsub(/"[A-Fa-f0-9]{1,}"/, "\"#{sha256}\"")
      elsif line.match?(/^  url /)
        line.gsub(/v[0-9]+(\.[0-9]+)*\.tar\.gz/, "v#{version}.tar.gz")
      else
        line
      end

    formula += new_line
  end
end

File.write("Formula/#{package}.rb", formula)
puts "Saved Formula/#{package}.rb"

# readme = File.read("README.md")
# new_readme =
#   readme.gsub(/#{package}@[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}/, "#{package}@#{version}")
# File.write("README.md", new_readme)
# puts "Saved README.md"

puts "Done"
