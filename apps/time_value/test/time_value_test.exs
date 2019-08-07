defmodule TimeValueTest do
  use ExUnit.Case
  doctest TimeValue

  test "calculates FV(P, i, n)" do
    assert TimeValue.future_value(
             with_present_value: 1000,
             with_interest_rate: 0.05,
             with_periods: 12
           ) == {:ok, 1_795.86}
  end

  test "calculates FV(A, i, n)" do
    assert TimeValue.future_value(
             with_annuity: 100,
             with_interest_rate: 0.05,
             with_periods: 10
           ) == {:ok, 1257.79}
  end

  test "calculates FV(A, i, n) paid at period end" do
    assert TimeValue.future_value(
             with_annuity: 1000,
             with_interest_rate: 0.05,
             with_periods: 5,
             with_payment_at: :end
           ) == {:ok, 5_525.63}
  end

  test "calculates FV(A, i, n) paid at period beginning" do
    assert TimeValue.future_value(
             with_annuity: 1000,
             with_interest_rate: 0.05,
             with_periods: 5,
             with_payment_at: :beginning
           ) == {:ok, 5_801.91}
  end

  test "returns error for empty FV params list" do
    assert TimeValue.future_value([]) == {:error, "incorrect params"}
  end

  test "returns error for crazy FV params" do
    assert TimeValue.future_value(play_money: 42, great_rate: 0.5) == {:error, "incorrect params"}
  end

  test "returns error for missing FV params" do
    assert TimeValue.future_value() == {:error, "missing params"}
  end

  test "calculates PV(F, i, n)" do
    assert TimeValue.present_value(
             with_future_value: 100_000,
             with_interest_rate: 0.025,
             with_periods: 10
           ) == {:ok, 78_119.84}
  end

  test "calculates PV(A, i, n)" do
    assert TimeValue.present_value(
             with_annuity: 100,
             with_interest_rate: 0.025,
             with_periods: 10
           ) == {:ok, 875.21}
  end

  test "calculates PV(A, i, n) paid at period end" do
    assert TimeValue.present_value(
             with_annuity: 1000,
             with_interest_rate: 0.05,
             with_periods: 5
           ) == {:ok, 4_329.48}
  end

  test "returns error for empty PV params list" do
    assert TimeValue.present_value([]) == {:error, "incorrect params"}
  end

  test "returns error for crazy PV params" do
    assert TimeValue.present_value(play_money: 42, great_rate: 0.5) ==
             {:error, "incorrect params"}
  end

  test "returns error for missing PV params" do
    assert TimeValue.present_value() == {:error, "missing params"}
  end
end
