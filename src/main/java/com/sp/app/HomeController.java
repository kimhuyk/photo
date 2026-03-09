package com.sp.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sp.app.domain.Photo;
import com.sp.app.service.PhotoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
    @Autowired
    private PhotoService photoService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(Locale locale, Model model, Map map) {
        logger.info("Welcome home! The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);
        model.addAttribute("serverTime", formattedDate );

        // DB에서 사진 목록 가져오기
        List<Photo> photoList = null;
        try {
            // 전체 최신 사진 목록 가져오기
            photoList = photoService.loadPhoto(map.size());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 가져온 리스트를 JSP로 넘기기
        model.addAttribute("photoList", photoList);

        return "home";
    }
}