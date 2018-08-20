# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

defmodule Beb do

def start() do
  receive do
  { :bind, lpl, erb, peers} ->
  next(lpl, erb, peers)
  end
end

def next(lpl, erb, peers) do
  receive do
  { :lpl_deliver, :broadcast, max_broadcasts, timeout} ->
    send erb, {:beb_deliver, :broadcast, max_broadcasts, timeout}
  { :beb_broadcast, sender, msg} ->
    for quest <- peers, do: send lpl, {:lpl_send, quest, sender, msg}
  { :lpl_deliver, pid, msg} ->
    send erb, {:beb_deliver, pid, msg}
  end
  next(lpl, erb, peers)
end

end # module -----------------------
