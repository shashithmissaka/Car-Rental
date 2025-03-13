 window.onload = function() {
        function getGreeting() {
            const hours = new Date().getHours();
            if (hours < 12) return "Good Morning,";
            else if (hours < 18) return "Good Afternoon,";
            else return "Good Evening,";
        }
        
        document.getElementById("greeting").innerText = getGreeting();

        const currentPage = window.location.pathname.split("/").pop();
        const pageMapping = {
            "adminUsers.jsp": "usersLink",
            "adminBookings.jsp": "bookingsLink",
            "adminCars.jsp": "carsLink",
            "adminPayments.jsp": "paymentsLink",
            "adminDrivers.jsp": "driversLink",
            "adminBills.jsp": "billsLink"
        };
        
        const pageTitleMapping = {
            "adminUsers.jsp": "Manage Users",
            "adminBookings.jsp": "Manage Bookings",
            "adminCars.jsp": "Manage Cars",
            "adminPayments.jsp": "Manage Payments",
            "adminDrivers.jsp": "Manage Drivers",
            "adminBills.jsp": "Manage Bills"
        };
        
        document.getElementById("pageTitle").innerText = pageTitleMapping[currentPage] || "Admin Panel";
        if (pageMapping[currentPage]) {
            document.getElementById(pageMapping[currentPage]).classList.add("active");
        }
    };