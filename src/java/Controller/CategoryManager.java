/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Category;
import context.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/* @author ACER */
public class CategoryManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String service = request.getParameter("service");
        String cid = request.getParameter("cid");
        CategoryDAO dao = new CategoryDAO();
        HttpSession session = request.getSession();
        if (service == null) {
            service = "control panel";
        }
        switch (service) {
            case "add":
                request.getRequestDispatcher("/admin/addcategory.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("cid", cid);
                request.setAttribute("name", dao.getCategory(Integer.parseInt(cid)));
                request.getRequestDispatcher("/admin/editcategory.jsp").forward(request, response);
                break;
            case "del":
                dao.delCategory(Integer.parseInt(cid));
                response.sendRedirect("Category");
                break;
            default:
                ArrayList<Category> cates = dao.getCategories();
                request.setAttribute("cates", cates);
                request.getRequestDispatcher("/admin/categorymanager.jsp").forward(request, response);
        }
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
        String name = request.getParameter("name");
        String cid = request.getParameter("cid");
        CategoryDAO dao = new CategoryDAO();
        if (request.getParameter("in").equals("Add")) {
            if (dao.addCategory(name) == 0) {
                request.setAttribute("error", "Add Failed! Please try again!");
                request.setAttribute("name", name);
                request.getRequestDispatcher("/admin/categorymanager.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Add Successfully!");
                request.getRequestDispatcher("/admin/categorymanager.jsp").forward(request, response);
            }
        } else {
            dao.editCategory(Integer.parseInt(cid), name);
            request.setAttribute("error", "Name Edited!");
            request.setAttribute("name", name);
            request.getRequestDispatcher("/admin/categorymanager.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
