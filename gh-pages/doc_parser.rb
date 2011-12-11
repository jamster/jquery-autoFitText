require 'rubygems'
require 'redcarpet'
require 'albino'
require 'nokogiri'
require 'pp'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
input = File.read(File.join(File.dirname(__FILE__), '..', "README.md"))
html =  markdown.render(input)
html.gsub!(/<code class="(.*?)">/, '<code class="\1" lang="\1">')
def syntax_highlighter(html)
  doc = Nokogiri::HTML(html)
  doc.search("//code[@lang]").each do |code|
    code.replace Albino.colorize(code.text.rstrip, code[:lang])
  end
  doc.to_s
end


puts syntax_highlighter(html)