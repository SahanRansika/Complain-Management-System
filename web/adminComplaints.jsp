<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.dto.ComplaintDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome CDN -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 h-screen flex font-sans">

<!-- Sidebar -->
<aside class="w-64 bg-blue-800 text-white flex flex-col justify-between">
    <div>
        <div class="p-6 text-2xl font-bold border-b border-blue-600">Admin Panel</div>
        <nav class="mt-6 space-y-2">
            <a href="#" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-tachometer-alt mr-2"></i> Dashboard</a>
            <a href="adminUser" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-tachometer-alt mr-2"></i> Users</a>
           <a href="#" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-cogs mr-2"></i> Settings</a>
        </nav>
    </div>
    <div class="p-4 border-t border-blue-600">
        <p class="text-sm">&copy; 2025 CMS</p>
    </div>
</aside>

<!-- Main content -->
<div class="flex-1 flex flex-col">

    <!-- Top Bar -->
    <header class="bg-white shadow px-6 py-4 flex justify-between items-center">
        <h1 class="text-xl font-semibold text-gray-800">Welcome To Complaint Management</h1>
        <div class="flex items-center gap-4">
            <%
                String username = (String) session.getAttribute("username");
                if (username == null) {
                    username = "User";
                }
            %>

            <span class="text-gray-700 font-medium"><%= username %></span>

            <img src="https://static.vecteezy.com/system/resources/previews/003/689/228/non_2x/online-registration-or-sign-up-login-for-account-on-smartphone-app-user-interface-with-secure-password-mobile-application-for-ui-web-banner-access-cartoon-people-illustration-vector.jpg" class="w-10 h-10 rounded-full" alt="Admin">
            <form action="logout" method="get">
                <button class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700">
                    <i class="fas fa-sign-out-alt mr-1"></i> Logout
                </button>
            </form>
        </div>
    </header>

    <!-- Content -->
    <main class="p-6 overflow-y-auto">
        <!-- Create Button -->
        <div class="flex justify-end mb-4">
            <a href="create.jsp" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                <i class="fas fa-plus mr-1"></i> Admin Complaint
            </a>
        </div>

        <!-- Complaints Table -->
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
                <thead class="bg-blue-600 text-white">
                <tr>
                    <th class="py-3 px-4 text-left">ID</th>
                    <th class="py-3 px-4 text-left">User ID</th>
                    <th class="py-3 px-4 text-left">Title</th>
                    <th class="py-3 px-4 text-left">Description</th>
                    <th class="py-3 px-4 text-left">Status</th>
                    <th class="py-3 px-4 text-left">Remarks</th>
                    <th class="py-3 px-4 text-left">Actions</th>
                </tr>
                </thead>
                <tbody class="text-gray-700">
                <%
                    List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");
                    if (complaints != null) {
                        for (ComplaintDTO c : complaints) {
                %>
                <tr class="border-b hover:bg-gray-50">
                    <form action="admin" method="post">
                        <td class="py-3 px-4"><%= c.getId() %></td>
                        <td class="py-3 px-4"><%= c.getUserId() %></td>
                        <td class="py-3 px-4"><%= c.getTitle() %></td>
                        <td class="py-3 px-4"><%= c.getDescription() %></td>
                        <td class="py-3 px-4">
                            <select name="status" class="border px-2 py-1 rounded w-full">
                                <option value="pending" <%= c.getStatus().equals("pending") ? "selected" : "" %>>Pending</option>
                                <option value="in_progress" <%= c.getStatus().equals("in_progress") ? "selected" : "" %>>In Progress</option>
                                <option value="resolved" <%= c.getStatus().equals("resolved") ? "selected" : "" %>>Resolved</option>
                            </select>
                        </td>
                        <td class="py-3 px-4">
                            <input type="text" name="remarks" class="border px-2 py-1 w-full rounded" value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>">
                        </td>
                        <td class="py-3 px-4 flex gap-2">
                            <!-- Update Button -->
                            <form action="admin" method="post">
                                <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                                <input type="hidden" name="status" value="<%= c.getStatus() %>">
                                <input type="hidden" name="remarks" value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>">
                                <input type="hidden" name="action" value="update">
                                <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Update</button>
                            </form>

                            <!-- Delete Button -->
                            <form action="admin" method="post" onsubmit="return confirm('Are you sure you want to delete this complaint?')">
                                <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
                            </form>
                        </td>

                    </form>
                </tr>

                <% } } else { %>
                <tr><td colspan="7" class="text-center py-4">No complaints found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>

</div>
</body>
</html>
