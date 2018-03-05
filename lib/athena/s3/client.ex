defmodule Athena.S3.Client do
  alias ExAws.S3

  def fetch_files(pid, bucket, prefix \\ "") do
    GenServer.call(pid, :clear_files)

    Task.async(fn ->
      bucket
      |> S3.list_objects(prefix: prefix)
      |> ExAws.stream!()
      |> Stream.each(&add_to_directory(&1, pid))
      |> Enum.into([])
    end)
  end

  defp add_to_directory(object, pid) do
    GenServer.cast(pid, {:add_to_directory, object})
  end
end
