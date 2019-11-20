package org.zerock.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {

	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("access Denied: " + auth);
		model.addAttribute("msg", "Access Denied");
		return "error/access_denied";
	}
	
	@GetMapping("/customLogin")
	public String loginInput(String error, String logout, HttpServletRequest request ,Model model, Authentication auth) {
		if(auth != null) {
			return "redirect:/customProfile";
		}
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout Complete");
		}
		
		if(error == null && logout == null) {
			log.info("error: " + error +" , logout: " +logout );
			String referer = request.getHeader("Referer");
			request.getSession().setAttribute("prevPage", referer);
		}
			
		
		return "account/customLogin";
	}
	
	
	@GetMapping("/customLogout")
	public String logoutGet(Authentication auth) {
		log.info("custom logout");
		if(auth == null) {
			return "redirect:/board/list";
		}
		return "account/customLogout";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/customProfile")
	public String getProfile() {
		log.info("custom profile");
		return "account/customProfile";
	}
}
