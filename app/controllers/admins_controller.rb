class AdminsController < ApplicationController
  authorize_resource :class => false
  def dashboard
  end

  def podio_info
    items = Podio::Item.find_by_filter_values( 9731541, {},{"limit": 30, "offset": 30*params[:page].to_i})
    @cars = PodioBuilder.process_cars items

    @total = items.total_count.to_f
    @page = params[:page].to_i
    @pages = (@total/30).ceil
  end

  def podio_item
  	@item= PodioBuilder.build_item params[:item_id]

  	@drivers = []
  	@item[:drivers].each do |d|
  		@drivers << PodioBuilder.build_item( d[:item_id]) if d[:item_id].present?
  	end
  	@owners = []
  	@item[:owners].each do |d|
  		@owners << PodioBuilder.build_item( d[:item_id]) if d[:item_id].present?
  	end
  	@administrators = []
  	@item[:administrators].each do |d|
  		@administrators << PodioBuilder.build_item( d[:item_id]) if d[:item_id].present?
  	end


  end
end
