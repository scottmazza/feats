module MapsHelper
  class Marker
    attr_reader :title, :latitude, :longitude, :content_str, :context
    
    def initialize( context, title, latitude, longitude, content_str )
      @context     = context
      @title       = title
      @latitude    = latitude
      @longitude   = longitude 
      @content_str = context.escape_javascript( content_str )  
    end
    
    def add_data( obj )
      content_str << context.tag( "br", nil, true ) << 
        context.link_to( context.escape_javascript( obj.name ), obj )
    end    
  end
  
  def get_map_center( obj_array, location )
    if obj_array.nil? or obj_array.empty?
      if location.nil? || ( location.latitude.blank? && location.longitude.blank? ) 
        [ 37.09024, -95.712891 ]
      else
        [ location.latitude, location.longitude ]
      end
    else 
      [ obj_array.first.location.latitude, obj_array.first.location.longitude ]     
    end
  end
  
  def create_markers( context, obj_array )
    markers = [ ]
    unless obj_array.nil?
      obj_array.each do |obj|
        marker_exists = false
        markers.each do |m|
          if obj.location.latitude == m.latitude and
             obj.location.longitude == m.longitude
            marker_exists = true
            m.add_data( obj )
            break;
          end
        end
        unless marker_exists
            markers << Marker.new(
                          context,
                          obj.location.address, 
                          obj.location.latitude,
                          obj.location.longitude, 
                          link_to( obj.name, obj ))
        end
      end
    end
    markers
  end
end
