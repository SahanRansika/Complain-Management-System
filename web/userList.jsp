<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.dto.UserDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User List</title>
    <meta charset="UTF-8" />
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen font-sans flex">

<!-- Sidebar -->
<aside class="w-64 bg-blue-800 text-white flex flex-col justify-between min-h-screen">
    <div>
        <div class="p-6 text-2xl font-bold border-b border-blue-600">Admin Panel</div>
        <nav class="mt-6 space-y-2">
            <a href="admin" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-tachometer-alt mr-2"></i> Dashboard</a>
            <a href="adminUser" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-users mr-2"></i> Users</a>
            <a href="#" class="block px-6 py-2 hover:bg-blue-700"><i class="fas fa-cogs mr-2"></i> Settings</a>
        </nav>
    </div>
    <div class="p-4 border-t border-blue-600 text-center">
        <p class="text-sm">&copy; 2025 CMS</p>
    </div>
</aside>

<!-- Main Content Area -->
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
            <img src="https://static.vecteezy.com/system/resources/previews/003/689/228/non_2x/online-registration-or-sign-up-login-for-account-on-smartphone-app-user-interface-with-secure-password-mobile-application-for-ui-web-banner-access-cartoon-people-illustration-vector.jpg"
                 class="w-10 h-10 rounded-full" alt="Admin">
            <form action="logout" method="get">
                <button class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700">
                    Logout
                </button>
            </form>
        </div>
    </header>

    <!-- Content -->
    <main class="max-w-4xl mx-auto my-8 bg-white p-6 rounded-lg shadow-md w-full">
        <h2 class="text-lg font-semibold text-gray-700 mb-4">All Registered Users</h2>

        <table class="min-w-full text-sm text-left text-gray-700 border">
            <thead class="bg-blue-600 text-white">
            <tr>
                <th class="px-4 py-2">ID</th>
                <th class="px-4 py-2">Username</th>
                <th class="px-4 py-2">Role</th>
                <th class="px-4 py-2 text-center">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (UserDTO u : users) {
            %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-2"><%= u.getId() %></td>
                <td class="px-4 py-2"><%= u.getUsername() %></td>
                <td class="px-4 py-2 capitalize"><%= u.getRole() %></td>
                <td class="px-4 py-2 text-center">
                    <form action="users" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');" class="inline">
                        <input type="hidden" name="userId" value="<%= u.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="4" class="text-center px-4 py-4 text-gray-500">No users found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </main>

</div>
</body>
</html>
