#!/usr/bin/ruby

require 'rubygems'
require 'json'


if ENV['RD_CONFIG_MCO_COMMAND_LINE'] == nil
   $stderr.puts "no RD_CONFIG_MCO_COMMAND_LINE environment provided, check mco_command_line plugin configuration property"
   exit 1
end


cmdLine=ENV['RD_CONFIG_MCO_COMMAND_LINE']
f = IO.popen(cmdLine)
json=f.readlines.to_s
f.close

cmdLineResult=$?

if cmdLineResult != 0 
   $stderr.puts "mco command line  #{cmdLine} failed (result code:  #{cmdLineResult})"
   exit 1
end


begin 
   inv = JSON.parse(json)
   raise "JSON parse error" if inv.nil?
rescue
   $stderr.puts "Caught JSON parsing exception from command line: #{cmdLine}"
   exit 1
end
 
if inv.length == 0
   $stderr.puts "command line: ${cmdLine} produced no data"
   exit 1
end

print "<project>\n"

$i = 0;
while $i < inv.length do

   invEntry=inv[$i];
   sender = invEntry["sender"]
   architecture = invEntry["data"]["facts"]["architecture"]
   osfamily = invEntry["data"]["facts"]["osfamily"]
   kernel = invEntry["data"]["facts"]["kernel"]
   kernelrelease = invEntry["data"]["facts"]["kernelrelease"]
   tags=invEntry["data"]["classes"].join(",")
   username=invEntry["data"]["facts"]["id"]
   operatingsystemrelease=invEntry["data"]["facts"]["operatingsystemrelease"]

   if username == ""
      username="root"
   end

   print "   <node name=\"#{sender}\" description=\"#{osfamily} #{operatingsystemrelease}\" tags=\"#{tags}\" hostname=\"#{sender}\"  osArch=\"#{architecture}\" osFamily=\"#{osfamily}\" osName=\"#{kernel}\" osVersion=\"#{kernelrelease}\" username=\"#{username}\"/>\n"

   $i += 1;
end

print "</project>\n"
