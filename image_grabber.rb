require 'rubygems'
require 'yajl/json_gem'
require 'pp'

class Image
  REGEX = /(.*?)(\._V1\._S)(X|Y)([0-9]{2})_CR([0-9]+),([0-9]+),([0-9]+),([0-9]+)(.*?)$/
  
  attr_accessor :url, :size, :upper_left, :bottom_right
  
  def initialize(url)
    @url = url
    REGEX =~ url
    @start = $1
    @ver = $2
    @xy = $3
    @size = $4
    @upper_left = [$5,$6]
    @bottom_right = [$7, $8]
    @remainder = $9
    puts @remainder
  end
  
  def image_url_magnified(scale=1)
    return nil if @url.nil?
    size = @size.to_i * scale
    upper_left = @upper_left.map{|x| (x.to_i * scale).to_s}.join(",")
    bottom_right = @bottom_right.map{|x| (x.to_i * scale).to_s}.join(",")
    "#{@start}#{@ver}#{@xy}#{size}_CR#{upper_left},#{bottom_right}#{@remainder}"
  end

end



dir = File.join(File.dirname(__FILE__), 'img')
JSON.parse(DATA.read)['characters'].map{|x| [Image.new(x["pic"]).image_url_magnified(3), x['actor']] }.each do |img, actor|

  img = "http://i.media-imdb.com/images/SFd8baa66b3dedf9a5e6ce2be3bbd48ac7/nopicture/medium/name.png" unless img
  command = %(curl "#{img}" > "#{dir}/#{actor}.jpg")
  puts command
  `#{command}`
end

__END__
{
    "characters": [{
        "actor": "Cary Elwes",
        "bio": "Westley began as a farm boy on Buttercup's farm. He and Buttercup fell in love and he left to find his fortune across the sea so he could marry Buttercup. He was killed on the high seas by the Dread Pirate Roberts. This crushes Buttercup. She gets engagaed to Prince Humperdinck of Floren and subsequently gets kidnapped by a Sicilian and his team who were hired to start a war with Giulder. The kidnappers are apprehended by a man in black who soon best the swordsman and giant who work for the Italian. He then defeats the head honcho and rescues Buttercup. Soon it is revealed the the man in black is Westley. He is tortured by the prince and then \"killed\" too. But he is revived by a miracle man and saves Buttercup from being killed on her wedding night by her would be husband or commiting suicide.",
        "name": "Westley",
        "pic": "http://ia.media-imdb.com/images/M/MV5BOTY1MTk0ODQ1NF5BMl5BanBnXkFtZTcwMzI5MDYwMw@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Mandy Patinkin",
        "bio": "A spaniard that is an expert in fencing, he has a bit of a drinking problem and spends his entire life looking for the six-fingered man (who killed his father). Inigo and his only friend Fezzik later join Westley in storming the castle. It is in this climactic scene that Inigo finally gets his revenge when he meets Count Rugen.",
        "name": "Inigo Montoya",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTI3NDMzNjY1M15BMl5BanBnXkFtZTcwMzc1NTEwMw@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Chris Sarandon",
        "bio": "",
        "name": "Prince Humperdinck",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTk5ODQ2ODgyNV5BMl5BanBnXkFtZTcwNzYzOTAzMQ@@._V1._SY44_CR1,0,32,44_.jpg"
    },
    {
        "actor": "Christopher Guest",
        "bio": "A well-groomed appearance and calm, soft-spoken manner are a perfect camouflage for the truly sadistic nature of Count Tyrone Rugen. He was the right-hand man to the evil Prince Humperdinck of Florin. Rugen was also the object of a remarkable 20 year quest for revenge. He had six fingers on his right hand and was a capable sword fighter.Rugen's hobby was studying pain in others. To this end, he spent half of his life building a special machine that painfully sucked years of life out of its unlucky victims.",
        "name": "Count Tyrone Rugen",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMjE0NzU2MjMzMV5BMl5BanBnXkFtZTYwMzQwMDMz._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Wallace Shawn",
        "bio": "",
        "name": "Vizzini",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTc3MDYzMDQ1OF5BMl5BanBnXkFtZTcwMDQ3OTc1MQ@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "André the Giant",
        "bio": "",
        "name": "Fezzik",
        "pic": null
    },
    {
        "actor": "Fred Savage",
        "bio": "",
        "name": "The Grandson",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTcxNTUyMDQ2OF5BMl5BanBnXkFtZTcwNDQzMjc1MQ@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Robin Wright",
        "bio": "Buttercup was once a poor peasant. She fell in love with Westley, and they decided to get married. Tragedy strikes and Westley is reported to have lost at sea. Buttercup vows to never love again, even though she gets engaged to Prince Humperdink roughly five years later. Buttercup is almost assassinated by Vizzini, Inigo, and Fezzik, but saved by a mysterious man.Buttercup is the typical damsel in distress. She lets others fight for her and doesn't really have a personality.",
        "name": "Buttercup",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTU0NTc4MzEyOV5BMl5BanBnXkFtZTcwODY0ODkzMQ@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Robin Wright",
        "bio": "Buttercup was once a poor peasant. She fell in love with Westley, and they decided to get married. Tragedy strikes and Westley is reported to have lost at sea. Buttercup vows to never love again, even though she gets engaged to Prince Humperdink roughly five years later. Buttercup is almost assassinated by Vizzini, Inigo, and Fezzik, but saved by a mysterious man.Buttercup is the typical damsel in distress. She lets others fight for her and doesn't really have a personality.",
        "name": "The Princess Bride",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTU0NTc4MzEyOV5BMl5BanBnXkFtZTcwODY0ODkzMQ@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Peter Falk",
        "bio": "",
        "name": "The Grandfather",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTk4ODUwNDE3MF5BMl5BanBnXkFtZTYwMjA1NTM0._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Peter Cook",
        "bio": "The Impressive Clergyman presided over the wedding of Prince Humperdinck and Princess Buttercup.Despite his problems with pronunciation (he pronounced marriage as \"mawage\") and a disturbance at the castle gate, the clergyman tried to press on with the ceremony. Things were even more complicated when Humperdinck got impatient and ordered him to skip to the end of the ceremony.The ceremony ended abruptly when the furious prince forced the clergyman to declare them man and wife....without either of them saying \"I do.\" This meant that the marriage was not valid. The clergyman was probably aware of this, but saw no good reason to point this out to Humperdinck.",
        "name": "The Impressive Clergyman",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTU2MjE1MjM1NV5BMl5BanBnXkFtZTcwNDgxMjk3NA@@._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Mel Smith",
        "bio": "The Albino served as a lab assistant to Count Rugen and Prince Humperdinck in their secret lab, which was known as Pit of Despair. He was a big man with chalk-white skin and hair and he dressed in a simple outfit. His name is never mentioned.Part of the Albino's job included preparing prisoners for torture on \"The Machine.\" Sometimes, he had to treat them, so they would be healthy before the torture. The Albino enjoyed watching the prisoners suffer. He also didn't mind telling them that they had no hope of escape or rescue.One day, in a fit of rage, the prince almost killed one of their research subjects. The Albino got a wheelbarrow to dispose of him, but he was intercepted by a sword-wielding Spaniard and his giant friend. Since the Albino was too scared to answer their questions, the giant hit him on the head to get him to talk. However, the Albino collapsed instead, either unconscious or dead.",
        "name": "The Albino",
        "pic": null
    },
    {
        "actor": "Carol Kane",
        "bio": "",
        "name": "Valerie",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTc3NDgzMzMwOV5BMl5BanBnXkFtZTYwNjg1NzY0._V1._SX32_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Billy Crystal",
        "bio": "",
        "name": "Miracle Max",
        "pic": "http://ia.media-imdb.com/images/M/MV5BMTQ4MjA4MjM4NV5BMl5BanBnXkFtZTcwMzE0MjcxNQ@@._V1._SY44_CR0,0,32,44_.jpg"
    },
    {
        "actor": "Anne Dyson",
        "bio": "This woman was the Queen of the country of Florin. She was present, along with the senile king, at her son's wedding. Later, they both agreed it was a \"strange wedding.\"",
        "name": "The Queen",
        "pic": null
    },
    {
        "actor": "Margery Mason",
        "bio": "The Ancient Booer was a foul-tongued old woman who appeared in Princess Buttercup's dream and cursed her for rejecting her true love.",
        "name": "The Ancient Booer",
        "pic": null
    }]
}