# Ballo Products

An intuitive shopping platform for discovering and managing your favorite products.
## Video Demo
https://drive.google.com/file/d/1B0Pp1ivtxKW-I125HP75VE0ncp0TgZ1s/view?usp=sharing 

## Features

The app includes:
- Product listing screen
- Search functionality
- Category filtering
- Product detail screen
- Product image view standalone view

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator / Physical Device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd balloproducts
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── product.dart         # Product data model
├── providers/
│   └── product_provider.dart # State management
├── services/
│   └── product_service.dart  # API service
├── screens/
│   ├── fullscreen_image_screen.dart    # Product image view
│   ├── product_list_screen.dart    # Main product listing
│   └── product_detail_screen.dart  # Product details
└── widgets/
    ├── product_card.dart     # Product card component
    ├── search_bar.dart       # Search functionality
    └── category_filter.dart  # Category filtering
```

## Dependencies

- **http**: For API calls
- **provider**: State management
- **cached_network_image**: Image caching
- **shimmer**: Loading animations
- **shared_preferences**: Local storage
- **cupertino_icons**: icons

## API

The app uses the [FakeStore API](https://fakestoreapi.com/) to fetch product data:
- Products: `https://fakestoreapi.com/products`
- Categories: `https://fakestoreapi.com/products/categories`
- Product by ID: `https://fakestoreapi.com/products/{id}`

## State Management

The app uses the Provider pattern for state management:
- `ProductProvider`: Manages product data, search, filtering, and loading states
- Efficient updates with `notifyListeners()`
- Separation of concerns between UI and business logic

## Error Handling

- Network error handling
- API error responses
- Image loading errors
- Graceful fallbacks
- User-friendly error messages

## Performance Optimizations

- Image caching with `cached_network_image`
- Efficient list rendering
- Lazy loading
- Optimized state updates
- Memory management

## Future Enhancements

- User authentication
- Shopping cart functionality
- Wishlist feature
- Product reviews
- Push notifications (Would work great if there is a product discount)
- Payment integration