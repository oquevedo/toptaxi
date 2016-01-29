
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



module PodioBuilder

  def self.process_cars items
    
    results = []
    items.all.each do |i|
      results << PodioBuilder.build_car(i)
    end
    return results
  end

  def self.build_car item

    r = {}
    r[:drivers] = []
    r[:owners] = []
    r[:administrators] = []

    r[:campains] = []
    r[:item_id] =  item.item_id.to_i
    r[:link] =  item.link

    item.fields.each do |f|
      case f["field_id"]
      when 79062312 # ID
        r[:app_id] = f["values"][0]["value"]
      when 75675152 # Patente
        r[:patente] = f["values"][0]["value"]
      when 102315271 # ESTADO
        r[:estado] = f["values"][0]["value"]["text"]
      when 101918529 # TAXISTA
        f["values"].each do |u|
          user = {
             name: u["value"]["title"],
             link: u["value"]["link"],
             item_id: u["value"]["item_id"],
             app_item_id: u["value"]["app_item_id"],
             relationship: "Taxista"
          }
          r[:drivers] << user
        end
      when 101918159 # Dueño
        f["values"].each do |u|
          user = {
             name: u["value"]["title"],
             link: u["value"]["link"],
             item_id: u["value"]["item_id"],
             app_item_id: u["value"]["app_item_id"],
             relationship: "Dueño"
          }
          r[:owners] << user
        end
      when 101921314 # ADMINISTRADOR
        f["values"].each do |u|
          user = {
             name: u["value"]["title"],
             link: u["value"]["link"],
             item_id: u["value"]["item_id"],
             app_item_id: u["value"]["app_item_id"],
             relationship: "Administrador"
          }
          r[:administrators] << user
        end

      when 101921313 # CONTACTO
        r[:contact] = f["values"][0]["value"]["text"]
        r[:contact_id] = f["values"][0]["value"]["id"]

      when 100260492 # GPS
      when 99182333 # CAMPAÑAS
        f["values"].each do |u|
          campain = {
             name: u["value"]["text"],
             id: u["value"]["id"]
          }
          r[:campains] << campain
        end

      end
    end

    case r[:contact_id].to_i

    when 1 #Dueño
      r[:user] = r[:owners][0]
    when 2 #TAXISTA
      r[:user] = r[:drivers][0]
    when 3 #administrador
      r[:user] = r[:administrators][0]
    when 4 # DUEÑO/TAX
      r[:user] = r[:owners][0]
      r[:user] = r[:drivers][0] if !r[:user].present?
    end

    return r

  end


  def self.build_driver item
    sanitizer = Rails::Html::FullSanitizer.new
    r = {}
    r[:app_id] = item.app_item_id_formatted
    r[:link] = item.link
    item.fields.each do |f|
      case f["field_id"]
      when 97809120 # 101921552 # Nombre
        r[:name] = f["values"][0]["value"]
      when 75755652 #101921597 # Telefono
        r[:phone] = f["values"][0]["value"]
      when 79630524 # rut
        r[:rut] = f["values"][0]["value"]
      when 79630525 # mail
        r[:mail] = sanitizer.sanitize  f["values"][0]["value"]
      end
    end
    return r
    
  end

  def self.build_owner item
    sanitizer = Rails::Html::FullSanitizer.new
    r = {}
    r[:app_id] = item.app_item_id_formatted
    r[:link] = item.link
    item.fields.each do |f|
      case f["field_id"]
      when 97814428 # Nombre
        r[:name] = sanitizer.sanitize f["values"][0]["value"]
      when 79375147 # Telefono
        r[:phone] = sanitizer.sanitize f["values"][0]["value"]
      when 79150924 # rut
        r[:rut] = f["values"][0]["value"]
      when 79150925 # mail
        r[:mail] = sanitizer.sanitize f["values"][0]["value"]
      end
    end
    return r
  end

  def self.build_administrator item
    # PodioBuilder.build_administrator 314494907
    r = {}
    r[:app_id] = item.app_item_id_formatted
    r[:link] = item.link
    item.fields.each do |f|
      case f["field_id"]
      when 101921552 # Nombre
        r[:name] = f["values"][0]["value"]
      when  101921597 #75755652 # Telefono
        r[:phone] = f["values"][0]["value"]
      # when 79150924 #79630524 # rut
      #   r[:rut] = f["values"][0]["value"]
      # when 79150925 #79630525 # mail
      #   r[:mail] = f["values"][0]["value"]
      end
    end
    return r
  end

  def self.build_item item_id
    item = Podio::Item.find_basic(item_id)

    case item.app["app_id"] 

    when 13309202 # "Administradores"
      r = PodioBuilder.build_administrator item
    when 10227914 # "Owner"
      r = PodioBuilder.build_owner item
    when 9713083 # "Driver"
      r = PodioBuilder.build_driver item
    when 9731541 # "autos"
      r = PodioBuilder.build_car item
    end
    return r
  end

end



# r.all[0].fields.each do |p|
#   puts "#{p["field_id"]}, #{p["external_id"]}, #{p["label"]} "
# end; nil