defmodule Temple.Support.Utils do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [==: 2, =~: 2]
      import unquote(__MODULE__)
    end
  end

  defmacro compile_components(files) do
  end

  def a == b when is_binary(a) and is_binary(b) do
    a = String.replace(a, "\n", "")
    b = String.replace(b, "\n", "")

    Kernel.==(a, b)
  end

  def a =~ b when is_binary(a) and is_binary(b) do
    a = String.replace(a, "\n", "")
    b = String.replace(b, "\n", "")

    Kernel.=~(a, b)
  end

  def evaluate_template(template) do
    template
    |> EEx.compile_string(engine: Phoenix.HTML.Engine)
    |> Code.eval_quoted([])
    |> elem(0)
    |> Phoenix.HTML.safe_to_string()
  end
end
