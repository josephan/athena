defmodule Athena.S3.Server do
  use GenServer

  alias Athena.S3

  defstruct bucket: "", query: "", prefix: "", files: []

  # Client API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def fetch_files(pid) do
    state = :sys.get_state(pid)
    bucket = Map.get(state, :bucket)
    prefix = Map.get(state, :prefix)
    S3.Client.populate_directory(pid, bucket, prefix)
  end

  # Server Callbacks

  def init(bucket: bucket, prefix: prefix) do
    {:ok, %__MODULE__{bucket: bucket, prefix: prefix}}
  end

  def handle_call(:clear_files, _from, state) do
    {:reply, :ok, %{state | files: []}}
  end

  def handle_cast({:search, task}) do
    Task.shutdown(task, :brutal_kill)
  end

  def handle_cast({:add_to_directory, object}, state) do
    new_directory = [object | Map.get(state, :directory)]
    {:noreply, %{state | directory: new_directory}}
  end
end
