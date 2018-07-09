defmodule RevelryKoansWeb.SessionController do
  use RevelryKoansWeb, :controller
  alias RevelryKoans.{Auth, Users}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.login(conn, email, password) do
      {:ok, conn, user} ->
        conn
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email or password.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: session_path(conn, :new))
  end
end
