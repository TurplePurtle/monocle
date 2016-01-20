defmodule Monocle.Maybe do
  defmodule GetNothingError do
    defexception message: "Can't extract the value of a Nothing."
  end

  def just(val), do: {:just, val}
  def nothing(), do: :nothing

  def from_nil(nil), do: nothing()
  def from_nil(val), do: just(val)

  def is_just({:just, _}), do: true
  def is_just(_), do: false

  def is_nothing(:nothing), do: true
  def is_nothing(_), do: false

  def get({:just, val}), do: val
  def get(:nothing), do: nil

  def get({:just, val}, _), do: val
  def get(:nothing, default), do: default

  def get!({:just, val}), do: val
  def get!(:nothing), do: raise GetNothingError

  def map({:just, val}, f), do: just(f.(val))
  def map(:nothing, _), do: nothing()

  def chain({:just, val}, f), do: f.(val)
  def chain(:nothing, _), do: :nothing
end
