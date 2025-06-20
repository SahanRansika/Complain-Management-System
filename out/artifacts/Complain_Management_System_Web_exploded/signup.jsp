<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="bg-light">

<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div class="row w-100">
        <!-- Sign Up Form -->
        <div class="col-md-6 d-flex align-items-center justify-content-center">
            <div class="bg-white p-5 rounded shadow w-100">
                <h2 class="mb-4 text-center">Sign Up</h2>
                <!-- 🔽 SignUpServlet එකට POST කරන්න -->
                <form action="<%=request.getContextPath()%>/signup" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required autocomplete="username">
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required autocomplete="new-password">
                    </div>

                    <div class="mb-4">
                        <label for="role" class="form-label">Role</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="">Select Role</option>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary w-50 me-2">Sign Up</button>
                        <button type="button" class="btn btn-light border border-dark w-50 ms-2"
                                onclick="window.location.href='signIn.jsp'">Sign In</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Right Side Image -->
        <div class="col-md-6 d-flex align-items-center justify-content-center">
            <img src="https://static.vecteezy.com/system/resources/previews/003/689/228/non_2x/online-registration-or-sign-up-login-for-account-on-smartphone-app-user-interface-with-secure-password-mobile-application-for-ui-web-banner-access-cartoon-people-illustration-vector.jpg"
                 alt="Sign Up Illustration" class="img-fluid rounded">
        </div>
    </div>
</div>

</body>
</html>
