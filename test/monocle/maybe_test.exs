defmodule Monocle.MaybeTest do
  use ExUnit.Case, async: true
  alias Monocle.Maybe

  test "something is just and not nothing" do
    assert Maybe.is_just(Maybe.just(1))
    refute Maybe.is_nothing(Maybe.just(1))
  end

  test "nothing is nothing and not just" do
    assert Maybe.is_nothing(Maybe.nothing())
    refute Maybe.is_just(Maybe.nothing())
  end

  test "from_nil of non-nil is something" do
    assert Maybe.is_just(Maybe.from_nil(1))
  end

  test "from_nil of nil is nothing" do
    assert Maybe.is_nothing(Maybe.from_nil(nil))
  end

  test "get/1 of something is value" do
    assert Maybe.get(Maybe.just(1)) == 1
  end

  test "get/1 of nothing is nil" do
    assert Maybe.get(Maybe.nothing()) == nil
  end

  test "get/2 of something is value" do
    assert Maybe.get(Maybe.just(1), 2) == 1
  end

  test "get/2 of nothing is alternative value" do
    assert Maybe.get(Maybe.nothing(), 1) == 1
  end

  test "get! of just value is value" do
    assert Maybe.get!(Maybe.just(1)) == 1
  end

  test "get! of nothing raises GetNothingError" do
    assert_raise Maybe.GetNothingError, fn ->
      Maybe.get!(Maybe.nothing())
    end
  end

  test "map of just value is f(value)" do
    assert Maybe.map(Maybe.just(1), &(&1 + 1)) == Maybe.just(2)
  end

  test "map of nothing is nothing" do
    assert Maybe.map(Maybe.nothing(), &(&1 + 1)) == Maybe.nothing()
  end
end
