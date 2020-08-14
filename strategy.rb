class Report
  attr_accessor(:title, :text, :formatter)
  
  def initialize(title, text, formatter)
    self.title = title
    self.text = text
    self.formatter = formatter
  end

  def output_report
    formatter.output_report(self)
  end
end

class HtmlFormatter
  def output_report(context)
    puts('<html>')
    puts('<header>')
    puts("<title>#{context.title}</title>")
    puts('</header>')
    puts('<body>')
    context.text.each do |line|
      puts("<p>#{line}</p>")
    end
    puts('</body>')
    puts('</html>')
  end
end

class PlainTextFormatter
  def output_report(context)
    puts("*****#{cotext.title}****")
    context.text.each do |line|
      puts(line)
    end
  end
end

html_report = Report.new('title', ['text'], HtmlFormatter.new)
html_report.output_report

plain_text_report = Report.new('title', ['text'], PlainTextFormatter.new)
plain_text_report.output_report