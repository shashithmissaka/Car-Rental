<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Rental Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
    #testimonials .card {
    background: #ffffff;
    border-radius: 12px;
    transition: transform 0.3s ease-in-out;
}

#testimonials .card:hover {
    transform: scale(1.05);
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    filter: invert(1);
}
    
       .car-types {
        text-align: center;
        padding: 40px 0;
        background-color: #f8f9fa;
            background-color: black; /* Changed to black */
            color: white; /* Added to make text visible */
    }

    .car-type-carousel {
        position: relative;
        overflow: hidden;
        height: 200px; /* Match the image height */
    }

    .car-type-item {
        position: absolute;
        width: 100%;
        text-align: center;
        transition: opacity 0.5s ease;
        opacity: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .car-type-item.active {
        opacity: 1;
    }

    .car-type-item img {
        width: 200px;
        height: 200px;
        object-fit: contain; /* Or 'cover' if you want images to fill the 240x240 area completely */
    } 
     .navbar {
        background-color: transparent; /* Start with transparent background */
        transition: background-color 0.3s ease; /* Add transition for smooth effect */
    }
    .navbar.scrolled {
        background-color: rgba(33, 37, 41, 0.9); /* Darken background on scroll */
    }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #f8f9fa !important;
        }
        .navbar-nav .nav-link {
            color: #f8f9fa !important;
            font-size: 1.1rem;
            transition: color 0.3s ease-in-out;
        }
        .navbar-nav .nav-link:hover {
            color: #17a2b8 !important;
        }
        .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.1);
        }
      .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        .hero-section {
    background: black; /* Set background color to black */
    color: white; /* Keep text white */
    text-align: center;
    padding: 20px 0;
}

        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        .btn-custom {
            background-color: #007bff;
            border-color: #007bff;
            padding: 12px 30px;
            font-size: 1.1rem;
            border-radius: 30px;
        }

        .btn-custom:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .carousel-item img {
            height: 500px;
            object-fit: cover;
        }

        .moving-text {
            background-color: #f8f9fa;
            overflow: hidden;
            padding: 10px 0;
        }

        .car-text {
            white-space: nowrap;
            animation: marquee 20s linear infinite;
        }

        .car-text span {
            font-size: 1.2rem;
            padding: 0 20px;
        }

        @keyframes marquee {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%);
            }
        }

        .services {
            padding: 80px 0;
        }

        .service-box {
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }

        .service-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .testimonials {
            background-color: #e9ecef;
            padding: 60px 0;
        }

        .testimonials p {
            font-style: italic;
            margin-bottom: 20px;
        }
            .hero-section {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    height: 40vh;
    padding-top: 80px; /* Prevent overlap with navbar */
    color: white;
    text-align: center;
    box-shadow: inset 0px 0px 50px rgba(0, 0, 0, 0.8);
}
    .hero-section h1 {
        font-size: 3 rem;
        font-weight: bold;
        text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
    }

    .hero-section p {
        font-size: 1.2rem;
        margin-bottom: 25px;
        opacity: 0.9;
    }

    .btn-custom {
        background: #007bff;
        border: none;
        padding: 14px 35px;
        font-size: 1.2rem;
        border-radius: 50px;
        transition: all 0.3s ease;
        box-shadow: 0px 4px 10px rgba(0, 123, 255, 0.3);
    }

    .btn-custom:hover {
        background: #0056b3;
        transform: translateY(-3px);
        box-shadow: 0px 6px 15px rgba(0, 86, 179, 0.5);
    }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">Car Rental Service</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#testimonials">Testimonials</a>
                    </li>
                    
                   <li class="nav-item">
<a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#contactUsModal">Contact Us</a>
    
</li>

                </ul>
                <div class="d-flex ms-lg-3">
                    <a href="userLogin.jsp" class="btn btn-outline-light me-2">Log In</a>
                    <a href="userRegister.jsp" class="btn btn-primary">Sign Up</a>
                </div>
            </div>
        </div>
    </nav>    
<div class="hero-section">
    <h1>Drive Your Dreams</h1>
    <p>Explore the city with our premium car rental service.</p>
    <a href="userLogin.jsp" class="btn btn-primary btn-custom">
        <i class="bi bi-car-front-fill"></i> Book Now
    </a>
</div>
<section id="car-types" class="car-types section">
    <div class="container">
        <div class="car-type-carousel">
            <div class="car-type-item active"><img src="images/car/client-1.png" alt="Luxury Cars"></div>
            <div class="car-type-item"><img src="images/car/client-2.png" alt="SUVs"></div>
            <div class="car-type-item"><img src="images/car/client-3.png" alt="Sports Cars"></div>
            <div class="car-type-item"><img src="images/car/client-4.png" alt="Economy Cars"></div>
            <div class="car-type-item"><img src="images/car/client-5.png" alt="Hatchback Cars"></div>
            <div class="car-type-item"><img src="images/car/client-6.png" alt="Convertible Cars"></div>
            <div class="car-type-item"><img src="images/car/client-7.png" alt="Electric Cars"></div>
            <div class="car-type-item"><img src="images/car/client-8.png" alt="Hybrid Cars"></div>
    
        </div>
    </div>
    </section>
<section id="hero" class="hero section bg-dark text-white py-5">
    <div class="container">
        <div class="row justify-content-center text-center">
            <div class="col-xl-6 col-lg-8">
                <h2 class="fw-bold">Reliable & Affordable Rides with <br><span class="text-warning">Mega City Cab</span></h2>
                <p class="lead">Your trusted partner for safe and comfortable travel.</p>
            </div>
        </div>

        <div class="row gy-4 mt-5 justify-content-center">
            <div class="col-xl-2 col-md-4">
                <div class="card text-center shadow-lg border-0">
                    <div class="card-body">
                        <i class="bi bi-car-front text-primary display-5"></i>
                        <h5 class="mt-3 fw-semibold"><a href="#" class="text-dark text-decoration-none">Wide Range of Vehicles</a></h5>
                    </div>
                </div>
            </div>

            <div class="col-xl-2 col-md-4">
                <div class="card text-center shadow-lg border-0">
                    <div class="card-body">
                        <i class="bi bi-cash-coin text-success display-5"></i>
                        <h5 class="mt-3 fw-semibold"><a href="#" class="text-dark text-decoration-none">Affordable Pricing</a></h5>
                    </div>
                </div>
            </div>

            <div class="col-xl-2 col-md-4">
                <div class="card text-center shadow-lg border-0">
                    <div class="card-body">
                        <i class="bi bi-geo-alt text-danger display-5"></i>
                        <h5 class="mt-3 fw-semibold"><a href="#" class="text-dark text-decoration-none">Convenient Locations</a></h5>
                    </div>
                </div>
            </div>

            <div class="col-xl-2 col-md-4">
                <div class="card text-center shadow-lg border-0">
                    <div class="card-body">
                        <i class="bi bi-clock-history text-warning display-5"></i>
                        <h5 class="mt-3 fw-semibold"><a href="#" class="text-dark text-decoration-none">24/7 Customer Support</a></h5>
                    </div>
                </div>
            </div>

            <div class="col-xl-2 col-md-4">
                <div class="card text-center shadow-lg border-0">
                    <div class="card-body">
                        <i class="bi bi-shield-check text-info display-5"></i>
                        <h5 class="mt-3 fw-semibold"><a href="#" class="text-dark text-decoration-none">Safe & Insured Rides</a></h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

    <section id="services" class="services text-center">
        <div class="container">
            <h2 class="mb-4">Our Services</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="service-box">
                        <i class="bi bi-star-fill text-warning mb-3" style="font-size: 2rem;"></i>
                        <h3>Luxury Cars</h3>
                        <p>Experience premium comfort and style with our luxury cars.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-box">
                        <i class="bi bi-cash-coin text-success mb-3" style="font-size: 2rem;"></i>
                        <h3>Affordable Rentals</h3>
                        <p>Best budget-friendly car rental options for your needs.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-box">
                        <i class="bi bi-headset text-primary mb-3" style="font-size: 2rem;"></i>
                        <h3>24/7 Support</h3>
                        <p>We're here to assist you anytime, anywhere.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

  <section id="testimonials" class="testimonials text-center py-5 bg-light">
    <div class="container">
        <h2 class="fw-bold mb-4 text-dark">What Our Customers Say</h2>

        <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="card border-0 shadow-lg p-4 mx-auto" style="max-width: 600px;">
                        <div class="card-body">
                            <i class="bi bi-quote display-4 text-primary"></i>
                            <p class="lead fst-italic">"Best car rental service ever! Smooth process and great cars."</p>
                            <h5 class="fw-bold mt-3 text-dark">- Shashith Missaka</h5>
                        </div>
                    </div>
                </div>
                
                <div class="carousel-item">
                    <div class="card border-0 shadow-lg p-4 mx-auto" style="max-width: 600px;">
                        <div class="card-body">
                            <i class="bi bi-quote display-4 text-success"></i>
                            <p class="lead fst-italic">"Affordable rates and excellent customer support."</p>
                            <h5 class="fw-bold mt-3 text-dark">- Nuwan Bandara</h5>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Carousel controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
            </button>
        </div>
    </div>
</section>

<div class="modal fade" id="contactUsModal" tabindex="-1" aria-labelledby="contactUsLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contactUsLabel">Contact Us</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea class="form-control" id="message" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) { // Adjust the scroll threshold as needed
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const carousel = document.querySelector('.car-type-carousel');
        const items = carousel.querySelectorAll('.car-type-item');
        let currentIndex = 0;

        function showNextItem() {
            items[currentIndex].classList.remove('active');
            currentIndex = (currentIndex + 1) % items.length;
            items[currentIndex].classList.add('active');
        }

        // Initially show the first item
        items[currentIndex].classList.add('active');

        // Set interval to show next item every 1 second
        setInterval(showNextItem, 2000);
    });
</script>
    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>