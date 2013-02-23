# helper.rb
# Chun Yang

specdir = File.dirname __FILE__
$:.unshift File.expand_path specdir unless
  $:.include?(specdir) || $:.include?(File.expand_path specdir)

libdir = File.join File.dirname(File.dirname(__FILE__)), 'lib'
$:.unshift File.expand_path libdir unless
  $:.include?(libdir) || $:.include?(File.expand_path libdir)
