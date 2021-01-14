defmodule Temple.Parser.Match do
  @moduledoc false
  @behaviour Temple.Parser

  alias Temple.Parser
  alias Temple.Buffer

  @impl Parser
  def applicable?({name, _, _}) do
    name in [:=]
  end

  def applicable?(_), do: false

  @impl Parser
  def run({_, _, args} = macro, buffer) do
    import Temple.Parser.Utils

    {do_and_else, _args} =
      args
      |> split_args()

    Buffer.put(buffer, "<% " <> Macro.to_string(macro) <> " %>")
    Buffer.put(buffer, "\n")
    traverse(buffer, do_and_else[:do])

    :ok
  end
end
