class Converter
  attr_reader :path

  @@output = './docs/converted'

  def self.call(paths = [])
    paths.each do |path|
      doc = new(path)
      doc.convert
      doc
    end
  end

  def initialize(path)
    @path = path
  end

  def convert
    if use_ocr?(path)
      Docsplit.extract_text(path, :ocr => true, :output => @@output)
    else
      Docsplit.extract_text(path, :ocr => false, :output => @@output)
    end
  end

  private
  #PDF Reader raw content returns only 1 line if the version is not compatible for direct text conversion
  def pdf_ver_ok?(file)
    reader = PDF::Reader.new(file)
    (reader.page(1).raw_content.lines.count != 1) ? true : false
  end

  def use_ocr?(file)
    ext = get_ext(file)
    ext == "pdf" ? File.open(file) { |io| !pdf_ver_ok?(io) } : true
  end

  def get_ext(file)
    #delete period b/c mimemagic returns subtype w/o it
    ext = File.extname(file).delete(".")
    ext = MimeMagic.by_magic(File.open(file)).subtype if ext.empty?
    ext
  end

end