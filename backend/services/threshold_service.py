def evaluate_pulse(pulse: int) -> str:
    """
    Evaluates the pulse rate against physiological thresholds.
    Single responsibility logic.
    """
    if pulse < 50 or pulse > 120:
        return "critical"
    elif pulse < 60 or pulse > 100:
        return "warning"
    return "normal"
