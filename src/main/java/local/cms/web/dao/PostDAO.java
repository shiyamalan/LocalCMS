package local.cms.web.dao;

import java.util.List;

import local.cms.web.models.Post;

public interface PostDAO {

	void createNewPost(Post post);

	Post updatePost(Post post);

	List<Post> listPost();

	List<Post> getAllByUser(String userName);

	Post getById(int id);
}
