package org.zerock.controller;

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
	public String loginInput(String error, String logout, Model model) {
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout Complete");
		}
		
		return "account/customLogin";
	}
	
	@GetMapping("/customLogout")
	public String logoutGet() {
		log.info("custom logout");
		return "account/customLogout";
	}
	
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
	
	@GetMapping("/customProfile")
	public String getProfile() {
		log.info("custom profile");
		return "account/customProfile";
	}
}
