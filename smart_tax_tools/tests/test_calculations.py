from smart_tax.calculations import calculate_tax, calculate_net_income


def test_calculate_tax():
    assert calculate_tax(income=1000, rate=6) == 60
    assert calculate_tax(income=0, rate=6) == 0
    assert calculate_tax(income=1_000_000, rate=10) == 100_000


def test_calculate_net_income():
    assert calculate_net_income(total_amount=1_000_000,
                                tax_rate=10,
                                fee_rate=100_000) == 800_000
    assert calculate_net_income(0, 10, 100_000) == 0
    assert calculate_net_income(1_000, 10, 100_000) == 0
