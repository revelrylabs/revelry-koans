defmodule RevelryKoans.Users.Test do
  use RevelryKoans.DataCase
  alias RevelryKoans.Users

  test "create" do
    {:ok, user} = Users.create_user(%{
      "email" => "joe@example.com",
      "new_password" => "hi",
      "new_password_confirmation" => "hi"
    })

    assert user.email == "joe@example.com"
  end

  test "get_user_by_email" do
    user = insert!(:user)
    user_from_db = Users.get_user_by_email(user.email)

    assert user.email == user_from_db.email
  end

  test "get_user" do
    user = insert!(:user)
    user_from_db = Users.get_user(user.id)

    assert user.email == user_from_db.email
  end
end
