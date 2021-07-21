package com.koreait.dooboo;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.koreait.dooboo.util.SecurityUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/" , "index","api/index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		//logger.info("Welcome home! The client locale is {}.", locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		session.setAttribute("firstVisit", 0);
		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@GetMapping("chat")
	public String chat() {
		return "chat/sell";
	}

	@GetMapping("receive.do")
	public String receive() {
		return "chat/receive";
	}

	@GetMapping("send.do")
	public String send() {
		return "chat/send";
	}
	@GetMapping("product")
	public String product() {
		return "product/productList";
	}
}
