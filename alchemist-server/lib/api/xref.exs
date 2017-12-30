Code.require_file "../helpers/response.exs", __DIR__

defmodule Alchemist.API.Xref do

  @moduledoc false

  alias Alchemist.Helpers.CaptureIO
  alias Alchemist.Helpers.Response
  alias Mix.Tasks.Xref

  def request(args) do
    args
    |> normalize
    |> process
  end

  def process({:module, name}) do
    Xref.calls
    |> Enum.filter(fn (%{callee: {mod, _, _}}) -> mod == name end)
    |> Enum.map(fn(%{caller_module: module, file: file, line: line}) -> {module, line, file} end)
    |> Enum.map(fn ({m,l,f}) -> Atom.to_string(m) + ":" + file + ":" + Integer.to_string(l) end)
    |> response
  end

  defp response(result) do
    result
    |> Enum.join("\n")
    |> Response.endmark("XREF")
  end

  def normalize(request) do
    {expr , _} = Code.eval_string(request)
    expr
  end
end
