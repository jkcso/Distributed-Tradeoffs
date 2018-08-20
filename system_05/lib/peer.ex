# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

# DISTRIBUTED RUN
# import DAC

defmodule Peer do

def start(n,r) do
  receive do
  { :bind, system05, peers} ->
  app = spawn(App, :start, [n])
  beb = spawn(Beb, :start, [])
  lpl = spawn(Lpl, :start, [beb, r]) # reliability parameter

  # DISTRIBUTED RUN
  # app = Node.spawn(:'app@app.localdomain', App, :start, [n])
  # beb = Node.spawn(:'beb@beb.localdomain', Beb, :start, [])
  # lpl = Node.spawn(:'lpl@lpl.localdomain', Lpl, :start, [beb, r])

  send app, {:bind, peers, beb, self()}
  send beb, {:bind, lpl, app, peers}
  send system05, {:lp2p, self(), lpl}
  end
end

end # module -----------------------
