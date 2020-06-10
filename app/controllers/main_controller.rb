=begin
 June 2020    Modified to remove area pages and include new photo pages and images
=end

class MainController < ApplicationController
  layout :resolve_layout

=begin  
  def calendar
    calendar_date = DateTime.now.beginning_of_month + 10.days
    @current_date = session[:calendar] ? session[:calendar] : Time.parse(calendar_date.to_date.to_s).to_i*1000
  end
=end
  def calendar
    @title = "Temporary Calendar Page"
    @image = "unread.png"
    render 'main/photo_gallery'
  end
  
  def introduction
  end

  def events_and_activities
  end

  def membership
  end

  def contacts
  end

=begin
  def bedford
  end

  def south_bedfordshire
  end

  def st_albans
  end

  def contacts
  end

  def mid_hertfordshire
  end

  def west_hertfordshire
  end

  def north_hertfordshire
  end
=end

  def areas_covered
  end

  def evening_events
    @title = "Evening Events"
    # @image = "photo_page_eveningsout_1.jpg"
    @image_1 = "Christmas Party 2015 1.jpg"
    @image_2 = "IMG_6544_small.JPG"
    
    @image_3 = "IMG_6664_small.JPG"
    @image_4 = "IMG_6696_small.JPG"
    @image_5 = "Christmas Party 2015 2.jpg"
    @image_6 = "IMG_20181121_small.jpg"
    @image_7 = "Paul Barbecue 2016 small.jpg"
    @image_8 = "photo.JPG"
    @image_9 = "IMG_5466a_small.jpg"
    @image_10 = "IMG_5496_small.JPG"
    @image_11 = "Totopoly_small.jpg"
    @image_12 = "IMG_1921_small.JPG"
    render 'main/photo_gallery_11pic'
  end

  def days_out
    @title = "Days Out"
    # @image = "photo_page_daysout.jpg"
    @image_1 ="IMG_0040_small.JPG"
    @image_2 ="IMG_0019_small.JPG"
    @image_3 ="IMG_0038_small.JPG"
    
    @image_4 ="IMG_0016_small.JPG"
    @image_5 ="IMG_0049_small.JPG"
    
    @image_6 ="IMG_1304_small.JPG"
    @image_7 ="IMG_1254_small.JPG"
    @image_8 ="IMG_4114_small.JPG"
    
    @image_9 ="IMG_1410_small.JPG"
    @image_10 ="IMG_1414_small.JPG"
    
    @image_11 ="P1080636_small.JPG"
    @image_12 ="IMG_1227_small.JPG"
    @image_13 ="P1080637_small.JPG"

    
    @image_14 ="IMG_6564_small.JPG"
    @image_15 ="IMG_2323_small.JPG"
    
    @image_16 ="IMG_0885_small.JPG"
    @image_17 ="IMG_0832a_small.JPG"
    @image_18 ="IMG_0896_small.JPG"
    render 'main/photo_gallery_18pic'
  end

  def walks
    @title = "Walks"
    # @image = "photo_page_walks_1.jpg"
    @image_1 ="IMG_0716_small.JPG"
    @image_2 ="IMG_0721_small.JPG"
    @image_3 ="IMG_0728_small.JPG"
    
    @image_4 ="IMG_0724_small.JPG"
    @image_5 ="IMG_2166_small.JPG"
    
    @image_6 ="IMG_2172_small.JPG"
    @image_7 ="IMG_3194_small.JPG"
    @image_8 ="IMG_3203_small.JPG"
    
    @image_9 ="IMG_3207_small.JPG"
    @image_10 ="IMG_4217_small.JPG"
    
    @image_11 ="IMG_4224_small.JPG"
    @image_12 ="IMG_2180_small.JPG"
    @image_13 ="IMG_2176_small.JPG"
    
    @image_14 ="IMG_4232_small.JPG"
    @image_15 ="IMG_4229_small.JPG"
    render 'main/photo_gallery_15pic'
  end

  def weekends_away
    @title = "Weekends Away"
    # @image = "photo_page_city_weekends.jpg"
    @location_1 = "North Wales"
    @image_1 ="IMG_3643_small.JPG"
    @image_2 ="DSC01398_small.JPG"
    @image_3 ="IMG_3735_small.JPG"
   
    
    @image_4 ="P1100123_small.JPG"
    @image_5 ="P1100133_small.JPG"
    
    @location_2 = "Avebury"
    @image_6 ="IMG_1119_small.JPG"
    @image_7 ="IMG_1120_small.JPG"
    @image_8 ="IMG_1126_small.JPG"
    
    @image_9 ="IMG_1132_small.JPG"
    @image_10 ="IMG_1135_small.JPG"
    
    @location_3 = "Whitby"
    @image_11 ="P1130495_small.JPG"
    @image_12 ="IMG_2362_small.JPG"
    @image_13 ="IMG_2361_small.JPG"

    @image_14 ="P1130595_small.JPG"
    @image_15 ="P1130609_small.JPG"
    render 'main/photo_gallery_15pic_t'
  end

  def houses_gardens
    @title = "Houses & Gardens"
    # @image = "photo_page_weekends.jpg"
    @image_1 ="IMG_2356_small.JPG"
    @image_2 ="IMG_1158_small.JPG"
    @image_3 ="IMG_1091_small.JPG"
    
    @image_4 ="IMG_2717_small.JPG"
    @image_5 ="IMG_2743_small.JPG"
    
    @image_6 ="IMG_2731_small.JPG"
    @image_7 ="IMG_1086_small.JPG"
    @image_8 ="IMG_1068_small.JPG"
    
    @image_9 ="IMG_5571_small.JPG"
    @image_10 ="IMG_5582_small.JPG"
    
    @image_11 ="IMG_5595_small.JPG"
    @image_12 ="IMG_5693_small.JPG"
    @image_13 ="IMG_5720_small.JPG"

    @image_14 ="IMG_5889a_small.jpg"
    @image_15 ="P1170279a_small.jpg"
    
    @image_16 ="P1070711_small.JPG"
    @image_17 ="P1070700_small.JPG"
    @image_18 ="P1100318_small.JPG"    
    render 'main/photo_gallery_18pic'
  end

  def seaside_breaks
    @title = "Seaside Breaks"
    # @image = "photo_page_swanage1.jpg"
    @location_1 = "Swanage"
    @image_1 ="P1150529_small.JPG"
    @image_2 ="P1150588_small.JPG"
    @image_3 ="P1150595_small.JPG"
    
    @image_4 ="P1150582_small.JPG"
    @image_5 ="P1150599_small.JPG"
    
    @location_2 = "Tenby"
    @image_6 ="P1110838_small.JPG"
    @image_7 ="P1110854_small.JPG"
    @image_8 ="P1110772_small.JPG"
    
    @image_9 ="P1110881_small.JPG"
    @image_10 ="P1110846_small.JPG"
    
    @location_3 = "Minehead"
    @image_11 ="P1170724_small.JPG"
    @image_12 ="P1170654_small.JPG"
    @image_13 ="P1170661_small.JPG"

    @image_14 ="IMG_5162_small.JPG"
    @image_15 ="P1170746_small.JPG"
    render 'main/photo_gallery_15pic_t'
  end

  def activities
    @title = "Activities"
    # @image = "activities_photo_page.jpg"
    @image_1 = "DSC00811_small.JPG"
    @image_2 = "IMG_7732_small.JPG"
    @image_3 = "IMG_7756_small.JPG"
    @image_4 = "P1010568_small.JPG"
    @image_5 = "IMG_0151a_small.jpg"
    @image_6 = "P1010561a_small.jpg"
    @image_7 = "Tents_small.jpg"
    @image_8 = "DSC00965_small.JPG"
    @image_9 = "IMG_1087_small.JPG"
    render 'main/photo_gallery_9pic'
  end
  
  def trips_abroad
    @title = "Trips Abroad"
    # @image = "photo_page_europe.jpg"
    @location_1 = "Prague"
    @image_1 ="005_5_small.JPG"
    @image_2 ="023_23_small.JPG"
    @image_3 ="003_3_small.JPG"
    
    @image_4 ="006_6_small.JPG"
    @image_5 ="011_11_small.JPG"
    
    @location_2 = "Rome"
    @image_6 ="DSCF0005_small.JPG"
    @image_7 ="IMG_0632_small.JPG"
    @image_8 ="DSCF0310_small.JPG"
    
    @image_9 ="DSCF0248_small.JPG"
    @image_10 ="DSCF0327_small.JPG"
    render 'main/photo_gallery_10pic'
  end
end

private   

def resolve_layout
  case action_name
   when "calendar_1"   # temporary mod should be 'calendar'
    "application"
   else 
    "main"
   end
end