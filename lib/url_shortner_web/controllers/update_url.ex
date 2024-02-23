defmodule UrlShortnerWeb.UpdateUrlController do
  use UrlShortnerWeb, :controller
  import Murmur
  alias UrlShortner.Links
  alias UrlShortner.Links.Link
  def create(conn, %{"url" => url}) do
    hash = Murmur.hash_x86_32(url)
    toStringHash = Integer.to_string(hash)
    baseURL = get_baseURL(conn)
    changeset = UrlShortner.Links.Link.changeset(%UrlShortner.Links.Link{}, %{url: url, hash: toStringHash})
     UrlShortner.Repo.insert(changeset)
    json(conn, %{url: "#{baseURL}/#{hash}"})
   end
   def find_url(conn, %{"url" => url}) do
     with {:ok, %UrlShortner.Links.Link{} = links} <- UrlShortner.Links.getURL(url) do
       redirect(conn, external: links.url)
       else
         {:error, :not_found} ->
          conn
            |> put_status(:not_found)
            |> text("Not Found")
     end
   end
   defp get_baseURL(conn) do
     scheme = conn.scheme
     host = conn.host
     port = conn.port
     portType = if port in [80, 443] || port == nil, do: "", else: ":#{port}"
     "#{scheme}://#{host}#{portType}"
   end
end