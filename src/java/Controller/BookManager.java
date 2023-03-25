/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Book;
import Model.Category;
import context.BookDAO;
import context.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/* @author ACER */
public class BookManager extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        String bid = request.getParameter("bid");
        CategoryDAO cd = new CategoryDAO();
                ArrayList<Category> cates = cd.getCategories();
                request.setAttribute("cates", cates);
        BookDAO dao = new BookDAO();
        if (service == null) {
            service = "control panel";
        }
        switch (service) {
            case "add":
                request.setAttribute("service", "Add");
                request.getRequestDispatcher("/admin/add.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("service", "Edit");
                request.setAttribute("s", dao.getBookById(Integer.parseInt(bid)));
                request.getRequestDispatcher("/admin/add.jsp").forward(request, response);
                break;
            case "del":
                dao.deleteBook(Integer.parseInt(bid));
                response.sendRedirect("BookManager");
                break;
            default:
                
                ArrayList<Book> books = dao.getBooks();
                String xpage = request.getParameter("xpage");
                int page;
                if (xpage == null) {
                    page = 1;
                } else {
                    page = Integer.parseInt(xpage);
                }
                int size = books.size();
                int numPage = (size % 5 == 0) ? (size / 5) : (size / 5 + 1);
                int start = (page - 1) * 5;
                int end = Math.min(size, start + 5);
                ArrayList<Book> listpage = dao.getByPage(books, start, end);
                request.setAttribute("xpage", page);
                request.setAttribute("numPage", numPage);
                request.setAttribute("books", listpage);
                request.getRequestDispatcher("/admin/bookmanager.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bid = request.getParameter("bid");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int cid = Integer.parseInt(request.getParameter("cid"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        float price = Float.parseFloat(request.getParameter("price"));
        int discount = Integer.parseInt(request.getParameter("discount"));
        boolean issale = (request.getParameter("issale") != null);
        String description = request.getParameter("description");
        String img = request.getParameter("image");
        CategoryDAO cd = new CategoryDAO();
                ArrayList<Category> cates = cd.getCategories();
                request.setAttribute("cates", cates);
        BookDAO dao = new BookDAO();
        switch (request.getParameter("in")) {
            case "Add":
                if (dao.addBook(title, author, cid, stock, price, issale, discount, img, description) == 0) {
                    request.setAttribute("error", "Add Failed! Please try again!");
                    request.setAttribute("s", new Book(0, title, author, cid, stock, price, issale, discount, img, description));
                    request.getRequestDispatcher("/admin/add.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Add Successfully!");
                    request.setAttribute("service", "Add");
                    request.getRequestDispatcher("/admin/add.jsp").forward(request, response);
                }
                break;
            case "Edit":
                dao.editBook(Integer.parseInt(bid),title, author, cid, stock, price, issale, discount, img, description);
                request.setAttribute("error", "Book Edited!");
                request.setAttribute("service", "Edit");
                request.setAttribute("s", new Book(Integer.parseInt(bid), title, author, cid, stock, price, issale, discount, img, description));
                request.getRequestDispatcher("/admin/add.jsp").forward(request, response);
                break;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
