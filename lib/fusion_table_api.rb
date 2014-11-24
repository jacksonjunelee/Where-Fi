class FusionTableApi

	def self.get_fusion_table
    @ft = GData::Client::FusionTables.new
    @ft.clientlogin(ENV["GOOGLE_ID"],ENV["GOOGLE_PW"])
    @ft.set_api_key(ENV["GOOGLE_API"])
    @login = @ft.show_tables[0]
	end

end