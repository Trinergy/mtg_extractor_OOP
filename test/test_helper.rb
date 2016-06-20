here = File.dirname(__FILE__)
require "minitest/autorun"
require "docsplit"
require "pdf-reader"
require "mimemagic"
require "fileutils"
require File.join(here, '..', 'lib', 'converter')

class Minitest::Test

  OUTPUT = './docs/converted'

  def clear_output
    FileUtils.rm_r(OUTPUT) if File.exists?(OUTPUT)
  end

  def teardown
    clear_output
  end
end