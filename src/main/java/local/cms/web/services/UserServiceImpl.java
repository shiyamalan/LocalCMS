package local.cms.web.services;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import local.cms.web.dao.RoleDAO;
import local.cms.web.dao.UserDAO;
import local.cms.web.models.User;

public class UserServiceImpl implements UserService {

	UserDAO userDao;

	RoleDAO roleDao;

	public void setRoleDao(RoleDAO roleDao) {
		this.roleDao = roleDao;
	}

	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Transactional
	public User createUser(User user) {

		return userDao.createUser(user);
	}

	public List<User> listUsers() {
		return userDao.listUsers();
	}

	public void UpdateUser(User user) {
		userDao.updateUser(user);

	}

	@Override
	public User login(User user, HttpSession session) {

		User authUser = new User();
		authUser = userDao.authenticate(user.getUsername(), user.getPassword());

		if (authUser != null) {
			session.setAttribute("USER_SESSION", authUser);
		}
		return authUser;

	}

	@Override
	public void updateUserEnableStatus(User user) {
		userDao.changeUserEnableStatus(user);
	}

}
