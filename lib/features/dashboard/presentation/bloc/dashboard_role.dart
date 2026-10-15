enum DashboardRole {
  lessee,
  vendor,
  agent;

  static DashboardRole fromQuery(String? value) {
    return switch (value) {
      'vendor' => DashboardRole.vendor,
      'agent' => DashboardRole.agent,
      _ => DashboardRole.lessee,
    };
  }
}
