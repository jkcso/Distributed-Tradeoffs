# DISTRIBUTED RUN
# import DAC

defmodule Peer do

def start(n) do
  receive do
  { :bind, system02, peers} ->
  app = spawn(App, :start, [n])
  pl = spawn(Pl, :start, [app])

  # DISTRIBUTED RUN
  # app = Node.spawn(:'app@app.localdomain', App, :start, [n])
  # pl = Node.spawn(:'pl@pl.localdomain', Pl, :start, [app])

  send app, {:bind, peers, pl, self()}
  send system02, {:p2p, self(), pl}
  end
end

end # module -----------------------
