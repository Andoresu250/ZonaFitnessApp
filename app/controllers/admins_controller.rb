class AdminsController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_action :authenticate_admin!, only: [:index,:edit,:activar,:desactivar,:update,:destroy]
	before_filter :find_user, except: [:index]
	helper_method :sort_column, :sort_direction
	respond_to :html
	
	def index
		@users = User.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 2)
		respond_with(@users)
	end	

	def edit		

	end

	def activar
		respond_to do |format|
			if @user.activar!
				format.html { redirect_to "/admins", notice: 'Se activo correctamente.' }
			end			
		end		
	end

	def desactivar
		respond_to do |format|
			if @user.desactivar!
				format.html { redirect_to "/admins", notice: 'Se desactivo correctamente.' }
			end			
		end	
	end

	def update		
		respond_to do |format|
			if @user.update_attributes(user_params)
				format.html { redirect_to "/admins", notice: 'Se guardo correctamente.' }
			else
				format.html { redirect_to "/admins", alert: 'No se pudo guardar, revisa que los datos ingresados sean correctos.' }
			end
		end		
	end

	def destroy
		respond_to do |format|
			if @user.destroy
				format.html { redirect_to "/admins", notice: 'El usuario fue borrado correctamente.' }
			else
				format.html { redirect_to "/admins", alert: 'No se pudo borrar el usuario.' }
			end
		end
	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	private    		

	def sort_column
    	User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  	end
  
  	def sort_direction
    	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  	end

  	def user_params
		params.require(:user).permit(:name, :cc, :number_of_classes, :state)
	end
end