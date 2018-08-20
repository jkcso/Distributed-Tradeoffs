# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

# DISTRIBUTED RUN
# import DAC

defmodule Peer do

def start(num, reliability) do
  receive do
  { :bind, system04, peers} ->
  app = spawn(App, :start, [num])
  beb = spawn(Beb, :start, [])
  lpl = spawn(Lpl, :start, [beb, reliability])

  # DISTRIBUTED RUN
  # app = Node.spawn(:'app@app.localdomain', App, :start, [num])
  # beb = Node.spawn(:'beb@beb.localdomain', Beb, :start, [])
  # lpl = Node.spawn(:'lpl@lpl.localdomain', Lpl, :start, [beb, reliability])

  send app, {:bind, peers, beb, self()}
  send beb, {:bind, lpl, app, peers}
  send system04, {:lp2p, self(), lpl}
  end
end

end # module -----------------------
