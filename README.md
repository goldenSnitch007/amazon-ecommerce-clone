

***

# Flutter Full-Stack Amazon Clone

A feature-rich, end-to-end e-commerce mobile application built with Flutter for the frontend and a powerful Node.js backend. This project demonstrates the complete lifecycle of a modern e-commerce platform, from user authentication and product browsing to a full-featured admin panel for inventory and order management.

---

## ✨ Key Features

### 🧔‍♂️ Admin Panel
*   **Product Management (CRUD):**
    *   View all products in an organized list.
    *   Add new products with detailed forms.
    *   **Live Image Uploading:** Select images from the device, upload them to **Cloudinary CDN**, and link them to products.
    *   Delete products from the store.
*   **Order Management:**
    *   View a complete list of all customer orders.
    *   Update the status of an order through a step-by-step tracker.
*   **Dedicated Admin Dashboard:** A separate, secure interface for all management tasks.

### 🛍️ Customer Storefront
*   **Secure Authentication:**
    *   Email & Password Sign-Up and Sign-In.
    *   **Persistent Auth State** using secure token storage.
*   **Product Discovery:**
    *   **Home Screen:** Features a "Deal of the Day" dynamically selected based on product ratings.
    *   **Category Filtering:** Browse products by tapping on different categories.
    *   **Search:** A fully functional search bar that queries the backend API.
*   **Complete E-Commerce Lifecycle:**
    *   **Product Details:** A detailed view of each product with all images, a description, and an average rating.
    *   **Product Rating:** A 5-star rating system.
    *   **Shopping Cart:** Add, view, and adjust item quantities with real-time updates.
    *   **Checkout Flow:** Add and save a shipping address before placing an order.
    *   **Order Placement:** Place a final order, which is saved to the database, reduces product stock, and clears the user's cart.
    *   **Order History:** View a complete history of all past orders on the account screen.

---

## 🛠️ Tech Stack & Architecture

*   **Frontend:** Flutter (Dart)
    *   **State Management:** Provider
    *   **Key Packages:** `http`, `file_picker`, `cloudinary_public`, `flutter_rating_bar`
*   **Backend:** Node.js, Express.js
    *   **Database:** MongoDB Atlas with Mongoose
    *   **Authentication:** JSON Web Tokens (JWT)
    *   **Image Hosting:** Cloudinary API

---

## ⚙️ Setup and Installation

### **Prerequisites**
*   Flutter SDK
*   Node.js
*   MongoDB Atlas Account (for the connection URI)
*   Cloudinary Account (for Cloud Name, API Key/Secret, and Upload Preset)

### **1. Backend Server Setup**
```bash
# 1. Navigate to the server directory
cd server

# 2. Install dependencies
npm install

# 3. Create a .env file in the /server directory and add the following variables:
# MONGO_URI=YOUR_MONGODB_ATLAS_CONNECTION_STRING
# JWT_SECRET=passwordKey
# CLOUDINARY_CLOUD_NAME=YOUR_CLOUDINARY_CLOUD_NAME
# CLOUDINARY_API_KEY=YOUR_CLOUDINARY_API_KEY
# CLOUDINARY_API_SECRET=YOUR_CLOUDINARY_API_SECRET

# 4. Run the server
node index.js
```
The server will now be running at `http://localhost:3001`.

### **2. Frontend Client Setup**
```bash
# 1. Navigate to the client directory
cd client

# 2. Install Flutter packages
flutter pub get

# 3. Configure the API URI
# Open lib/constants/global_variables.dart and set the `uri` variable to your computer's local IP address.
# Example: String uri = 'http://192.168.1.10:3001';

# 4. Configure Cloudinary credentials
# Open lib/features/admin/services/admin_service.dart and replace the placeholder values in the CloudinaryPublic() constructor with your Cloud Name and Upload Preset.
# Example: final cloudinary = CloudinaryPublic('your-cloud-name', 'your-upload-preset');

# 5. Run the app on an emulator or a physical device
flutter run
```

> This project demonstrates a comprehensive understanding of full-stack mobile development, integrating a robust backend with a polished, feature-rich Flutter frontend.