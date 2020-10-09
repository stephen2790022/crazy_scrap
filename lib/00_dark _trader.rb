require 'rubygems'
require 'nokogiri' 
require 'open-uri'

A = [] 
B = []
C = []

# Scrap de : 1- Noms des cryptomonnaies (Hash B). 2- Valeur de la cryptomonnaie à l'unité (Hash C)
def crypto_scrapper ()
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  page.xpath("//td[2]").each do |items|
    B << items.text
    end
  page.xpath("//td[5]").each do |items|
    C << items.text.delete('$')
  end

# Insertion des Hashes B et C dans l'Array A
B.zip(C).each{|x| A << {x[0] => x[1]}}

#puts A
return puts A
end

crypto_scrapper