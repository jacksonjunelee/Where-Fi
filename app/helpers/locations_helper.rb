module LocationsHelper

	def convert_radius_to_zoom(radius)	
		zoom = { 0.1 => 18, 0.3 => 16, 0.5 => 14, 1.0 => 13, 'all' => 10 }
		return zoom[radius] 
	end
end