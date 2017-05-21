package local.cms.web.dao;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import local.cms.web.models.Post;

public class PostDAOImpl implements PostDAO {

	SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	@Transactional
	public void createNewPost(Post post) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		post.setCreated(new Date());
		post.setModified(new Date());
		session.save(post);
		tx.commit();
		session.close();
		return;

	}

	@Override
	@Transactional
	public Post updatePost(Post post) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.update(post);
		post.setModified(new Date());
		tx.commit();
		session.close();
		return post;

	}

	@Override
	public List<Post> listPost() {
		Session session = this.sessionFactory.openSession();
		List<Post> posts = session.createQuery("from Post").list();
		session.close();
		return posts;
	}

	@Override
	public List<Post> getAllByUser(String userName) {
		Session session = this.sessionFactory.openSession();
		List<Post> posts = session
				.createQuery("from Post p where p.username =:username")
				.setParameter("username", userName).list();
		session.close();
		return posts;
	}

	@Override
	public Post getById(int id) {
		Session session = this.sessionFactory.openSession();
		Post posts = (Post) session.get(Post.class, new Integer(id));
		session.close();
		return posts;
	}

}
