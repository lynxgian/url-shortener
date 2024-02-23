defmodule UrlShortner.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias UrlShortner.Repo
  alias UrlShortner.Links.Link

  def getURL(hash) do
    query = from u in Link, where: u.hash == ^hash

    case Repo.one(query) do
      nil-> {:error, :not_found}
      links -> {:ok, links}
    end

  end
end
