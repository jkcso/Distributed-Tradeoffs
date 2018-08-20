# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

# DISTRIBUTED RUN
# import DAC

defmodule Peer do

def start(n) do
  receive do
  { :bind, system03, peers} ->
  app = spawn(App, :start, [n])
  beb = spawn(Beb, :start, [])
  pl = spawn(Pl, :start, [beb])

  # DISTRIBUTED RUN
  # app = Node.spawn(:'app@app.localdomain', App, :start, [n])
  # beb = Node.spawn(:'beb@beb.localdomain', Beb, :start, [])
  # pl = Node.spawn(:'pl@pl.localdomain', Pl, :start, [beb])

  send app, {:bind, peers, beb, self()}
  send beb, {:bind, pl, app, peers}
  send system03, {:p2p, self(), pl}
  end
end

end # module -----------------------
