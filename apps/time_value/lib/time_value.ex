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
    {:ok, Float.round(present_value * :math.pow(1 + interest_rate, periods), 2)}
  end

  def future_value(
        with_annuity: annuity,
        with_interest_rate: interest_rate,
        with_periods: periods
      ) do
    {:ok, Float.round(annuity * (:math.pow(1 + interest_rate, periods) - 1) / interest_rate, 2)}
  end

  def future_value(_) do
    {:error, "incorrect params"}
  end

  def future_value() do
    {:error, "missing params"}
  end

  def present_value(
        with_future_value: future_value,
        with_interest_rate: interest_rate,
        with_periods: periods
      ) do
    {:ok, Float.round(future_value / (:math.pow(1 + interest_rate, periods)), 2)}
  end

  def present_value(
        with_annuity: annuity,
        with_interest_rate: interest_rate,
        with_periods: periods
      ) do
    {:ok,
     Float.round(
       annuity / interest_rate * (:math.pow(1 + interest_rate, periods) - 1) /
         (:math.pow(1 + interest_rate, periods)),
       2
     )}
  end

  def present_value(_) do
    {:error, "incorrect params"}
  end

  def present_value() do
    {:error, "missing params"}
  end
end
