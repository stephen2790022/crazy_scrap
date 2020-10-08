require 'rubygems'
require 'nokogiri' 
require 'open-uri'


def get_townhall_email(url)
    list = Hash.new
    page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr' + url)) # On prend l'URL de base et on ajoute la partie manquante de l'URL afin de récupérer l'email de chaque mairie
    email = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
end

def get_townhall_urls
    urls = []
    list = [] 
    list_email = []

    page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))

    email = page.css("div#deputes-list//a//@href")
    arr =  page.xpath('//*[@id="deputes-list"]//ul//li//a/text()')
    
    arr.each do |x|
          list << {:first_name => x.to_s.split(' ')[1], :last_name => x.to_s.split(' ')[2]}
    end

    email.each do |items|
        email = get_townhall_email(items)
        list_email << {:email => email.to_s}    
    end  

     puts list.zip(list_email).map{|c,p| {c => p}}.to_a
    
end





