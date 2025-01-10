#include <iostream>
#include <vector>
#include <queue>
#include <limits>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <climits>
#include <algorithm>

using namespace std;

// Structure to represent a weighted edge in the graph
struct Edge {
    int dest;
    int weight;
};

// Structure to represent a node in the priority queue
struct Node {
    int id;
    int distance;
    
    bool operator>(const Node& other) const {
        return distance > other.distance;
    }
};

class Graph {
private:
    unordered_map<int, vector<Edge>> adjacencyList;
    
public:
    // Add edge to the undirected graph
    void addEdge(int src, int dest, int weight) {
        adjacencyList[src].push_back({dest, weight});
        adjacencyList[dest].push_back({src, weight}); // Since it's undirected
    }
    
    // Dijkstra's algorithm to find the shortest path
    vector<int> dijkstra(int start, int end) {
        // Priority queue to store nodes and their distances
        priority_queue<Node, vector<Node>, greater<Node>> pq;
        
        // Initialize distances vector with infinity
        unordered_map<int, int> distances;
        unordered_map<int, int> previous;
        
        // Initialize distances for all nodes to infinity
        for (const auto& pair : adjacencyList) {
            distances[pair.first] = numeric_limits<int>::max();
        }
        
        // Distance to start node is 0
        distances[start] = 0;
        pq.push({start, 0});
        
        while (!pq.empty()) {
            int currentNode = pq.top().id;
            int currentDist = pq.top().distance;
            pq.pop();
            
            // If we reached the destination node, break out of the loop
            if (currentNode == end) {
                break;
            }
            
            // Check all neighbors of current node
            for (const Edge& edge : adjacencyList[currentNode]) {
                int newDist = currentDist + edge.weight;
                
                // If we found a shorter path, update it
                if (newDist < distances[edge.dest]) {
                    distances[edge.dest] = newDist;
                    previous[edge.dest] = currentNode;
                    pq.push({edge.dest, newDist});
                }
            }
        }
        
        // Reconstruct the path and calculate total distance
        vector<int> path;
        int totalDistance = distances[end];  // Get actual shortest distance
        int currentNode = end;
        
        while (currentNode != start) {
            path.push_back(currentNode);
            if (previous.find(currentNode) == previous.end()) {
                return {};
            }
            currentNode = previous[currentNode];
        }
        
        path.push_back(start);
        std::reverse(path.begin(), path.end());
        
        // Store the total distance as the first element
        path.insert(path.begin(), totalDistance);
        
        return path;
    }
    
    // Load graph from file
    static Graph loadFromFile(const string& filename) {
        Graph graph;
        ifstream file(filename);
        
        if (!file.is_open()) {
            cerr << "Error: Could not open file " << filename << endl;
            exit(1);
        }
        
        string line;
        while (getline(file, line)) {
            istringstream iss(line);
            int src, dest, weight;
            if (iss >> src >> dest >> weight) {
                graph.addEdge(src, dest, weight);
            }
        }
        
        return graph;
    }
};

int main() {
    // Load the graph from the file
    Graph graph = Graph::loadFromFile("social-network-proj-graph.txt");
    
    int startNode, endNode;
    
    // Get input from user
    cout << "Starting Node: ";
    cin >> startNode;
    cout << "Ending Node:   ";
    cin >> endNode;
    cout << endl;
    
    // Find the shortest path using Dijkstra's Algorithm
    vector<int> shortestPath = graph.dijkstra(startNode, endNode);
    
    // Print the result
    if (!shortestPath.empty()) {
        int distance = shortestPath[0];  // Get the distance from first element
        shortestPath.erase(shortestPath.begin());  // Remove distance from path
        
        cout << "Dijkstra's Algorithm:" << endl;
        cout << "Shortest Distance: " << distance << endl;
        cout << "Path: [";
        for (int i = 0; i < shortestPath.size(); i++) {
            cout << shortestPath[i];
            if (i != shortestPath.size() - 1) {
                cout << ", ";
            }
        }
        cout << "]" << endl;
    } else {
        cout << "No path exists between node " << startNode << " and node " << endNode << endl;
    }
    
    return 0;
}
