# Review House

Welcome to **Review House**, your go-to platform for sharing and discovering product reviews.

## Screenshots
*Available Soon On Play Store.*

![Available Soon on Play store ](https://github.com/JayeshPatil18/Review-House/blob/master/review-house.png)

## Description

**Review House** is designed to make reviewing and finding reviews as simple as possible. Our platform covers a wide range of products, from electronics to groceries, providing a space for users to share their experiences and insights. With an intuitive interface, posting and browsing reviews is effortless, ensuring that you can always find the information you need.

## Features

- **Search Product Reviews**: Easily find reviews for specific products by using our robust search functionality.
- **Apply Filters**: Narrow down your search results by applying filters for brands and product categories.
- **Upload Reviews**: Share your own experiences by uploading reviews of products you’ve used.
- **Leaderboard of Reviewers**: See who the top reviewers are in our community with our leaderboard feature.
- **User Profile Dashboard**: Manage your reviews and track your contributions through a personalized dashboard.

## Technology Used

- **Flutter**: For building the cross-platform mobile application with a seamless and beautiful user interface.
- **Firebase**: For backend services including authentication, database, and cloud storage to ensure a robust and scalable application.
- **Node.js**: For backend REST api services to maintain records of users.

## Project Structure

We follow a clean architecture approach to ensure a scalable and maintainable codebase. Below is an overview of our project structure:

```plaintext
lib
│
├── constants
│   ├── utils
│   ├── routes
│
├── features
│   ├── authentication
│   │   ├── data
│   │   │   └── repository
│   │   ├── domain
│   │   │   └── entities
│   │   ├── presentation
│   │       ├── bloc
│   │       ├── provider
│   │       ├── pages
│   │       └── widgets
│   │
│   ├── review
│       ├── data
│       │   └── repository
│       ├── domain
│       │   └── entities
│       ├── presentation
│           ├── bloc
│           ├── provider
│           ├── pages
│           └── widgets


## Getting Started

To get started with **Review House**, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/JayeshPatil18/Review-House.git

1. **Install dependencies**:
   ```bash
   flutter pub get

1. **Run applicatoin**:
   ```bash
   flutter run
