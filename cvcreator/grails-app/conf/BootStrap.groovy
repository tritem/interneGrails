class BootStrap {

    def init = { servletContext ->
		bootstrapService.initModele()
    }
    def destroy = {
    }
	
	def bootstrapService
}
