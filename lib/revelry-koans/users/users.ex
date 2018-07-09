defmodule RevelryKoans.Users do
  @moduledoc """
  Module for interacting with Users
  """

  import Ecto.{Query}, warn: false
  alias RevelryKoans.{Repo, User}

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def get_user_by_email(email) do
    User
    |> Repo.get_by([email: String.downcase(email)])
  end

  def get_user(id) do
    Repo.get(User, id)
  end
end
