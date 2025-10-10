import 'package:flutter/cupertino.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class FloatedPlaceholderTextField extends StatefulWidget {
  final String? placeholder;
  final TextEditingController controller;
  final _focusNode = FocusNode();

  FloatedPlaceholderTextField({
    super.key,
    required this.placeholder,
    required this.controller,
  });

  @override
  State<FloatedPlaceholderTextField> createState() =>
      _FloatedPlaceholderTextFieldState();
}

class _FloatedPlaceholderTextFieldState
    extends State<FloatedPlaceholderTextField> {
  @override
  void initState() {
    super.initState();
    widget._focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() => setState(() {});
  void _handleTextChange() => setState(() {});

  bool get _isEditing =>
      widget._focusNode.hasFocus || widget.controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 150);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: duration,
          curve: Curves.easeInOut,
          top: _isEditing ? -16 : 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: AnimatedDefaultTextStyle(
              duration: duration,
              curve: Curves.easeInOut,
              style: TextStyle(
                color: _isEditing
                    ? HarubeeColor.mainText(Appearance.light)
                    : HarubeeColor.textSecondary(Appearance.light),
                fontSize: _isEditing ? 12 : 18,
                fontWeight: FontWeight.w500,
              ),
              child: Text(widget.placeholder ?? ""),
            ),
          ),
        ),
        CupertinoTextField(
          controller: widget.controller,
          focusNode: widget._focusNode,
          style: TextStyle(
            color: HarubeeColor.textPrimary(Appearance.light),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: HarubeeColor.mainSecondary(Appearance.light),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
