defmodule PhoenixGuardian.User do
  use PhoenixGuardian.Web, :model

  alias PhoenixGuardian.Repo

  schema "users" do
    field :name, :string
    field :email, :string
    field :is_admin, :boolean

    has_many :authorizations, PhoenixGuardian.Authorization

    timestamps()
  end

  @required_fields ~w(email name)a
  @optional_fields ~w(is_admin)a

  def registration_changeset(model, params \\ :empty) do
    model
    |>cast(params, ~w(email name)a)
    |> validate_required(@required_fields)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
  end

  def make_admin!(user) do
    user
    |> cast(%{is_admin: true}, ~w(is_admin)a)
    |> Repo.update!
  end
end
