# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

import DAC

defmodule System03 do

def main do
  create(5)
end

defp main_net do
  # DISTRIBUTED RUN
  peer0 = Node.spawn(:'peer0@peer0.localdomain', Peer, :start, [0])
  peer1 = Node.spawn(:'peer1@peer1.localdomain', Peer, :start, [1])
  peer2 = Node.spawn(:'peer2@peer2.localdomain', Peer, :start, [2])
  peer3 = Node.spawn(:'peer3@peer3.localdomain', Peer, :start, [3])
  peer4 = Node.spawn(:'peer4@peer4.localdomain', Peer, :start, [4])

  peers = [peer0, peer1, peer2, peer3, peer4]

  for p <- peers, do: send p, { :bind, self(), peers }
  create_pl(0, [], length(peers))
end


defp create(n) do
  peers= Enum.map(0..(n-1), fn(n) -> spawn(Peer, :start, [n]) end)

  for p <- peers, do: send p, { :bind, self(), peers }
  create_pl(0, [], n)
end

defp create_pl(c, pls, t) do
  max_broadcasts = 10000000
  timeout = 5000
  receive do
  {:p2p, peers, pl} ->
  pl2s = [{peers,pl}] ++ pls
  if c+1 == t do
    IO.puts("Max_broadcasts : #{max_broadcasts}, timeout :#{timeout}" )
    for {_, pl} <- pl2s, do: send pl, {:bind, pl2s}
    for {_, pl} <- pl2s, do: send pl, {:pl_deliver, :broadcast, max_broadcasts, timeout}
  end
  create_pl(c+1, pl2s, t)
end

end

end # module -----------------------
