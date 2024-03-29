defmodule UrlShortner.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :hash, :string
    field :url, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :hash])
    |> validate_required([:url, :hash])
    |> unique_constraint(:hash)
  end
end
