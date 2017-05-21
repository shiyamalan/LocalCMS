package local.cms.web.pages.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import local.cms.web.models.Post;
import local.cms.web.models.Status;
import local.cms.web.models.User;
import local.cms.web.services.PostService;
import local.cms.web.services.RoleService;
import local.cms.web.util.CustomUtil;
/***
 * 
 * @author shiyam
 * @version 1.0.0
 * @since 1.0.0
 * 
 *        Handles the page request
 */
@Controller
public class WebPageController {

	PostService postService;

	RoleService roleService;

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public void setPostService(PostService postService) {
		this.postService = postService;
	}

	@RequestMapping(value = "/post/create", method = RequestMethod.POST)
	public String createPost(@ModelAttribute("postForm") Post post,
			@RequestParam String action, BindingResult result, Model model,
			HttpServletRequest request,
			final RedirectAttributes redirectAttributes) {

		if (action.equals("preview")) {
			post.setStatus(Status.Draft);
			CustomUtil.converStringfromByte(post);
			redirectAttributes.addFlashAttribute("post", post);

			return "redirect:/post/preview";
		} else if (action.equals("draft")) {
			post.setStatus(Status.Draft);
			postService.createNewPost(post);
			CustomUtil.converStringfromByte(post);

			model.addAttribute("post", post);

			return "postView";

		} else if (action.equals("publish")) {
			post.setStatus(Status.ReadyPublish);
			postService.createNewPost(post);
			CustomUtil.converStringfromByte(post);
			return "page";
		}

		return "home";
	}

	@RequestMapping(value = "/post/view", method = RequestMethod.GET)
	public String showPost(HttpServletResponse response,
			HttpServletRequest request, Model model) {

		String userName = getUserInfo(request);
		if (userName == null) {
			return "login";
		}
		if (roleService.isAdmin(userName)) {
			List<Post> posts = postService.listPost();
			for (Post post : posts) {
				CustomUtil.converStringfromByte(post);
			}
			model.addAttribute("posts", posts);
			return "postview_admin";
		} else {
			List<Post> posts = postService.getAllByUser(null);
			for (Post post : posts) {
				CustomUtil.converStringfromByte(post);
			}
			model.addAttribute("posts", posts);
			return "viewUser";
		}
	}

	private String getUserInfo(HttpServletRequest request) {
		HttpSession session = request.getSession();

		User user = ((User) session.getAttribute("USER_SESSION"));
		if (user == null) {
			return null;
		}
		String userName = user.getUsername();
		return userName;
	}

	@RequestMapping(value = "/post/viewUser", method = RequestMethod.GET)
	public String showUserPost(HttpServletResponse response,
			HttpServletRequest request, Model model) {

		List<Post> posts = postService.getAllByUser(null);
		model.addAttribute("posts", posts);
		return "viewUser";
	}

	@RequestMapping(value = "/post/state", method = RequestMethod.POST)
	public String changeState(HttpServletResponse response,
			HttpServletRequest request, Model model) {
		int id = ServletRequestUtils.getIntParameter(request, "id", 0);
		String date = ServletRequestUtils.getStringParameter(request, "date",
				"");
		DateFormat sourceFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss.SSS");
		if (id > 0) {
			Post post = postService.getById(id);
			Status status = post.getStatus();
			post.setStatus(status.next());
			if (post.getStatus() == Status.Published) {
				if (date.trim().length() > 0) {
					try {
						post.setPublish(sourceFormat.parse(date));
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
				post.setPublish(new Date());
			}
			postService.updatePost(post);
		}

		if (roleService.isAdmin(getUserInfo(request))) {
			List<Post> posts = postService.listPost();
			for (Post post : posts) {
				CustomUtil.converStringfromByte(post);
			}
			model.addAttribute("posts", posts);
			return "view";
		} else {
			List<Post> posts = postService.getAllByUser(null);
			for (Post post : posts) {
				CustomUtil.converStringfromByte(post);
			}
			model.addAttribute("posts", posts);
			return "viewUser";
		}
	}

	@RequestMapping(value = "/post/preview/{id}")
	public ModelAndView previewPost(@PathVariable int id) {
		Post post = postService.getById(id);
		ModelAndView view = new ModelAndView("page");
		view.addObject("post", post);
		return view;
	}
	@RequestMapping(value = "/post/preview", method = RequestMethod.GET)
	public String showPreview(HttpServletResponse response,
			HttpServletRequest request, Model model,
			@ModelAttribute("post") final Post post) {
		model.addAttribute("post", post);
		return "page";
	}

	@RequestMapping(value = "/post/previews", method = RequestMethod.POST)
	public String previews(HttpServletResponse response,
			HttpServletRequest request, Model model,
			final RedirectAttributes redirectAttributes) {
		int id = ServletRequestUtils.getIntParameter(request, "id", 0);
		Post post = postService.getById(id);
		CustomUtil.converStringfromByte(post);
		redirectAttributes.addFlashAttribute("post", post);

		return "redirect:/post/preview";
	}
	@RequestMapping(value = "/post/edit/{id}", method = RequestMethod.GET)
	public String editPost(HttpServletResponse response,
			HttpServletRequest request, Model model, @PathVariable int id) {
		Post post = postService.getById(id);
		CustomUtil.converStringfromByte(post);
		model.addAttribute("post", post);
		return "posteditor";
	}

}
