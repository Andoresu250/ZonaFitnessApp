module PermissionsConcern
	extend ActiveSupport::Concern

	def is_normal_user?
		self.permission_level == 1
	end

	def is_trainer?
		self.permission_level >= 2
	end

	def is_admin?
		self.permission_level >= 3
	end

	def is_super_admin?
		self.permission_level >= 4
	end
end