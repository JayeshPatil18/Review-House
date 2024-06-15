<div align="left">
  <h1>Review House</h1>
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" style="margin-left: 10px;">
  <a href="https://play.google.com/store/apps/details?id=com.yourapp.reviewhouse">
    <img alt="Play Store" src="https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=google-play&logoColor=white" style="margin-left: 10px;">
  </a>
  <a href="https://github.com/yourusername/review-house">
    <img alt="GitHub" src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" style="margin-left: 10px;">
  </a>
</div>
</br>

Welcome to **Review House**, your go-to platform for sharing and discovering product reviews.

</br>

*Available Soon On Play Store.*

![Available Soon on Play store ](https://github.com/JayeshPatil18/Review-House/blob/master/review-house.png)

## Description

**Review House** simplifies the process of reviewing and finding reviews. From electronics to groceries, our platform lets users share experiences and insights with ease. With an intuitive interface, posting and browsing reviews is effortless, ensuring you always find the information you need.

## Features

- **Search Product Reviews**: Find specific product reviews quickly with robust search functionality.
- **Apply Filters**: Narrow down search results by brand and product category.
- **Upload Reviews**: Share your experiences by uploading reviews of products you’ve used.
- **Leaderboard of Reviewers**: Discover top reviewers in our community.
- **User Profile Dashboard**: Manage your reviews and track contributions through a personalized dashboard.

## Technology Used

- **Flutter**: For a seamless, beautiful cross-platform mobile application.
- **Firebase**: Ensuring robust and scalable backend services including authentication, database, and cloud storage.
- **Node.js**: For backend REST API services to maintain user records.

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
```

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
