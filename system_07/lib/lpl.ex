defmodule Lpl do

def start(beb, pfd, rlb) do
  receive do
  { :bind, lpls} ->
  map = initMap(lpls, Map.new)
  next(beb, pfd, map, rlb)
  end
end

def next(beb, pfd, map, rlb) do
  receive do
  { :lpl_deliver, :broadcast, max_broadcasts, timeout} ->
    send beb, {:lpl_deliver, :broadcast, max_broadcasts, timeout}

    # in our lazy broadcast implementation, the lpl_send is going to be overloaded by not only broadcasting the BEB msgs but also the msgs of the local pfd when it responds back to other pfd's heartbeat by requests from its lpl to send a heartbeat_reply
  { :lpl_send, quest, sender, msg} ->
    probabilistic_send(map, quest, sender, msg, rlb)

  { :lpl_transmit, pid, :heartbeat_request} ->
    send pfd, {:lpl_deliver, pid, :heartbeat_request}

  { :lpl_transmit, pid, msg} ->
    send beb, {:lpl_deliver, pid, msg}
  end
  next(beb, pfd, map, rlb)
end

def probabilistic_send(map, quest, sender, msg, rlb) do
  if :rand.uniform(99) < rlb do
    lpl = Map.get(map, quest)
    send lpl, {:lpl_transmit, sender, msg}
  end
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([{p,lpl}|o], map) do
    newMap = Map.put(map, p, lpl)
    initMap(o, newMap)
end

end # module -----------------------
