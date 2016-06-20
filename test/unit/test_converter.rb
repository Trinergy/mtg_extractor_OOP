require_relative "./../test_helper"

class TestConverter < MiniTest::Test
  def setup
    @pdf_file = ["./docs/files/Filogix Mortgage Summary.pdf"]
    @ocr_file = ["./docs/files/MortgageSummary.jpg"]
  end

  def test_pdf_write_txt
    Converter.call(@pdf_file)
    assert_includes(Dir["#{OUTPUT}/*.txt"], "#{OUTPUT}/Filogix Mortgage Summary.txt")
  end

  def test_ocr_write_txt
    Converter.call(@ocr_file)
    assert_includes(Dir["#{OUTPUT}/*.txt"], "#{OUTPUT}/MortgageSummary.txt")
  end
end