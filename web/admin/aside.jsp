<%@page contentType="text/html" pageEncoding="UTF-8"%>

<aside class="left-side sidebar-offcanvas" id="left-aside" style="height: 100%;">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="./admin/img/FB_IMG_1612033211042_Original.jpg" class="img-circle" alt="User Image" />
            </div>
            <div class="pull-left info">
                <p>Welcome, ${user.getName()}</p>

                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="">
                <a href="./Category">
                    <i class="fa fa-dashboard"></i> <span>Category Manager</span>
                </a>
            </li>
            <li>
                <a href="./BookManager">
                    <i class="fa fa-picture-o"></i> <span>Book Manager</span>
                </a>
            </li>
            <li>
                <a href="./OrderManager">
                    <i class="fa fa-picture-o"></i> <span>Order Manager</span>
                </a>
            </li>
            <li>
                <a href="./UserManager">
                    <i class="fa fa-picture-o"></i> <span>User Manager</span>
                </a>
            </li>
            


        </ul>
    </section>
    <!-- /.sidebar -->
</aside>