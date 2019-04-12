library badges;

import 'package:badges/src/badge_position.dart';
import 'package:badges/src/badge_positions.dart';
import 'package:badges/src/badge_shape.dart';
import 'package:flutter/material.dart';

class BadgeIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int itemCount;
  final Color badgeColor;
  final Icon icon;
  final bool hideZeroCount;
  final bool toAnimate;
  final BadgePosition position;
  final BadgeShape shape;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Duration animationDuration;

  BadgeIconButton(
      {Key key,
      @required this.itemCount,
      @required this.icon,
      this.onPressed,
      this.hideZeroCount: true,
      this.badgeColor: Colors.red,
      this.toAnimate: true,
      this.position: BadgePosition.topRight,
      this.shape: BadgeShape.circle,
      this.textStyle: const TextStyle(
        fontSize: 13.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      this.padding: const EdgeInsets.all(5.0),
      this.animationDuration: const Duration(milliseconds: 500)})
      : assert(itemCount >= 0),
        assert(badgeColor != null),
        super(key: key);

  @override
  BadgeIconButtonState createState() {
    return BadgeIconButtonState();
  }
}

class BadgeIconButtonState extends State<BadgeIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.hideZeroCount && widget.itemCount == 0) {
      return IconButton(
        icon: widget.icon,
        onPressed: widget.onPressed,
      );
    }

    return IconButton(
        icon: Stack(
          overflow: Overflow.visible,
          children: [
            widget.icon,
            BadgePositioned(
              position: widget.position,
              child: widget.toAnimate
                  ? SlideTransition(
                      position: _badgePositionTween.animate(_animation),
                      child: _getBadge())
                  : _getBadge(),
            ),
          ],
        ),
        onPressed: widget.onPressed);
  }

  Widget _getBadge() {
    return Material(
        type: widget.shape == BadgeShape.circle
            ? MaterialType.circle
            : MaterialType.card,
        elevation: 2.0,
        color: widget.badgeColor,
        child: Padding(
          padding: widget.padding,
          child: Text(
            widget.itemCount.toString(),
            style: widget.textStyle,
          ),
        ));
  }

  @override
  void didUpdateWidget(BadgeIconButton oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }
}

class BadgeMenuIconButton<T> extends StatefulWidget {
  final int itemCount;
  final Color badgeColor;
  final Icon icon;
  final bool hideZeroCount;
  final bool toAnimate;
  final BadgePosition position;
  final BadgeShape shape;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Duration animationDuration;
  final PopupMenuItemBuilder<T> itemBuilder;
  final PopupMenuItemSelected<T> onSelected;
  final PopupMenuCanceled popupMenuCanceled;

  BadgeMenuIconButton(
      {Key key,
        @required this.itemCount,
        @required this.icon,
        @required this.itemBuilder,
        this.onSelected,
        this.popupMenuCanceled,
        this.hideZeroCount: true,
        this.badgeColor: Colors.red,
        this.toAnimate: true,
        this.position: BadgePosition.topRight,
        this.shape: BadgeShape.circle,
        this.textStyle: const TextStyle(
          fontSize: 13.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        this.padding: const EdgeInsets.all(5.0),
        this.animationDuration: const Duration(milliseconds: 500)})
      : assert(itemCount >= 0),
        assert(badgeColor != null),
        super(key: key);

  @override
  BadgeMenuIconButtonState createState() {
    return BadgeMenuIconButtonState();
  }
}

class BadgeMenuIconButtonState extends State<BadgeMenuIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.hideZeroCount && widget.itemCount == 0) {
      return PopupMenuButton(
        icon: widget.icon,
        onSelected: widget.onSelected,
        onCanceled: widget.popupMenuCanceled,
        itemBuilder: widget.itemBuilder,
      );
    }

    return PopupMenuButton(
        onSelected: widget.onSelected,
        onCanceled: widget.popupMenuCanceled,
        itemBuilder: widget.itemBuilder,
        child: Stack(
          fit: StackFit.passthrough,
          overflow: Overflow.visible,
          children: [
            Padding(
              child: widget.icon,
              padding: EdgeInsets.only(right: 8),
            ),
            Positioned(
              top: -2.0, left: 12.0,
              child: widget.toAnimate
                  ? SlideTransition(
                  position: _badgePositionTween.animate(_animation),
                  child: _getBadge())
                  : _getBadge(),
            ),
          ],
        ),);
  }

  Widget _getBadge() {
    return
      Material(
          type: widget.shape == BadgeShape.circle
              ? MaterialType.circle
              : MaterialType.card,
          elevation: 2.0,
          color: widget.badgeColor,
          child: Padding(
            padding: widget.padding,
            child: Text(
              widget.itemCount.toString(),
              style: widget.textStyle,
            ),
          ));
  }

  @override
  void didUpdateWidget(BadgeMenuIconButton oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }
}
