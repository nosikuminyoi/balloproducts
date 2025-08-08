import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  
  List<Product> _allProducts = [];
  List<String> _categories = [];
  
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  List<Product> get filteredProducts {
    var products = _allProducts;
    
    // Apply category filter
    if (_selectedCategory != 'All') {
      products = products.where((product) => product.category == _selectedCategory).toList();
    }
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      products = products.where((product) {
        return product.title.toLowerCase().contains(query) ||
               product.description.toLowerCase().contains(query) ||
               product.category.toLowerCase().contains(query);
      }).toList();
    }
    
    return products;
  }

  // Getters
  List<Product> get allProducts => _allProducts;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    await _loadInitialData();
  }

  // Load all initial data
  Future<void> _loadInitialData() async {
    _setLoading(true);
    _error = null;
    
    try {
      // Load products and categories
      final results = await Future.wait([
        _productService.getProducts(),
        _productService.getCategories(),
      ]);
      
      _allProducts = results[0] as List<Product>;
      _categories = ['All', ...(results[1] as List<String>)];
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load data: ${e.toString()}';
      _allProducts = [];
      _categories = ['All'];
    } finally {
      _setLoading(false);
    }
  }

  // Set selected category
  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  // Set search query
  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }

  // Clear user search query
  void clearSearch() {
    setSearchQuery('');
  }

  // Refresh all data
  Future<void> refresh() async {
    await _loadInitialData();
  }

  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }
  
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
}