# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

defmodule Pfd do

def start do

  receive do{:bind, app, lpl, peers, delay} ->
    Process.send_after(self(), :timer, delay)
      next(app, lpl, peers, delay, peers, MapSet.new)
  end
end


defp next(app, lpl, peers, delay, alive, detected) do

  receive do
  { :lpl_deliver, from, :heartbeat_request } ->
    send lpl, { :lpl_send, from, self(), :heartbeat_reply }
    next(app, lpl, peers, delay, alive, detected)

  { :lpl_deliver, from, :heartbeat_reply } ->
    next(app, lpl, peers, delay, MapSet.put(alive, from), detected)

  :timeout ->
    more_detected = for p <- peers,
      not MapSet.member?(alive, p) and
      not MapSet.member?(detected, p), do: p
      for p <- more_detected, do: send app, { :pdf_crash, p }
      for p <- alive, do: send lpl, { :lpl_send, p, :heartbeat_request }
      Process.send_after(self(), :timer, delay)
      next(app, lpl, peers, delay, [], detected ++ more_detected)
   end
end

end # module
