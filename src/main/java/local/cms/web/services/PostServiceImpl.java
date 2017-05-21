package local.cms.web.services;

import java.util.List;

import local.cms.web.dao.PostDAO;
import local.cms.web.models.Post;

public class PostServiceImpl  implements PostService
{
	PostDAO postDAO;

	public void setPostDAO(PostDAO postDAO) {
		this.postDAO = postDAO;
	}

	@Override
	public void createNewPost(Post post) {
		
		postDAO.createNewPost(post);
	}

	@Override
	public void updatePost(Post post) {
		postDAO.updatePost(post);
	}

	@Override
	public List<Post> listPost() {

		return postDAO.listPost();
	}

	@Override
	public List<Post> getAllByUser(String userName) {
		// TODO Auto-generated method stub
		return postDAO.getAllByUser(userName);
	}

	@Override
	public Post getById(int id) {
		// TODO Auto-generated method stub
		return postDAO.getById(id);
	}
	
	
	
}
