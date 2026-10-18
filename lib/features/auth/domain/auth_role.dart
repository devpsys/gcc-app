enum AuthRole { agent, lessee, vendor }

AuthRole? authRoleFromStorage(String? raw) {
  return switch (raw) {
    'agent' => AuthRole.agent,
    'lessee' => AuthRole.lessee,
    'vendor' => AuthRole.vendor,
    _ => null,
  };
}
