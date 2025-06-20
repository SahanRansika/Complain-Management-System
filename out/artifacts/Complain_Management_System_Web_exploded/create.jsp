<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Create New Complaint</title>
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="bg-white rounded-lg shadow-lg w-full max-w-xl p-8">
  <div class="mb-6 text-center">
    <h2 class="text-2xl font-bold text-blue-700">
      <i class="fas fa-plus-circle mr-2"></i>Create New Complaint
    </h2>
    <p class="text-gray-500 text-sm mt-1">Fill the form below to submit a new complaint</p>
  </div>

  <form action="<%= request.getContextPath() %>/complaint" method="post" onsubmit="return validateForm();">
    <div class="mb-4">
      <label class="block text-gray-700 font-medium mb-2" for="title">
        <i class="fas fa-heading mr-1"></i>Title
      </label>
      <input type="text" name="title" id="title" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required>
    </div>

    <div class="mb-4">
      <label class="block text-gray-700 font-medium mb-2" for="description">
        <i class="fas fa-align-left mr-1"></i>Description
      </label>
      <textarea name="description" id="description" rows="5" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required></textarea>
    </div>

    <div class="flex justify-end gap-3 mt-6">
      <a href="admin" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
        <i class="fas fa-arrow-left mr-1"></i>Back
      </a>
      <button type="submit" class="bg-green-600 text-white px-5 py-2 rounded hover:bg-green-700">
        <i class="fas fa-paper-plane mr-1"></i>Submit Complaint
      </button>
    </div>
  </form>
</div>

<script>
  function validateForm() {
    const title = document.getElementById("title").value.trim();
    const desc = document.getElementById("description").value.trim();
    if (title === "" || desc === "") {
      alert("Please fill in all fields.");
      return false;
    }
    return true;
  }
</script>

</body>
</html>
