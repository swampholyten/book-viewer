# **book-viewer**

## **Overview**  
The book-viewer is a simple iOS application built with **SwiftUI**. The app integrates features such as **user registration**, **like functionality**, **FaceID authentication**, and a **map-based discovery tool**.  

The backend server for fetching e-book data is hosted as a separate GitHub project. You can find it [here](https://github.com/swampholyten/book-viewer-server).  

---

## **Features**  

### **Core Features**  
- **Fetch E-Books:** Retrieve e-books dynamically from the server.  
- **Save Books:** Save books.  
- **Like Feature:** Mark your favorite books with a like.  
- **User Authentication:** Secure registration and login system with **FaceID** support.  

---

## **Tech Stack**  
- **SwiftUI:** For designing the user interface.  
- **SwiftData:** For local data storage.  
- **MapKit:** For map-based location features.  
- **FaceID:** For authentication.  
- **HTTP Networking:** Fetches book data from the [backend server](https://github.com/swampholyten/book-viewer-server).

---

## **Setup and Installation**  

### **Prerequisites**  
- macOS with Xcode 15 or later installed.  
- Swift 5.9 or later.  

### **Installation Steps**  
1. Clone this repository:  
   ```bash  
   git clone https://github.com/swampholyten/book-viewer.git
   cd book-viewer  
   ```  
2. Clone the backend server project and follow its setup instructions:  
   [Backend Server GitHub Link](https://github.com/swampholyten/book-viewer-server).  

3. Open the project in Xcode:  
   ```bash  
   open BookViewer.xcodeproj  
   ```  
4. Build and run the project on a simulator or a physical device.  

---

## **Usage**  
1. Register or log in using the authentication system.  
2. Browse and fetch e-books from the server.  
3. Save your favorite books.  

---

## **Contributing**  
Contributions are welcome! Please follow these steps to contribute:  
1. Fork the repository.  
2. Create a feature branch (`git checkout -b feature-name`).  
3. Commit your changes (`git commit -m 'Add a new feature'`).  
4. Push to the branch (`git push origin feature-name`).  
5. Open a pull request.  

---

## **License**  
This project is licensed under the MIT License. See the LICENSE file for details.  

---
