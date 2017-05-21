package local.cms.web.dao;

import java.util.List;

import local.cms.web.models.User;

public interface UserDAO {

	User createUser(User user);

	List<User> listUsers();

	void updateUser(User user);

	User authenticate(String userName, String passWord);

	void changeUserEnableStatus(User user);
}
