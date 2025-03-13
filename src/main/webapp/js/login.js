document.addEventListener("DOMContentLoaded", function () {

    function validateLoginForm() {
        var username = document.getElementById("username").value.trim();
        var password = document.getElementById("password").value.trim();

        if (username === "") {
            Swal.fire({
                title: "Error",
                text: "Username cannot be empty!",
                icon: "error",
                confirmButtonText: "OK",
                background: "#2a2a2a",
                color: "#ffffff",
                confirmButtonColor: "#f8b400",
                width: "300px",
                padding: "10px"
            });
            return false;
        }

        if (password === "") {
            Swal.fire({
                title: "Error",
                text: "Password cannot be empty!",
                icon: "error",
                confirmButtonText: "OK",
                background: "#2a2a2a",
                color: "#ffffff",
                confirmButtonColor: "#f8b400",
                width: "300px",
                padding: "10px"
            });
            return false;
        }

        return true;
    }

    function showAlert(title, text, icon) {
        Swal.fire({
            title: title,
            text: text,
            icon: icon,
            confirmButtonText: "OK",
            background: "#2a2a2a",
            color: "#ffffff",
            confirmButtonColor: "#f8b400",
            width: "300px",
            padding: "10px"
        });
    }

    const urlParams = new URLSearchParams(window.location.search);

    const errorMessage = urlParams.get("error");
    if (errorMessage) {
        showAlert("Error", errorMessage, "error");
    }

    const serverErrorMessageElement = document.getElementById("error-message-data");
    if (serverErrorMessageElement) {
        const serverErrorMessage = serverErrorMessageElement.textContent.trim();
        if (serverErrorMessage) {
            showAlert("Error", serverErrorMessage, "error");
        }
    }

    if (urlParams.get("message") === "registered") {
        showAlert("Registration Successful!", "You have successfully registered. Please log in.", "success");
    } else if (urlParams.get("message") === "logout") {
        showAlert("Logged Out", "You have been successfully logged out.", "success");
    }

});
