package local.cms.web.services;

import java.util.List;

import local.cms.web.models.Post;

public interface PostService {

	void createNewPost(Post post);
	
	void updatePost(Post post);
	
	List<Post> listPost();
	
	List<Post> getAllByUser(String userName);
	
	Post getById(int id);

}
