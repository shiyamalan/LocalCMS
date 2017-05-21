package local.cms.web.dao;

import local.cms.web.models.UserRole;

public interface RoleDAO {

	UserRole saveRole(UserRole role);

	boolean isAdmin(String user);
}
