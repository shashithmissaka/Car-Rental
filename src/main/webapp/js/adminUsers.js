
//Show success alert if update was successful
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('updateSuccess')) {
        Swal.fire({
            title: 'Success!',
            text: 'User details updated successfully!',
            icon: 'success',
            timer: 2000,
            showConfirmButton: false
        }).then(() => {
            window.location.href = "adminUsers.jsp"; // Reload the page after 2 seconds
        });
    }
    if (urlParams.has('updateError')) {
        Swal.fire({
            title: 'Error!',
            text: 'Failed to update user details. Please try again.',
            icon: 'error',
            timer: 2000,
            showConfirmButton: false
        });
    }
});

    // Handle Edit Modal population
    document.querySelectorAll('.edit-user-btn').forEach(button => {
        button.addEventListener('click', function () {
            document.getElementById('username').value = this.getAttribute('data-username');
            document.getElementById('phone').value = this.getAttribute('data-phone');
            document.getElementById('nic').value = this.getAttribute('data-nic');
            document.getElementById('email').value = this.getAttribute('data-email');
        });
    });

    // Delete User function
   // Corrected Delete User function
function deleteUser(username) {
    Swal.fire({
        title: 'Are you sure?',
        text: 'You won\'t be able to revert this!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "deleteUserServlet?username=" + username; // Ensure the correct servlet URL
        }
    });
}

 // Show success alert if delete was successful
    document.addEventListener("DOMContentLoaded", function () {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('deleteSuccess')) {
            Swal.fire({
                title: 'Deleted!',
                text: 'User deleted successfully!',
                icon: 'success',
                timer: 2000,
                showConfirmButton: false
            }).then(() => {
                window.location.href = "adminUsers.jsp"; // Reload the page after 2 seconds
            });
        }
        if (urlParams.has('deleteError')) {
            Swal.fire({
                title: 'Error!',
                text: 'Failed to delete user. Please try again.',
                icon: 'error',
                timer: 2000,
                showConfirmButton: false
            });
        }
    });


    // Search Users
    document.getElementById('searchInput').addEventListener('keyup', function () {
        var searchText = this.value.toLowerCase();
        document.querySelectorAll('.user-card').forEach(card => {
            var text = card.innerText.toLowerCase();
            card.style.display = text.includes(searchText) ? "block" : "none";
        });
    });

