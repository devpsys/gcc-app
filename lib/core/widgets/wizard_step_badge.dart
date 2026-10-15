/// Visual treatment of the step tracker's trailing counter chip.
///
/// The chip changes meaning as the agent moves through a step: it reads
/// `START` while the step is pristine, `1 / 4 ACTIVE` once the agent has
/// touched it, and `ATTENTION` when validation has flagged a field.
enum WizardStepBadge { start, active, attention }
