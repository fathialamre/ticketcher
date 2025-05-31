enum RadiusDirection { inward, outward }

enum TicketCorner {
  all,
  top,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  none,
}

class TicketRadius {
  final double radius;
  final RadiusDirection direction;
  final TicketCorner corner;

  const TicketRadius({
    required this.radius,
    this.direction = RadiusDirection.inward,
    this.corner = TicketCorner.all,
  });

  static const TicketRadius zero = TicketRadius(
    radius: 0,
    corner: TicketCorner.none,
  );
}
