require 'rgl/adjacency'
require 'rgl/dijkstra'

module InventoryRefresh
  class Graph
    class TopologicalSort
      attr_reader :graph

      def initialize(graph)
        @graph = graph
      end

      def topological_sort
        roots = graph.nodes.reject { |v| graph.edges.detect { |e| e.second == v } }

        fake_root = Object.new

        fake_root_edges = roots.flat_map { |r| [fake_root, r] }
        edges = (fake_root_edges + graph.edges + graph.fixed_edges).flatten

        rgl = RGL::DirectedAdjacencyGraph[*edges]
        shortest_paths = rgl.dijkstra_shortest_paths(Hash.new(0), fake_root)
        shortest_paths.each_with_object([]) { |(node, path), a| (a[path.size] ||= []) << node }.compact.tap(&:shift)
      end
    end
  end
end
