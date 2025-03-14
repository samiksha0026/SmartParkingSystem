<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="SmartPArkingSystem.Home" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Parking System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <style>
        /* Global Styles */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Poppins', sans-serif; 
            background-color: #f4f4f4; 
            color: #333;
            overflow-x: hidden;
        }
        
        /* Color Palette */
        :root {
            --primary-blue: #002244;
            --secondary-blue: #003366;
            --accent-blue: #0066cc;
            --light-blue: #e6f2ff;
            --beige: #f7f4e9;
            --white: #ffffff;
            --gray: #f4f4f4;
            --dark-text: #333333;
            --success-green: #28a745;
        }

        .section-title {
            position: relative;
            font-size: 28px;
            margin-bottom: 40px;
            text-align: center;
            color: var(--primary-blue);
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: -10px;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--accent-blue);
        }
        
        /* Header Styles */
        header {
            background: var(--white);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            z-index: 1000;
            padding: 12px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s;
        }
        
        header.scrolled {
            padding: 8px 5%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo h1 {
            font-size: 22px;
            font-weight: 700;
            color: var(--primary-blue);
            letter-spacing: 0.5px;
        }
        
        .logo img {
            height: 60px;
            width: 120px;
            border-radius: 8px;
        }
        
        .navbar {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .navbar a {
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            color: var(--dark-text);
            transition: 0.3s;
            position: relative;
        }
        
        .navbar a:not(.login-btn):after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent-blue);
            transition: 0.3s;
        }
        
        .navbar a:not(.login-btn):hover:after {
            width: 100%;
        }
        
        .navbar a:hover { 
            color: var(--accent-blue); 
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
        }
        
        .login-btn {
            padding: 10px 20px;
            background-color: var(--accent-blue);
            color: var(--white) !important;
            text-decoration: none;
            border-radius: 6px;
            font-size: 15px;
            transition: 0.3s;
            border: 2px solid var(--accent-blue);
        }
        
        .login-btn:hover { 
            background-color: var(--secondary-blue); 
            border-color: var(--secondary-blue);
            transform: translateY(-2px);
        }
        
        .admin-btn {
            padding: 10px 20px;
            background-color: transparent;
            color: var(--accent-blue) !important;
            text-decoration: none;
            border-radius: 6px;
            font-size: 15px;
            transition: 0.3s;
            border: 2px solid var(--accent-blue);
        }
        
        .admin-btn:hover {
            background-color: var(--accent-blue);
            color: var(--white) !important;
            transform: translateY(-2px);
        }
        
        /* Mobile Menu */
        .mobile-menu-toggle {
            display: none;
            font-size: 24px;
            color: var(--primary-blue);
            cursor: pointer;
        }
        
        /* Hero Section */
        #hero {
            height: 85vh;
            display: flex;
            align-items: center;
            background: linear-gradient(to right, rgba(247, 244, 233, 0.9) 50%, rgba(0, 34, 68, 0.7) 100%), 
                        url('images/stacked-parking.jpg') no-repeat center center/cover;
            position: relative;
            padding: 0 5%;
            margin-top: 0;
        }
        
        .hero-content {
            max-width: 550px;
            padding: 40px 0;
            animation: fadeInUp 1s ease-out;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .hero-content h2 {
            font-size: 42px;
            font-weight: bold;
            margin-bottom: 20px;
            color: var(--primary-blue);
        }
        
        .hero-content p {
            font-size: 18px;
            margin-bottom: 30px;
            line-height: 1.7;
            color: var(--dark-text);
        }
        
        /* Buttons */
        .cta-btn {
            padding: 14px 30px;
            background-color: var(--accent-blue);
            color: var(--white);
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
            display: inline-block;
            border: 2px solid var(--accent-blue);
            box-shadow: 0 4px 6px rgba(0, 102, 204, 0.25);
        }
        
        .cta-btn:hover { 
            background-color: var(--secondary-blue); 
            border-color: var(--secondary-blue);
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 102, 204, 0.3);
        }
        
        .secondary-btn {
            padding: 14px 30px;
            background-color: transparent;
            color: var(--accent-blue);
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
            display: inline-block;
            border: 2px solid var(--accent-blue);
            margin-left: 15px;
        }
        
        .secondary-btn:hover {
            background-color: var(--accent-blue);
            color: var(--white);
            transform: translateY(-3px);
        }
        
        /* How It Works Section */
        #how-it-works {
            padding: 80px 5%;
            text-align: center;
            background-color: var(--white);
            position: relative;
        }
        
        .steps {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .step {
            background: var(--light-blue);
            padding: 30px;
            border-radius: 12px;
            width: 300px;
            text-align: center;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.08);
            transition: 0.3s;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(0, 102, 204, 0.1);
        }
        
        .step:hover {
            transform: translateY(-5px);
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.12);
        }
        
        .step::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--accent-blue);
        }
        
        .step i {
            font-size: 36px;
            margin-bottom: 20px;
            color: var(--accent-blue);
            background: var(--light-blue);
            width: 80px;
            height: 80px;
            line-height: 80px;
            border-radius: 50%;
            display: inline-block;
            box-shadow: 0 4px 10px rgba(0, 102, 204, 0.2);
        }
        
        .step h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }
        
        .step p {
            color: var(--dark-text);
            line-height: 1.6;
        }
        
        /* Features Section */
        #features {
            padding: 80px 5%;
            text-align: center;
            background-color: var(--light-blue);
            position: relative;
        }
        
        .features {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .feature {
            background: var(--white);
            padding: 30px;
            border-radius: 12px;
            width: 300px;
            text-align: center;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.08);
            transition: 0.3s;
            border-bottom: 4px solid transparent;
        }
        
        .feature:hover {
            transform: translateY(-5px);
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.12);
            border-bottom: 4px solid var(--accent-blue);
        }
        
        .feature i {
            font-size: 32px;
            margin-bottom: 20px;
            color: var(--accent-blue);
            transition: 0.3s;
        }
        
        .feature:hover i {
            transform: scale(1.2);
        }
        
        .feature h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }
        
        .feature p {
            color: var(--dark-text);
            line-height: 1.6;
        }

        /* Parking Solutions Section */
        #parking-solutions {
            padding: 80px 5%;
            background-color: var(--white);
            text-align: center;
        }
        
        .solutions-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 40px;
        }
        
        .solution-box {
            width: 350px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
            background: var(--white);
        }
        
        .solution-box:hover {
            transform: translateY(-8px);
            box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .solution-image {
            height: 220px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .solution-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30%;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
        }
        
        .solution-content {
            padding: 25px;
        }
        
        .solution-content h3 {
            font-size: 20px;
            margin-bottom: 12px;
            color: var(--primary-blue);
        }
        
        .solution-content p {
            color: var(--dark-text);
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .solution-btn {
            display: inline-block;
            padding: 8px 20px;
            background-color: var(--accent-blue);
            color: var(--white);
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: 0.3s;
        }
        
        .solution-btn:hover {
            background-color: var(--secondary-blue);
        }

        /* Testimonials Section */
        #testimonials {
            padding: 80px 5%;
            background-color: var(--light-blue);
            text-align: center;
        }
        
        .testimonials-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 40px;
        }
        
        .testimonial {
            background: var(--white);
            padding: 30px;
            border-radius: 12px;
            width: 350px;
            text-align: left;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.08);
            position: relative;
        }
        
        .testimonial::before {
            content: '\201C';
            font-family: Georgia, serif;
            font-size: 80px;
            position: absolute;
            top: -20px;
            left: 20px;
            color: rgba(0, 102, 204, 0.1);
        }
        
        .testimonial-content {
            font-style: italic;
            margin-bottom: 20px;
            line-height: 1.6;
            color: var(--dark-text);
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        
        .testimonial-author img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
            object-fit: cover;
        }
        
        .author-info h4 {
            margin: 0;
            color: var(--primary-blue);
        }
        
        .author-info p {
            color: #666;
            font-size: 14px;
        }
        
        /* Stats Section */
        #stats {
            padding: 60px 5%;
            background-color: var(--primary-blue);
            color: var(--white);
            text-align: center;
        }
        
        .stats-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 40px;
        }
        
        .stat-item {
            margin: 20px;
            min-width: 200px;
        }
        
        .stat-number {
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 10px;
            color: var(--white);
        }
        
        .stat-text {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        /* Footer Styles */
        footer {
            background: var(--primary-blue);
            color: var(--white);
            padding: 60px 5% 30px;
        }
        
        .footer-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .footer-section {
            flex: 1;
            min-width: 250px;
        }
        
        .footer-section h3 {
            margin-bottom: 20px;
            font-size: 20px;
            position: relative;
            padding-bottom: 12px;
            color: var(--white);
        }
        
        .footer-section h3:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: var(--accent-blue);
        }
        
        .footer-about p {
            line-height: 1.6;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .footer-section ul {
            list-style: none;
        }
        
        .footer-section ul li {
            margin-bottom: 12px;
        }
        
        .footer-section ul li a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: 0.3s;
            display: block;
        }
        
        .footer-section ul li a:hover {
            color: var(--accent-blue);
            padding-left: 5px;
        }
        
        .contact-info li {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .contact-info li i {
            margin-right: 15px;
            color: var(--accent-blue);
            font-size: 18px;
            margin-top: 3px;
        }
        
        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .social-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            color: var(--white);
            transition: 0.3s;
            font-size: 18px;
        }
        
        .social-icon:hover {
            background: var(--accent-blue);
            transform: translateY(-3px);
        }
        
        .copyright {
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
        }
        
        /* Button Back to Top */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--accent-blue);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            z-index: 100;
            opacity: 0;
            visibility: hidden;
            transition: 0.3s;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        
        .back-to-top.show {
            opacity: 1;
            visibility: visible;
        }
        
        .back-to-top:hover {
            background: var(--secondary-blue);
            transform: translateY(-3px);
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .step, .feature {
                width: 240px;
            }
            
            #hero {
                background: linear-gradient(to right, rgba(247, 244, 233, 0.9) 100%, rgba(0, 34, 68, 0.7) 100%), 
                        url('images/stacked-parking.jpg') no-repeat center center/cover;
            }
        }
        
        @media (max-width: 768px) {
            header {
                padding: 15px;
            }
            
            .navbar {
                position: fixed;
                top: 70px;
                left: -100%;
                width: 100%;
                height: calc(100vh - 70px);
                background: var(--white);
                flex-direction: column;
                align-items: center;
                gap: 20px;
                padding: 30px 0;
                transition: 0.3s;
                box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
            }
            
            .navbar.active {
                left: 0;
            }
            
            .mobile-menu-toggle {
                display: block;
            }
            
            #hero {
                height: auto;
                padding: 100px 20px 60px;
                text-align: center;
                background: linear-gradient(rgba(247, 244, 233, 0.9), rgba(247, 244, 233, 0.9)), 
                            url('images/stacked-parking.jpg') no-repeat center center/cover;
            }
            
            .hero-content {
                max-width: 100%;
            }
            
            .hero-content h2 {
                font-size: 32px;
            }
            
            .steps, .features, .solutions-container, .testimonials-container {
                flex-direction: column;
                align-items: center;
            }
            
            .step, .feature {
                width: 100%;
                max-width: 350px;
            }
            
            .footer-container {
                flex-direction: column;
                gap: 30px;
            }
            
            .footer-section {
                width: 100%;
            }
        }
        #hero {
    width: 100%;
    padding: 60px 0;
    background-color: #f7f4e9; /* Light background color */
}

.hero-container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    align-items: center;
}

.hero-content {
    flex: 1;
    padding-right: 40px;
}

.hero-image {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: auto;
}

.hero-image img {
    margin-top: 50px;
    width: 700px; /* Set your desired width */
    height: 480px; /* Set your desired height */
    object-fit: cover; /* Ensures the image maintains aspect ratio while covering the area */
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    display: block;
    margin-left: auto;
}


.cta-btn, .secondary-btn {
    display: inline-block;
    margin-top: 20px;
    margin-right: 15px;
    padding: 12px 24px;
    border-radius: 4px;
    text-decoration: none;
    font-weight: bold;
}

.cta-btn {
    background-color: #002244;
    color: white;
}

.secondary-btn {
    background-color: transparent;
    color: #002244;
    border: 2px solid #002244;
}
    </style>
</head>
<body>
    <header id="header">
        <div class="logo">
            <a href="Home.aspx"><img src="images/LogoHome.jpg" alt="Smart Parking Logo"></a>
            <h1>Smart Parking System</h1>
        </div>
        <div id="navbar" class="navbar">
            <a href="Home.aspx">Home</a>
            <a href="#about us">About Us</a>
            <a href="#features">Key Features</a>
            <div class="action-buttons">
                <a href="Login.aspx" class="login-btn">Log In</a>
                <a href="Admin/AdminLogin.aspx" class="admin-btn">Admin</a>
            </div>
        </div>
        <div class="mobile-menu-toggle" id="mobile-toggle">
            <i class="fas fa-bars"></i>
        </div>
    </header>

   <section id="hero">
    <div class="hero-container">
        <div class="hero-content">
            <h2>Smart Parking Solution for Modern Cities</h2>
            <p>Find parking spaces, book your spot, and pay with ease using our innovative Smart Parking System that makes parking hassle-free in today's busy urban environments.</p>
            <a href="BookParking.aspx" class="cta-btn">Book Now</a>
           
        </div>
        <div class="hero-image">
            <img src="images/homepagecars.jpg" alt="Smart Parking Solution">
        </div>
    </div>
</section>

    <section id="how-it-works">
        <h2 class="section-title">How It Works</h2>
        <div class="steps">
            <div class="step">
                <i class="fa-solid fa-magnifying-glass"></i>
                <h3>Search Parking</h3>
                <p>Find available parking spots in real-time with our user-friendly interface showing all nearby options.</p>
            </div>
            <div class="step">
                <i class="fa-solid fa-book"></i>
                <h3>Book Your Spot</h3>
                <p>Reserve your parking in advance with ease, securing your space before you even arrive.</p>
            </div>
            <div class="step">
                <i class="fa-solid fa-credit-card"></i>
                <h3>Secure Payment</h3>
                <p>Pay safely using online transactions with multiple payment options including UPI, cards, and digital wallets.</p>
            </div>
        </div>
    </section>

    <section id="features">
        <h2 class="section-title">Key Features</h2>
        <div class="features">
            <div class="feature">
                <i class="fa-solid fa-clock"></i>
                <h3>Real-Time Availability</h3>
                <p>Check available parking spaces in real-time with accurate occupancy data updated every minute.</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-bookmark"></i>
                <h3>Easy Booking</h3>
                <p>Reserve your parking space in just a few clicks with our intuitive booking interface.</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-lock"></i>
                <h3>Secure Payment</h3>
                <p>Make cashless payments securely using UPI, credit cards, or mobile wallets.</p>
            </div>
            <div class="feature">
                <i class="fa-solid fa-map-location-dot"></i>
                <h3>GPS Navigation</h3>
                <p>Get turn-by-turn directions to your reserved parking spot with our integrated GPS system.</p>
            </div>
        </div>
    </section>

    

    <section id="stats">
        <h2 class="section-title" style="color: white;">Our Impact</h2>
        <div class="stats-container">
            <div class="stat-item">
                <div class="stat-number">50,000+</div>
                <div class="stat-text">Happy Users</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">100+</div>
                <div class="stat-text">Parking Locations</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">95%</div>
                <div class="stat-text">Customer Satisfaction</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">30%</div>
                <div class="stat-text">Reduced Congestion</div>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-container">
            <div class="footer-section footer-about">
                <h3>About Us</h3>
                <p>Smart Parking System is dedicated to transforming the parking experience through innovative technology solutions that make finding and paying for parking easier than ever.</p>
                <div class="social-icons">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#about us">About Us</a></li>
                    <li><a href="#key features">Key Features</a></li>
                    <li><a href="BookParking.aspx">Book Parking</a></li>
                    <li><a href="Login.aspx">Login</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3>Contact Us</h3>
                <ul class="contact-info">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Pune, Maharashtra</span>
                    </li>
                    <li>
                        <i class="fas fa-phone"></i>
                        <span>+91 9763855943</span>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <span>thoratsamiksha23@gmail.com</span>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="copyright">
            <p>&copy; 2025 Smart Parking System. All Rights Reserved.</p>
        </div>
    </footer>

    <a href="#" class="back-to-top" id="back-to-top">
        <i class="fas fa-chevron-up"></i>
    </a>

    <script>
        // Mobile Menu Toggle
        const mobileToggle = document.getElementById('mobile-toggle');
        const navbar = document.getElementById('navbar');
        
        mobileToggle.addEventListener('click', () => {
            navbar.classList.toggle('active');
            mobileToggle.querySelector('i').classList.toggle('fa-bars');
            mobileToggle.querySelector('i').classList.toggle('fa-times');
        });
        
        // Header Scroll Effect
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
            
            // Back to Top Button
            const backToTop = document.getElementById('back-to-top');
            if (window.scrollY > 300) {
                backToTop.classList.add('show');
            } else {
                backToTop.classList.remove('show');
            }
        });
        
        // Back to Top Click Event
        document.getElementById('back-to-top').addEventListener('click', (e) => {
            e.preventDefault();
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
        
        // Smooth Scrolling for Anchor Links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                if (this.getAttribute('href') !== '#') {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        window.scrollTo({
                            top: target.offsetTop - 80,
                            behavior: 'smooth'
                        });
                        
                        // Close mobile menu if open
                        if (navbar.classList.contains('active')) {
                            navbar.classList.remove('active');
                            mobileToggle.querySelector('i').classList.toggle('fa-bars');
                            mobileToggle.querySelector('i').classList.toggle('fa-times');
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>