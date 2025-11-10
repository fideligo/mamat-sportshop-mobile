import 'package:flutter/material.dart';
import 'package:mamatsportshop_mobile/models/app_bar.dart';
import 'package:mamatsportshop_mobile/models/form_widget.dart';
import 'package:mamatsportshop_mobile/models/left_drawer.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers for reading values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  // category and isFeatured
  String _category = 'boots'; // default value
  bool _isFeatured = false;

  final List<String> _categories = [
    'jersey',
    'boots',
    'ball',
    'goalkeeper gear',
    'accessories',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Price is required';
    final cleaned = value.replaceAll(',', '').trim();
    final num? parsed = num.tryParse(cleaned);
    if (parsed == null) return 'Enter a valid number';
    if (parsed <= 0) return 'Price must be greater than zero';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBarWidget(title: "Add Product"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey, // single form key for entire page
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                FormWidget(
                  title: "Name",
                  hint: "Product Name",
                  helperText: "Give your product a short and clear name.",
                  requiredField: true,
                  controller: _nameController,
                ),
                const SizedBox(height: 12),

                // Description (multiline)
                FormWidget(
                  title: 'Description',
                  hint: 'Write a short and clear description of your product.',
                  helperText:
                      'Give your product a short and clear description.',
                  controller: _descController,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 6,
                ),
                const SizedBox(height: 12),

                // Price
                FormWidget(
                  title: 'Price',
                  hint: 'Enter price (e.g. 150000)',
                  requiredField: true,
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: _priceValidator,
                ),
                const SizedBox(height: 12),

                // Category (Dropdown) — FormWidget does not cover dropdown, so use DropdownButtonFormField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                      ),
                      items: _categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(
                                cat[0].toUpperCase() + cat.substring(1),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue ?? _category;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Thumbnail
                FormWidget(
                  title: 'Thumbnail URL',
                  hint: 'URL Thumbnail (optional)',
                  controller: _thumbnailController,
                  requiredField: false,
                ),
                const SizedBox(height: 12),

                // Is Featured
                SwitchListTile(
                  title: const Text("Featured"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // Save button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF4F46E5),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If valid, read values
                        final name = _nameController.text.trim();
                        final desc = _descController.text.trim();
                        final price = _priceController.text.trim();
                        final thumbnail = _thumbnailController.text.trim();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product saved'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $name'),
                                    Text('Description: $desc'),
                                    Text('Price: $price'),
                                    Text(
                                      'Category: ${_category[0].toUpperCase() + _category.substring(1)}',
                                    ),
                                    Text(
                                      'Thumbnail: ${thumbnail.isEmpty ? "None" : thumbnail}',
                                    ),
                                    Text(
                                      'Featured: ${_isFeatured ? "True" : "False"}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );

                        // reset form and controllers
                        _formKey.currentState!.reset();
                        _nameController.clear();
                        _descController.clear();
                        _priceController.clear();
                        _thumbnailController.clear();
                        setState(() {
                          _category = _categories.first;
                          _isFeatured = false;
                        });
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
