package local.cms.web.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import local.cms.web.models.Post;
import local.cms.web.models.User;
import local.cms.web.services.UserService;

@Controller
public class MainAdminController {

	UserService userService;

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String main(ModelMap modelMap) {
		User user = new User();
		modelMap.addAttribute("userForm", user);

		List<User> userList = userService.listUsers();

		modelMap.addAttribute("userList", userList);
		return "admin";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homePage(ModelMap modelMap) {
		modelMap.addAttribute("post", new Post());
		return "home";
	}
}
