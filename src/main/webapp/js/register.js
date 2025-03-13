document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);

    // Function to show SweetAlert popup with default colors & smaller size
    function showAlert(title, text, icon) {
        Swal.fire({
            title: title,
            text: text,
            icon: icon,
            confirmButtonText: "OK",
            background: "#2a2a2a",  // Dark gray background
            color: "#ffffff",  // White text
            confirmButtonColor: "#f8b400",  // Yellow button
            width: "300px",  // Smaller popup
            padding: "10px" // Reduce padding
        });
    }

    // Show alert if username already exists
    if (urlParams.get("error") === "username_taken") {
        showAlert("Username Already Exists!", "Please try another username.", "error");
    }

    // Show alert if email already exists
    if (urlParams.get("error") === "email_taken") {
        showAlert("Email Already Exists!", "Please try another email.", "error");
    }
});
