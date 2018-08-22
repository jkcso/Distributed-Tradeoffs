defmodule Beb do

def start() do
  receive do
  { :bind, pl, app, peers} ->
  next(pl, app, peers)
  end
end

def next(pl, app, peers) do
  receive do
  { :pl_deliver, :broadcast, max_broadcasts, timeout} ->
    send app, {:beb_deliver, :broadcast, max_broadcasts, timeout}
  { :beb_broadcast, sender, msg} ->
    for quest <- peers, do: send pl, {:pl_send, quest, sender, msg}
  { :pl_deliver, pid, msg} ->
    send app, {:beb_deliver, pid, msg}
  end
  next(pl, app, peers)
end

end # module -----------------------
