describe InventoryRefresh::Graph::TopologicalSort do
  let(:node1) { OpenStruct.new(:x => 1) }
  let(:node2) { OpenStruct.new(:x => 2) }
  let(:node3) { OpenStruct.new(:x => 3) }
  let(:node4) { OpenStruct.new(:x => 4) }
  let(:nodes) { [node1, node2, node3, node4] }
  let(:edges) { [[node1, node2], [node1, node3], [node2, node4]] }
  let(:fixed_edges) { [] }

  let(:graph) { OpenStruct.new(:nodes => nodes, :edges => edges, :fixed_edges => fixed_edges) }

  describe '#to_graphviz' do
    it 'prints the graph with layers' do
      layers = described_class.new(graph).topological_sort
      expect(layers).to eq [[node1], [node2, node3], [node4]]
    end
  end
end
