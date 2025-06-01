/// The direction in which the radius should be applied.
enum RadiusDirection {
  /// The radius will be applied inward, towards the center of the ticket.
  inward,

  /// The radius will be applied outward, away from the center of the ticket.
  outward,
}

/// The corner of the ticket that the radius should be applied to.
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

/// The radius of the ticket.
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
