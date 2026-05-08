def calculate_tax(income: int | float, rate: float | int) -> float:
    tax = income * (rate / 100)
    return tax

def calculate_net_income(total_amount: float | int, tax_rate: float | int, fee_rate: float = 0) -> float:
    tax = calculate_tax(income=total_amount, rate=tax_rate)
    net_income = total_amount - tax - fee_rate
    return max(net_income, 0)
