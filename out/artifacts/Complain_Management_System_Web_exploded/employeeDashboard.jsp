<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.dto.ComplaintDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Employee Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 h-screen flex font-sans">

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
            <img src="https://static.vecteezy.com/system/resources/previews/003/689/228/non_2x/online-registration-or-sign-up-login-for-account-on-smartphone-app-user-interface-with-secure-password-mobile-application-for-ui-web-banner-access-cartoon-people-illustration-vector.jpg" class="w-10 h-10 rounded-full" alt="Employee">
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
                <i class="fas fa-plus mr-1"></i> User Complaint
            </a>
        </div>

        <div class="mb-4">
            <h2 class="text-lg font-semibold text-gray-700">All Complaints</h2>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
                <thead class="bg-blue-600 text-white">
                <tr>
                    <th class="py-3 px-4">ID</th>
                    <th class="py-3 px-4">Title</th>
                    <th class="py-3 px-4">Description</th>
                    <th class="py-3 px-4">Status</th>
                    <th class="py-3 px-4">Remarks</th>
                </tr>
                </thead>
                <tbody class="text-gray-700">
                <%
                    List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");
                    if (complaints != null && !complaints.isEmpty()) {
                        for (ComplaintDTO c : complaints) {
                %>
                <tr class="border-b hover:bg-gray-50">
                    <td class="py-3 px-4"><%= c.getId() %></td>
                    <td class="py-3 px-4"><%= c.getTitle() %></td>
                    <td class="py-3 px-4"><%= c.getDescription() %></td>
                    <td class="py-3 px-4"><%= c.getStatus() %></td>
                    <td class="py-3 px-4"><%= c.getRemarks() != null ? c.getRemarks() : "" %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="5" class="text-center py-4">No complaints found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

</body>
</html>
