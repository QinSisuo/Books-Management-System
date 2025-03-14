//package com.book.controller;
//
//import com.book.domain.User;
//import com.book.domain.ReaderInfo;
//import com.book.service.LoginService;
//import com.book.service.ReaderCardService;
//import com.book.service.ReaderInfoService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import javax.servlet.http.HttpServletRequest;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.List;
//
//@Controller
//public class ReaderController {
//
//    private ReaderInfoService readerInfoService;
//    @Autowired
//    public void setReaderInfoService(ReaderInfoService readerInfoService) {
//        this.readerInfoService = readerInfoService;
//    }   private LoginService loginService;
//
//
//    @Autowired
//    public void setLoginService(LoginService loginService) {
//        this.loginService = loginService;
//    }
//    private ReaderCardService readerCardService;
//
//    @Autowired
//    public void setReaderCardService(ReaderCardService readerCardService) {
//        this.readerCardService = readerCardService;
//    }
//
//    @RequestMapping("allreaders.html")
//    public ModelAndView allBooks(){
//        List<ReaderInfo> readers=readerInfoService.readerInfos();
//        ModelAndView modelAndView=new ModelAndView("admin_readers");
//        modelAndView.addObject("readers",readers);
//        return modelAndView;
//    }
//
//    @RequestMapping("reader_delete.html")
//    public String readerDelete(HttpServletRequest request,RedirectAttributes redirectAttributes){
//        int readerId= Integer.parseInt(request.getParameter("readerId"));
//        boolean success=readerInfoService.deleteReaderInfo(readerId);
//
//        if(success){
//            redirectAttributes.addFlashAttribute("succ", "删除成功！");
//        }else {
//            redirectAttributes.addFlashAttribute("error", "删除失败！");
//        }
//        return "redirect:/allreaders.html";
//
//    }
//    @RequestMapping("/reader_info.html")
//    public ModelAndView toReaderInfo(HttpServletRequest request) {
//        User user = (User) request.getSession().getAttribute("user"); // 替换 ReaderCard 为 User
//        ReaderInfo readerInfo = readerInfoService.getReaderInfo(user.getUserId());
//        ModelAndView modelAndView = new ModelAndView("reader_info");
//        modelAndView.addObject("readerinfo", readerInfo);
//        return modelAndView;
//    }
//
//    @RequestMapping("reader_edit.html")
//    public ModelAndView readerInfoEdit(HttpServletRequest request){
//        int readerId= Integer.parseInt(request.getParameter("readerId"));
//        ReaderInfo readerInfo=readerInfoService.getReaderInfo(readerId);
//        ModelAndView modelAndView=new ModelAndView("admin_reader_edit");
//        modelAndView.addObject("readerInfo",readerInfo);
//        return modelAndView;
//    }
//
//    @RequestMapping("reader_edit_do.html")
//    public String readerInfoEditDo(HttpServletRequest request, String name, String sex, String birth, String address, String telcode, RedirectAttributes redirectAttributes) {
//        int readerId = Integer.parseInt(request.getParameter("id"));
//        User user = loginService.findUserById(readerId); // 替换 findReaderCardByUserId
//
//        String oldName = user.getUsername(); // 替换 readerCard.getName()
//        if (!oldName.equals(name)) {
//            boolean nameUpdated = readerCardService.updateName(readerId, name); // 替换 readerCard
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            Date nbirth = new Date();
//            try {
//                nbirth = sdf.parse(birth);
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//
//            ReaderInfo readerInfo = new ReaderInfo();
//            readerInfo.setAddress(address);
//            readerInfo.setBirth(nbirth);
//            readerInfo.setName(name);
//            readerInfo.setReaderId(readerId);
//            readerInfo.setTelcode(telcode);
//            readerInfo.setSex(sex);
//
//            boolean infoUpdated = readerInfoService.editReaderInfo(readerInfo);
//            if (nameUpdated && infoUpdated) {
//                redirectAttributes.addFlashAttribute("succ", "读者信息修改成功！");
//            } else {
//                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
//            }
//            return "redirect:/allreaders.html";
//        } else {
//            // 如果只是部分信息修改
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            Date nbirth = new Date();
//            try {
//                nbirth = sdf.parse(birth);
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//
//            ReaderInfo readerInfo = new ReaderInfo();
//            readerInfo.setAddress(address);
//            readerInfo.setBirth(nbirth);
//            readerInfo.setName(name);
//            readerInfo.setReaderId(readerId);
//            readerInfo.setTelcode(telcode);
//            readerInfo.setSex(sex);
//
//            boolean infoUpdated = readerInfoService.editReaderInfo(readerInfo);
//            if (infoUpdated) {
//                redirectAttributes.addFlashAttribute("succ", "读者信息修改成功！");
//            } else {
//                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
//            }
//            return "redirect:/allreaders.html";
//        }
//    }
//
//
//}
//@PostMapping("/addUser")
//public String addUser(@ModelAttribute User user) {
//    readerCardService.addUserCard(user);  // 假设需要用到类似的 Service
//    return "redirect:/admin/user/list";  // 保存成功后跳转到用户列表页面
//}
//@RequestMapping("reader_add.html")
//public ModelAndView readerInfoAdd(){
//    ModelAndView modelAndView=new ModelAndView("admin_reader_add");
//    return modelAndView;
//
//}
////用户功能--进入修改密码页面
//@RequestMapping("reader_repasswd.html")
//public ModelAndView readerRePasswd(){
//    ModelAndView modelAndView=new ModelAndView("reader_repasswd");
//    return modelAndView;
//}
////用户功能--修改密码执行
//@RequestMapping("reader_repasswd_do.html")
//public String readerRePasswdDo(HttpServletRequest request, String oldPasswd, String newPasswd, String reNewPasswd, RedirectAttributes redirectAttributes) {
//    User user = (User) request.getSession().getAttribute("user"); // 替换 ReaderCard 为 User
//    int readerId = user.getUserId();
//    String passwd = user.getPassword();
//
//    if (newPasswd.equals(reNewPasswd)) {
//        if (passwd.equals(oldPasswd)) {
//            boolean succ = readerCardService.updatePasswd(readerId, newPasswd);
//            if (succ) {
//                User updatedUser = loginService.findUserById(readerId); // 替换 findReaderCardByUserId
//                request.getSession().setAttribute("user", updatedUser); // 替换 readercard 为 user
//                redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
//                return "redirect:/reader_repasswd.html";
//            } else {
//                redirectAttributes.addFlashAttribute("error", "密码修改失败！");
//                return "redirect:/reader_repasswd.html";
//            }
//        } else {
//            redirectAttributes.addFlashAttribute("error", "修改失败,原密码错误");
//            return "redirect:/reader_repasswd.html";
//        }
//    } else {
//        redirectAttributes.addFlashAttribute("error", "修改失败,两次输入的新密码不相同");
//        return "redirect:/reader_repasswd.html";
//    }
//}
//
////管理员功能--读者信息添加
//@RequestMapping("reader_add_do.html")
//public String readerInfoAddDo(String name,String sex,String birth,String address,String telcode,int readerId,RedirectAttributes redirectAttributes){
//    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
//    Date nbirth=new Date();
//    try{
//        java.util.Date date=sdf.parse(birth);
//        nbirth=date;
//    }catch (ParseException e){
//        e.printStackTrace();
//    }
//
//    ReaderInfo readerInfo=new ReaderInfo();
//    readerInfo.setAddress(address);
//    readerInfo.setBirth(nbirth);
//    readerInfo.setName(name);
//    readerInfo.setReaderId(readerId);
//    readerInfo.setTelcode(telcode);
//    readerInfo.setSex(sex);
//    boolean succ=readerInfoService.addReaderInfo(readerInfo);
//    boolean succc=readerCardService.addReaderCard(readerInfo);
//    List<ReaderInfo> readers=readerInfoService.readerInfos();
//    if (succ&&succc){
//        redirectAttributes.addFlashAttribute("succ", "添加读者信息成功！");
//        return "redirect:/allreaders.html";
//    }else {
//        redirectAttributes.addFlashAttribute("succ", "添加读者信息失败！");
//        return "redirect:/allreaders.html";
//    }
//}
////读者功能--读者信息修改
//@RequestMapping("reader_info_edit.html")
//public ModelAndView readerInfoEditReader(HttpServletRequest request){
//    ReaderCard readerCard=(ReaderCard) request.getSession().getAttribute("readercard");
//    ReaderInfo readerInfo=readerInfoService.getReaderInfo(readerCard.getReaderId());
//    ModelAndView modelAndView=new ModelAndView("reader_info_edit");
//    modelAndView.addObject("readerinfo",readerInfo);
//    return modelAndView;
//
//}
//@RequestMapping("reader_edit_do_r.html")
//public String readerInfoEditDoReader(HttpServletRequest request, String name, String sex, String birth, String address, String telcode, RedirectAttributes redirectAttributes) {
//    User user = (User) request.getSession().getAttribute("user"); // 替换 ReaderCard
//    int readerId = user.getUserId();
//
//    if (!user.getUsername().equals(name)) { // 替换 readerCard.getName()
//        boolean nameUpdated = readerCardService.updateName(readerId, name); // 替换 readerCard
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        Date nbirth = new Date();
//        try {
//            nbirth = sdf.parse(birth);
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//
//        ReaderInfo readerInfo = new ReaderInfo();
//        readerInfo.setAddress(address);
//        readerInfo.setBirth(nbirth);
//        readerInfo.setName(name);
//        readerInfo.setReaderId(readerId);
//        readerInfo.setTelcode(telcode);
//        readerInfo.setSex(sex);
//
//        boolean infoUpdated = readerInfoService.editReaderInfo(readerInfo);
//        if (nameUpdated && infoUpdated) {
//            User updatedUser = loginService.findUserById(readerId); // 替换 findReaderCardByUserId
//            request.getSession().setAttribute("user", updatedUser); // 替换 readercard 为 user
//            redirectAttributes.addFlashAttribute("succ", "信息修改成功！");
//            return "redirect:/reader_info.html";
//        } else {
//            redirectAttributes.addFlashAttribute("error", "信息修改失败！");
//            return "redirect:/reader_info.html";
//        }
//    } else {
//        // 仅修改其他信息
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        Date nbirth = new Date();
//        try {
//            nbirth = sdf.parse(birth);
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//
//        ReaderInfo readerInfo = new ReaderInfo();
//        readerInfo.setAddress(address);
//        readerInfo.setBirth(nbirth);
//        readerInfo.setName(name);
//        readerInfo.setReaderId(readerId);
//        readerInfo.setTelcode(telcode);
//        readerInfo.setSex(sex);
//
//        boolean infoUpdated = readerInfoService.editReaderInfo(readerInfo);
//        if (infoUpdated) {
//            User updatedUser = loginService.findUserById(readerId); // 替换 findReaderCardByUserId
//            request.getSession().setAttribute("user", updatedUser); // 替换 readercard 为 user
//            redirectAttributes.addFlashAttribute("succ", "信息修改成功！");
//        } else {
//            redirectAttributes.addFlashAttribute("error", "信息修改失败！");
//        }
//        return "redirect:/reader_info.html";
//    }
//}
//
//}
