defmodule UrlShortner.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortner.Links` context.
  """

  @doc """
  Generate a unique link hash.
  """
  def unique_link_hash, do: "some hash#{System.unique_integer([:positive])}"

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        hash: unique_link_hash(),
        url: "some url"
      })
      |> UrlShortner.Links.create_link()

    link
  end
end
