package local.cms.web.dao;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import local.cms.web.models.User;

public class UserDAOImpl implements UserDAO {

	SessionFactory sessionFactory;

	RoleDAO roleDao;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Transactional
	public User createUser(User user) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.persist(user);
		tx.commit();
		session.close();
		return user;
	}

	public List<User> listUsers() {

		Session session = this.sessionFactory.openSession();
		List<Object[]> userList = session
				.createQuery("select u.username, u.enabled from User as u")
				.list();
		session.close();

		List<User> users = new ArrayList<>();
		for (Object obj[] : userList) {
			User user = new User();
			user.setUsername(obj[0].toString());
			user.setEnabled(Boolean.parseBoolean(obj[1].toString()));
			users.add(user);
		}
		return users;
	}

	public void updateUser(User user) {
		Session session = this.sessionFactory.openSession();
		Query query = session.createQuery("update User set enabled = :enabled"
				+ " where username = :username");
		query.setParameter("enabled", user.isEnabled());
		query.setParameter("username", user.getUsername());
		query.executeUpdate();
		session.close();
	}

	@Override
	public User authenticate(String userName, String passWord) {
		Session session = this.sessionFactory.openSession();
		Query query = session.createQuery(
				"select u.username, u.enabled from User u where u.username = :user_name and u.password =:pass_word");
		query.setParameter("user_name", userName);
		query.setParameter("pass_word", passWord);

		Object[] obj = (Object[]) query.uniqueResult();
		session.close();
		if (obj == null) {
			return null;
		}
		if (Boolean.parseBoolean(obj[1].toString())) {
			User user = new User();
			user.setUsername(obj[0].toString());
			return user;
		} else {
			return null;
		}
	}

	@Override
	public void changeUserEnableStatus(User user) {
		Session session = this.sessionFactory.openSession();
		Query query = session.createQuery("update User set enabled = :enabled"
				+ " where username = :username");
		query.setParameter("enabled", !user.isEnabled());
		query.setParameter("username", user.getUsername());
		query.executeUpdate();
		session.close();

	}

}
