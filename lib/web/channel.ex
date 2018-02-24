defmodule Web.Channel do
  @moduledoc """
  Context Module for talking to the in game channels
  """

  import Ecto.Query

  alias Data.Channel
  alias Data.Repo
  alias Game.Channels

  @doc """
  Get all channels active in the game
  """
  def all() do
    Channel
    |> order_by([c], c.name)
    |> Repo.all()
  end

  @doc """
  Get a channel
  """
  def get(id) do
    Channel |> Repo.get(id)
  end

  @doc """
  Get a changeset for a new page
  """
  @spec new() :: map()
  def new(), do: %Channel{} |> Channel.changeset(%{})

  @doc """
  Get a changeset for an edit page
  """
  @spec edit(Channel.t()) :: map()
  def edit(channel), do: channel |> Channel.changeset(%{})

  @doc """
  Create a channel
  """
  @spec create(map) :: {:ok, Channel.t()} | {:error, map}
  def create(params) do
    changeset = %Channel{} |> Channel.changeset(params)

    case changeset |> Repo.insert() do
      {:ok, channel} ->
        Channels.insert(channel)
        {:ok, channel}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Update a channel's color
  """
  @spec update(Channel.t(), map()) :: {:ok, Channel.t()} | {:error, map}
  def update(channel, params) do
    changeset = channel |> Channel.changeset(params)

    case changeset |> Repo.update() do
      {:ok, channel} ->
        Channels.reload(channel)
        {:ok, channel}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
