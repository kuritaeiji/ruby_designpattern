class Report
  attr_accessor(:title, :text, :formatter)

  def initialize(title, text, formatter)
    self.title = title
    self.text = text
    self.formatter = formatter
  end

  def output_report
    formatter.call(self)
  end
end

HTML_FORMATTER = -> (context) do
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

PLAIN_TEXT_FORMATTER = -> (context) do
  puts("*****#{cotext.title}****")
  context.text.each do |line|
    puts(line)
  end
end

html_report = Report.new('title', ['text'], HTML_FORMATTER)
html_report.output_report