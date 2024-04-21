/// Represents the different layout strategies available.
///
/// This enumeration is used to determine how the layout of a widget should be handled.
enum LayoutStrategy {
  /// This strategy indicates that the layout should be handled using a [Sliver] widget.
  sliver,

  /// This strategy indicates that the layout should be handled using a regular [Box] widget.
  box,
}
