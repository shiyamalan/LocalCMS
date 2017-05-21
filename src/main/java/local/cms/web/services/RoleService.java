package local.cms.web.services;

import local.cms.web.models.UserRole;

public interface RoleService {
	
	
	void saveRole(UserRole userRole);
	
	boolean isAdmin(String userName);

}
