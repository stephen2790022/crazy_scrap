require 'rubygems'
require 'nokogiri' 
require 'open-uri'

def get_townhall_email(url)
    list = Hash.new
    url = url[1..-1]
    page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com' + url)) # On prend l'URL de base et on ajoute la partie manquante de l'URL afin de récupérer l'email de chaque mairie
    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

# Récupération de toutes les URLs des villes du Val d'Oise
def get_townhall_urls
    urls = Array.new
    page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
    arr = page.css("a.lientxt") # Récupération des noms des villes depuis le CSS du code source

    arr.each do |link_name|
        list = Hash.new
        txt = link_name.text 
        email = get_townhall_email(link_name['href'])
        list["name"] = txt # ça c'est le nom de la ville
        list["email"] = email # et ça l'email de la mairie en question
        urls.push(list) # on ajoute les deux du dessus dans notre Array
    end
    #puts urls
    return urls
end

get_townhall_urls