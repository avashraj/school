#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>

using namespace std;

void dfs(vector<vector<int>> &graph, int curr, vector<bool> &visited, stack<int> &finishtimes) {
    visited[curr] = true;

    for (int neighbor : graph[curr]) {
        if (!visited[neighbor]) {
            dfs(graph, neighbor, visited, finishtimes);
        }
    }

    finishtimes.push(curr);
}

vector<vector<int>> transpose_graph(const vector<vector<int>> &graph, int V) {
    vector<vector<int>> transpose(V);

    for (int u = 0; u < V; ++u) {
        for (int v : graph[u]) {
            transpose[v].push_back(u);
        }
    }

    return transpose;
}

void dfs_collect(vector<vector<int>> &graph, int curr, vector<bool> &visited, vector<int> &scc) {
    visited[curr] = true;
    scc.push_back(curr);

    for (int neighbor : graph[curr]) {
        if (!visited[neighbor]) {
            dfs_collect(graph, neighbor, visited, scc);
        }
    }
}

void kosaraju(vector<vector<int>> &graph, int V) {
    stack<int> finishtimes;
    vector<bool> visited(V, false);
    vector<int> sccId(V, -1);

    for (int i = 0; i < V; ++i) {
        if (!visited[i]) {
            dfs(graph, i, visited, finishtimes);
        }
    }

    vector<vector<int>> transposedGraph = transpose_graph(graph, V);

    fill(visited.begin(), visited.end(), false);

    while (!finishtimes.empty()) {
        int node = finishtimes.top();
        finishtimes.pop();

        if (!visited[node]) {
            vector<int> scc;
            dfs_collect(transposedGraph, node, visited, scc);

            int minNode = *min_element(scc.begin(), scc.end());
            for (int v : scc) {
                sccId[v] = minNode;
            }
        }
    }

    for (int i = 0; i < V; i++) {
        cout << sccId[i] << endl;
    }
}

int main() {
    int num_vertices, num_edges;
    cin >> num_vertices >> num_edges;

    vector<vector<int>> adj_list(num_vertices);
    for (int i = 0; i < num_edges; ++i) {
        int u, v;
        cin >> u >> v;
        adj_list[u].push_back(v);
    }

    kosaraju(adj_list, num_vertices);

    return 0;
}
