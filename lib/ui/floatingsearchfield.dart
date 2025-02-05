import 'package:flutter/material.dart';

class FloatingSearchField extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback onClose;

  const FloatingSearchField({
    Key? key,
    required this.onChanged,
    required this.onClose,
  }) : super(key: key);

  @override
  State<FloatingSearchField> createState() => _FloatingSearchFieldState();
}

class _FloatingSearchFieldState extends State<FloatingSearchField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: GestureDetector(
        onTap: widget.onClose,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {}, // Prevents the overlay from closing when tapping the search field
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            prefixIcon: const Opacity(
                              opacity: 0.7,
                              child: Icon(Icons.search),
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xFF1DB899).withOpacity(0.3),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: widget.onChanged,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: widget.onClose,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}