#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <fstream>
#include <sstream>
#include <limits>
#include <functional>

using namespace std;

// Structure to represent a weighted edge in the graph
struct Edge {
    int dest;
    int weight;
};

// Graph class to represent the undirected graph
class Graph {
private:
    unordered_map<int, vector<Edge>> adjacencyList;
    unordered_map<int, int> influenceScores;  // Stores influence scores of each user
    
public:
    // Add edge to the undirected graph
    void addEdge(int src, int dest, int weight) {
        adjacencyList[src].push_back({dest, weight});
        adjacencyList[dest].push_back({src, weight}); // Since it's undirected
    }

    // Add influence score for a user
    void addInfluenceScore(int user, int score) {
        influenceScores[user] = score;
    }

    // Function to load the graph from a file
    static Graph loadFromFile(const string& graphFilename, const string& influenceFilename) {
        Graph graph;
        ifstream graphFile(graphFilename);
        if (!graphFile.is_open()) {
            cerr << "Error: Could not open file " << graphFilename << endl;
            exit(1);
        }

        // Read edges from graph file and add to the graph
        string line;
        while (getline(graphFile, line)) {
            istringstream iss(line);
            int src, dest, weight;
            if (iss >> src >> dest >> weight) {
                graph.addEdge(src, dest, weight);
            }
        }

        // Load influence scores from the influence file
        ifstream influenceFile(influenceFilename);
        if (!influenceFile.is_open()) {
            cerr << "Error: Could not open file " << influenceFilename << endl;
            exit(1);
        }

        while (getline(influenceFile, line)) {
            istringstream iss(line);
            int user, score;
            if (iss >> user >> score) {
                graph.addInfluenceScore(user, score);
            }
        }

        return graph;
    }

    // Function to find the longest increasing path using DFS and memoization
    vector<int> longestIncreasingPath(int startNode) {
        unordered_map<int, vector<int>> dp;  // DP map to store longest paths for each node
        unordered_map<int, bool> visited;  // To keep track of visited nodes
        
        // Sort the users based on influence score (ascending order)
        vector<int> users;
        for (const auto& pair : influenceScores) {
            users.push_back(pair.first);
        }
        
        // Sort the users based on their influence score
        sort(users.begin(), users.end(), [this](int a, int b) {
            return influenceScores[a] < influenceScores[b];
        });
        
        // Helper function to find the longest path from a given node using DFS and memoization
        function<vector<int>(int)> dfs = [&](int node) -> vector<int> {
            // If the node has already been visited, return its longest path
            if (visited[node]) {
                return dp[node];
            }
            
            visited[node] = true;
            vector<int> longestPath = {node};
            
            // Check all neighbors of the node
            for (const Edge& edge : adjacencyList[node]) {
                if (influenceScores[edge.dest] > influenceScores[node]) {
                    vector<int> neighborPath = dfs(edge.dest);
                    if (neighborPath.size() + 1 > longestPath.size()) {
                        longestPath = neighborPath;
                        longestPath.insert(longestPath.begin(), node);  // Add current node to the path
                    }
                }
            }
            
            dp[node] = longestPath;
            return longestPath;
        };
        
        vector<int> maxLengthPath;
        
        // Find the longest increasing path for each node
        for (int userId : users) {
            vector<int> path = dfs(userId);
            if (path.size() > maxLengthPath.size()) {
                maxLengthPath = path;
            }
        }
        
        return maxLengthPath;
    }
};

int main() {
    // Load the graph from the file
    Graph graph = Graph::loadFromFile("social-network-proj-graph.txt", "social-network-proj-Influences.txt");
    
    int startNode;
    cout << "Enter the starting node for finding the longest increasing path: ";
    cin >> startNode;
    
    // Find the longest increasing path starting from the specified node
    vector<int> longestPath = graph.longestIncreasingPath(startNode);
    
    // Print the result
    if (!longestPath.empty()) {
        cout << "Longest Increasing Path: ";
        for (int node : longestPath) {
            cout << node << " ";
        }
        cout << endl;
    } else {
        cout << "No increasing path exists from node " << startNode << endl;
    }

    return 0;
}
