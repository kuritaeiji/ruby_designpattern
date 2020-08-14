class Report
  def initialize(title, text)
    @title = title
    @text = text
  end

  def output_report
    output_start
    output_header_start
    output_title
    output_body_start
    output_body
    output_body_end
    output_header_end
  end

  def output_start
  end

  def output_header_start
  end

  def output_title
    raise(NoMethodError.new('add output_title_method to subclass'))
  end

  def output_body_start
  end

  def output_body
    raise(NoMethodError.new('add output_body_method to subclass'))
  end

  def output_body_end
  end

  def output_header_end
  end
end

class HtmlReport < Report
  def initialize(title, text)
    @title = title
    @text = text
  end

  def output_start
    puts('<html>')
  end

  def output_header_start
    puts('<header>')
  end

  def output_title
    puts("<title>#{@title}</title>")
  end

  def output_header_end
    puts('</header>')
  end

  def output_body_start
    puts('<body>')
  end

  def output_body
    @text.each do |line|
      puts("<p>#{line}</p>")
    end
  end

  def output_body_end
    puts('</body>')
  end

  def output_header_end
    puts('</html>')
  end
end

class PlainTextReport < Report
  def output_title
    puts("****#{@title}****")
  end

  def output_body
    @text.each do |line|
      puts(line)
    end
  end
end

html_report = HtmlReport.new('タイトル', ['テキスト', 'テキスト'])
html_report.output_report

plain_text_reprt = PlainTextReport.new('タイトル', ['テキスト', 'テキスト'])
plain_text_reprt.output_report
