import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize data after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ballo Products'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.08),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading products...'),
                ],
              ),
            );
          }

          // Error state
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      provider.clearError();
                      provider.refresh();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Main content
          return RefreshIndicator(
            onRefresh: provider.refresh,
            child: Column(
              children: [
                // Search Bar
                if (provider.categories.isNotEmpty)
                  ProductSearchBar(
                    searchQuery: provider.searchQuery,
                    onChanged: provider.setSearchQuery,
                    onClear: provider.clearSearch,
                  ),
                
                // Category Filter
                if (provider.categories.length > 1)
                  CategoryFilter(
                    categories: provider.categories,
                    selectedCategory: provider.selectedCategory,
                    onCategorySelected: provider.setCategory,
                  ),
                
                const SizedBox(height: 8),
                
                // Products List
                Expanded(
                  child: _buildProductsList(provider),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsList(ProductProvider provider) {
    final products = provider.filteredProducts;
    
    if (products.isEmpty) {
      return _buildEmptyState(provider);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => _navigateToProductDetail(product),
        );
      },
    );
  }

  Widget _buildEmptyState(ProductProvider provider) {
    final hasSearch = provider.searchQuery.isNotEmpty;
    final hasFilter = provider.selectedCategory != 'All';
    
    String title;
    String subtitle;
    IconData icon;
    
    if (hasSearch || hasFilter) {
      title = 'No products found';
      subtitle = 'Try adjusting your search or filters';
      icon = Icons.search_off;
    } else {
      title = 'No products available';
      subtitle = 'Check back later for new products';
      icon = Icons.inventory_2_outlined;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (hasSearch || hasFilter) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                provider.clearSearch();
                provider.setCategory('All');
              },
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear Filters'),
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToProductDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }
}