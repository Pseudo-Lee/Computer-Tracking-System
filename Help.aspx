<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="CTS.Help" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help - System Overview</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f4f4f4;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        nav {
            margin: 20px 0;
            text-align: center;
        }
        nav a {
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #555;
            border-radius: 5px;
            margin: 0 5px;
        }
        nav a:hover {
            background-color: #666;
        }
        .container {
            width: 80%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            border-bottom: 2px solid #333;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }
        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
        }
        .sidebar {
            background-color: #f4f4f4;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h3 {
            margin-top: 0;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            margin: 10px 0;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #555;
        }
        .sidebar ul li a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <h1>System Help and Overview</h1>
    </header>
    <nav>
        <a href="Main.aspx">Back to Main</a>
    </nav>
    <div class="container">
        <div class="section">
            <h2>System Overview</h2>
            <p>Welcome to the system help page. This system is designed to manage and streamline various aspects of student and computer management. Below is a detailed overview of its features and functionalities:</p>
            <ul>
                <li><strong>Student Management:</strong> View, add, edit, and delete student records. You can also search for students based on various attributes such as ID, name, or email.</li>
                <li><strong>Computer Management:</strong> Register new computers and assign them to students. Manage computer details and track assignments.</li>
                <li><strong>Reporting:</strong> Generate comprehensive reports on students and computers. Reports can include summaries, detailed listings, and export options.</li>
                <li><strong>User Roles:</strong> Manage user roles and permissions. Admins can access all features, while non-admins have limited access based on their role.</li>
                <li><strong>System Configuration:</strong> Configure system settings including database connections, user preferences, and system updates.</li>
            </ul>
        </div>

        <div class="section">
            <h2>Navigation</h2>
            <p>Use the links below to navigate to different sections of the system:</p>
            <div class="sidebar">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="Learners.aspx">Student Management</a></li>
                    <li><a href="Computers.aspx">Computer Management</a></li>
                    <li><a href="Users.aspx">User Management</a></li>
                   
                    <li><a href="Main.aspx">Main page</a></li>
                </ul>
            </div>
        </div>

        <div class="section">
            <h2>System Requirements</h2>
            <p>The system requires the following:</p>
            <ul>
                <li>Modern web browser (e.g., Chrome, Firefox, Edge)</li>
                <li>Active internet connection</li>
                <li>JavaScript enabled for interactive features</li>
                <li>Screen resolution of at least 1024x768 pixels for optimal display</li>
            </ul>
        </div>

        <div class="section">
            <h2>How to Use the System</h2>
            <p>Here is a brief guide on how to use the main features of the system:</p>
            <h3>Student Management</h3>
            <p>To manage student records, go to the Student Management page. Here you can view a list of students, search for specific records, add new students, and edit or delete existing records.</p>
            <h3>Computer Management</h3>
            <p>In the Computer Management section, you can register new computers by providing their details, and assign them to students. You can also view the list of computers and their assignments.</p>
            <h3>Reporting</h3>
            <p>Access the Reports page to generate and view reports. Reports can be filtered by date, student, or computer. You can export reports to various formats for offline use.</p>
            <h3>User Management</h3>
            <p>In User Management, you can view and manage user accounts, assign roles, and configure permissions. Ensure that the roles are properly set to restrict access as needed.</p>
        </div>

        <div class="section">
            <h2>Troubleshooting</h2>
            <p>If you encounter issues with the system, consider the following troubleshooting tips:</p>
            <ul>
                <li><strong>Page Not Loading:</strong> Ensure that your internet connection is active and that you have the latest browser updates.</li>
                <li><strong>Data Not Displaying:</strong> Check your filters and search criteria to make sure they are correct. If the issue persists, contact support.</li>
                <li><strong>Permissions Issues:</strong> Verify that your user role has the necessary permissions for the action you are trying to perform.</li>
                <li><strong>Error Messages:</strong> Refer to the system error logs or consult the support team for detailed error analysis.</li>
            </ul>
        </div>

        <div class="section">
            <h2>Contact Support</h2>
            <p>If you need further assistance or have any questions, please contact our support team:</p>
            <ul>
                <li>Email: <a href="mailto:support@example.com">support@example.com</a></li>
                <li>Phone: +1 (123) 456-7890</li>
                <li>Support Hours: Mon-Fri, 9 AM - 5 PM</li>
            </ul>
        </div>
    </div>
    <footer>
        <p>&copy; CTS. All rights reserved.</p>
    </footer>
</body>
</html>
