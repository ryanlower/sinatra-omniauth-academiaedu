require 'rubygems'
require 'bundler'

Bundler.require

$:.push File.expand_path('../app', __FILE__)

require 'app'

run App
