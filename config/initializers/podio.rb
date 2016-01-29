  

# cert_path = Gem.loaded_specs['google-api-client'].full_gem_path+'/lib/cacerts.pem'
# ENV['SSL_CERT_FILE'] = "/usr/local/etc/openssl/cert.pem" "/etc/openssl/cert.pem"


# connection = Faraday::Connection.new 'https://encrypted.google.com', :ssl => {
#     :ca_path => "/usr/local/etc/openssl/certs"
# }

# ENV['SSL_CERT_FILE'] = "/usr/local/etc/openssl/certs"
Podio.setup(:api_key => ENV['PODIO_API_KEY'], :api_secret => ENV['PODIO_API_SECRET'])

Podio.client.authenticate_with_credentials(ENV['PODIO_USER'], ENV['PODIO_PASSWORD'])




####### APP ######
# ID  : Nombre
# 9731541 : Vehiculos Podio::Application.find(9731541)
# 9713083 : Taxistas
# 14492816 : Letreros
# 10227914 : Dueños
# 10266911 : Cuentas
# 10068668 : Captados
# 13309202 : Administradores

###### FIELDS VEHICULO ##### 
# 79062312, id-contrato, ID
# 75675152, patente, Patente
# 102315271, estado, ESTADO
# 101918529, t, TAXISTA
# 101918159, d, DUEÑO
# 101921314, administrador, ADMINISTRADOR
# 109645755, cuenta, CUENTA
# 111420991, letrero, LETRERO
# 101921313, contacto-4, Contacto
# 75489286, titulo, Marca
# 75675150, modelo, Modelo
# 75675151, ano, Año
# 100260492, gps, GPS
# 79309104, estado-seremi, Estado Seremi
# 93671954, app-celular, App Celular
# 79379618, combustible, Combustible
# 99182333, campanas, Campañas
# 82949001, comentarios, Comentarios


# Podio::Application.find(9731541)
# Podio::Item.find_by_filter_values( 9731541, {})


# r.all.each do |p|
#   puts "#{p.item_id}, #{p.title} "
# end; nil

# items = Podio::Item.find_by_filter_values( 9731541, {})
# items.all.each do |i|
#   r = {}
#   r[:users] = []
#   i.fields.each do |f|
#     case f["field_id"]
#     when 79062312 # ID
#       r[:id] = f["values"][0]["value"]
#     when 75675152 # Patente
#       r[:patente] = f["values"][0]["value"]
#     when 102315271 # ESTADO
#       r[:estado] = f["values"][0]["value"]["text"]
#     when 101918529 # TAXISTA
#       f["values"].each do |u|
#         user = {
#            name: u["value"]["title"],
#            link: u["value"]["title"]["link"],
#            item_id: u["value"]["item_id"],
#            app_item_id: u["value"]["app_item_id"],
#            relationship: "Taxista"
#         }
#       end
#       r[:users] << user
#     when 101918159 # Dueño
#       f["values"].each do |u|
#         user = {
#            name: u["value"]["title"],
#            link: u["value"]["title"]["link"],
#            item_id: u["value"]["item_id"],
#            app_item_id: u["value"]["app_item_id"],
#            relationship: "Dueño"
#         }
#       end
#       r[:users] << user
#     when 101921314 # ADMINISTRADOR
#       f["values"].each do |u|
#         user = {
#            name: u["value"]["title"],
#            link: u["value"]["title"]["link"],
#            item_id: u["value"]["item_id"],
#            app_item_id: u["value"]["app_item_id"],
#            relationship: "Administrador"
#         }
#       end
#       r[:users] << user

#     when 101921313
#       r[:contact] = f["values"][0]["value"]["text"]
#       r[:contact_id] = f["values"][0]["value"]["text"]


#     end
#   end; nil
#   puts "#{p.item_id}, #{p.title} "
# end; nil



# r.all[0].fields.each do |p|
#   puts "#{p["field_id"]}, #{p["external_id"]}, #{p["label"]} "
# end; nil
