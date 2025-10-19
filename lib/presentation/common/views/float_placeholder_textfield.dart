import 'package:flutter/cupertino.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class FloatedPlaceholderTextField extends StatefulWidget {
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  FloatedPlaceholderTextField({
    super.key,
    required this.placeholder,
    required this.onChanged,
    this.maxLength,
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
    widget._controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() => setState(() {});
  void _handleTextChange() {
    setState(() {});
    if (widget.onChanged != null) {
      widget.onChanged!(widget._controller.text);
    }
  }

  bool get _isEditing =>
      widget._focusNode.hasFocus || widget._controller.text.isNotEmpty;

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
          autofocus: true,
          maxLength: widget.maxLength,
          controller: widget._controller,
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
