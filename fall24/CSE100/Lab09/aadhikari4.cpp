#include <iostream>
#include <queue>
#include <vector>
#include <unordered_map>

using namespace std;

struct Node {
    char symbol;
    int freq;
    Node *left, *right;

    Node(char symbol, int freq) : symbol(symbol), freq(freq), left(nullptr), right(nullptr) {}
};

struct Compare {
    bool operator()(Node* left, Node* right) {
        return left->freq > right->freq;
    }
};

void generateCodes(Node* root, string code, unordered_map<char, string>& huffmanCodes) {
    if (!root) return;

    if (!root->left && !root->right) {
        huffmanCodes[root->symbol] = code;
    }

    generateCodes(root->left, code + "0", huffmanCodes);
    generateCodes(root->right, code + "1", huffmanCodes);
}

Node* buildHuffmanTree(vector<char>& symbols, vector<int>& frequencies) {
    priority_queue<Node*, vector<Node*>, Compare> minHeap;

    for (int i = 0; i < symbols.size(); ++i) {
        minHeap.push(new Node(symbols[i], frequencies[i]));
    }

    while (minHeap.size() > 1) {
        Node* left = minHeap.top(); minHeap.pop();
        Node* right = minHeap.top(); minHeap.pop();

        Node* newNode = new Node('\0', left->freq + right->freq);
        newNode->left = left;
        newNode->right = right;

        minHeap.push(newNode);
    }

    return minHeap.top();
}

int main() {
    vector<char> symbols = {'A', 'B', 'C', 'D', 'E', 'F'};
    vector<int> frequencies(6);

    for (int i = 0; i < 6; ++i) {
        cin >> frequencies[i];
    }

    Node* root = buildHuffmanTree(symbols, frequencies);

    unordered_map<char, string> huffmanCodes;
    generateCodes(root, "", huffmanCodes);

    for (auto& symbol : symbols) {
        cout << symbol << ":" << huffmanCodes[symbol] << endl;
    }

    return 0;
}
