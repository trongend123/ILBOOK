/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.User;
import context.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* @author ACER */
public class SignupController extends HttpServlet {
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getParameter("origin");
        request.setAttribute("origin", referer);
        forward(request, response, "/views/auth/signup.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String key = request.getParameter("username");
        String pass = request.getParameter("password");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("birthday");
        String gender = request.getParameter("gender");
       
        UserDAO ud = new UserDAO();
        User user = new User(name, gender, dob, email, phone ,key, pass);
        if(!ud.checkDupEmail(email)){
            request.setAttribute("in4", user);
            request.setAttribute("error", "The email had already been registered!");
            request.setAttribute("origin",request.getParameter("origin"));
            forward(request, response, "/views/auth/signup.jsp");
            return;
        }
        if(!ud.checkDupUsername(key)){
            request.setAttribute("in4", user);
            request.setAttribute("error", "Existed username!");
            request.setAttribute("origin",request.getParameter("origin"));
            forward(request, response, "/views/auth/signup.jsp");
        }else{
            ud.createNewUser(name, gender, dob, email, phone ,key, pass);
            request.setAttribute("error", "Sign up successfully!");
            request.setAttribute("origin",request.getParameter("origin"));
            forward(request, response, "/views/auth/login.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }
    
}
