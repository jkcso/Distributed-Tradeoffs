defmodule Beb do

def start() do
  receive do
  { :bind, lpl, app, peers} ->
  next(lpl, app, peers)
  end
end

def next(lpl, app, peers) do
  receive do
  { :lpl_deliver, :broadcast, max_broadcasts, timeout} ->
    send app, {:beb_deliver, :broadcast, max_broadcasts, timeout}
  { :beb_broadcast, sender, msg} ->
    for quest <- peers, do: send lpl, {:lpl_send, quest, sender, msg}
  { :lpl_deliver, pid, msg} ->
    send app, {:beb_deliver, pid, msg}
  end
  next(lpl, app, peers)
end

end # module -----------------------
