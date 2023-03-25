/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.User;
import context.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* @author ACER */
public class UserController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String submit = request.getParameter("submit");
        if(submit!=null){
        switch(submit){
            case "Submit":
                HttpSession session = request.getSession();
                User user =  (User)session.getAttribute("user");
                UserDAO dao = new UserDAO();
                dao.updateUser(user.getId(),name, phone, address);
                user.setName(name);
                user.setPhone(phone);
                user.setAddress(address);
                session.setAttribute("user", user);
                request.setAttribute("mes", "Information changed!");
                break;
            case "Reset":
                break;
        }}
        request.getRequestDispatcher("/views/user/user_profile.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        String submit = request.getParameter("submit");
        switch(submit){
            case "Submit":
                UserDAO dao = new UserDAO();
                HttpSession session = request.getSession();
                    User user =  (User)session.getAttribute("user");
                if(!dao.checkOldPass(user.getId(),oldpass)){
                    request.setAttribute("errold", "Wrong password!");
                }else{
                    dao.changePassword(user.getId(), newpass);
                    user.setPassword(newpass);
                    session.setAttribute("user", user);
                    request.setAttribute("message", "Password changed!");
                }
                break;
            case "Reset":
                break;
        }
        request.getRequestDispatcher("/views/user/user_profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
