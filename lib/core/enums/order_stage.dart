/// Lifecycle of an order from kitchen to customer doorstep.
///
/// `prepared`, `onTheWay`, `delivered` are surfaced in client-facing UI;
/// the others (`arrivedPickup`, `arrivedDropoff`, `failed`) are driver-side
/// checkpoints used to drive the courier's job flow.
enum OrderStage {
  prepared,
  arrivedPickup,
  onTheWay,
  arrivedDropoff,
  delivered,
  failed,
}

/// Canonical driver-job flow between stages. Single source of truth shared by
/// the full [JobLifecycleCard] and the compact [DeliveryActionBar] so the two
/// never diverge on what the primary CTA does next.
extension OrderStageFlow on OrderStage {
  /// The stage the primary CTA advances to, or null at a terminal stage.
  OrderStage? get nextStage => switch (this) {
    OrderStage.prepared => OrderStage.arrivedPickup,
    OrderStage.arrivedPickup => OrderStage.onTheWay,
    OrderStage.onTheWay => OrderStage.arrivedDropoff,
    OrderStage.arrivedDropoff => OrderStage.delivered,
    OrderStage.delivered => null,
    OrderStage.failed => null,
  };

  /// Terminal stages (delivered / failed) — the CTA just clears the job.
  bool get isTerminal =>
      this == OrderStage.delivered || this == OrderStage.failed;
}
