module LocationsHelper

	def convert_radius_to_zoom(radius)	
		zoom = { 0.1 => 18, 0.3 => 16, 0.5 => 15, 1.0 => 14, 'all' => 10 }
		zoom[radius] 
	end

end