class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

     include PermissionsConcern
     include AASM

     aasm column: "state" do 
     	state :desactivado, initial: true
     	state :activo

     	event :activar do
     		transitions from: :desactivado, to: :activo
     	end

     	event :desactivar do 
 			transitions from: :activo, to: :desactivado
     	end

     end

    def self.search(search)
      if search
        where('name LIKE ? OR cc = ? OR state = ?', "%#{search}%", "#{search}", "#{search}")        
      else
        all
      end
    end

end
