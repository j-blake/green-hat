defmodule TimeValue do
  @moduledoc """
  Documentation for TimeValue.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TimeValue.hello()
      :world

  """
  def hello do
    :world
  end

  def future_value(
        with_present_value: present_value,
        with_interest_rate: interest_rate,
        with_periods: periods
      ) do
    {:ok, Float.round(f_pin(present_value, interest_rate, periods), 2)}
  end

  def future_value(
        with_annuity: annuity,
        with_interest_rate: interest_rate,
        with_periods: periods,
        with_payment_at_end?: is_payment_at_end
      ) do
    {:ok, Float.round(f_ain(annuity, interest_rate, periods, is_payment_at_end), 2)}
  end

  def future_value(_) do
    {:error, "incorrect params"}
  end

  def future_value() do
    {:error, "missing params"}
  end

  defp f_pin(present_value, interest_rate, periods) do
    present_value * :math.pow(1 + interest_rate, periods)
  end

  defp f_ain(annuity, interest_rate, periods, is_payment_at_end) do
    annuity * (:math.pow(1 + interest_rate, periods) - 1) / interest_rate *
      interest_modifier(interest_rate, is_payment_at_end)
  end

  defp interest_modifier(interest_rate, is_payment_at_end) do
    if is_payment_at_end, do: 1, else: 1 + interest_rate
  end

  def present_value(
        with_future_value: future_value,
        with_interest_rate: interest_rate,
        with_periods: periods
      ) do
    {:ok, Float.round(p_fin(future_value, interest_rate, periods), 2)}
  end

  def present_value(
        with_annuity: annuity,
        with_interest_rate: interest_rate,
        with_periods: periods,
        with_payment_at_end?: is_payment_at_end
      ) do
    {:ok, Float.round(p_ain(annuity, interest_rate, periods, is_payment_at_end), 2)}
  end

  def present_value(_) do
    {:error, "incorrect params"}
  end

  def present_value() do
    {:error, "missing params"}
  end

  defp p_fin(future_value, interest_rate, periods) do
    future_value / :math.pow(1 + interest_rate, periods)
  end

  defp p_ain(annuity, interest_rate, periods, is_payment_at_end) do
    annuity / interest_rate * (:math.pow(1 + interest_rate, periods) - 1) /
      :math.pow(1 + interest_rate, periods) * interest_modifier(interest_rate, is_payment_at_end)
  end
end
