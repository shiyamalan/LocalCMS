package local.cms.web.services;

import java.util.List;

import javax.servlet.http.HttpSession;

import local.cms.web.models.User;

public interface UserService {

	User createUser(User user);

	List<User> listUsers();

	void UpdateUser(User user);

	User login(User user,HttpSession session);
	
	void updateUserEnableStatus(User user);

}
