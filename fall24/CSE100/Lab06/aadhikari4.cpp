#include <iostream>
#include <list>
#include <vector>
#include <string>

using namespace std;

class HashTable {
public: 
    HashTable(int size) : size(size), table(size) {
    }

    int hash(int key) {
        return key % size; 
    }

    void insert(int key) {
        int index = hash(key);
        table[index].push_front(key);
    }
        
    void remove(int key) {
        int index = hash(key);
        list<int>& searchBucket = table[index];
        
        int position = 0;
        bool found = false;

        for (auto it = searchBucket.begin(); it != searchBucket.end(); ++it, ++position) {
            if (*it == key) {
                searchBucket.erase(it);
                cout << key << ":DELETED" << ";" << endl;
                found = true;
                break;
            }
        }

        if (!found) {
            cout << key << ":DELETE_FAILED;" << endl;
        }

    }
        
    void search(int key) {
        int index = hash(key);
        list<int>& searchBucket = table[index];
        
        int position = 0;
        bool found = false;

        for (auto it = searchBucket.begin(); it != searchBucket.end(); ++it, ++position) {
            if (*it == key) {
                cout << key << ":FOUND_AT" << index << "," << position << ";" << endl;
                found = true;
                break;
            }
        }

        if (!found) {
            cout << key << ":NOT_FOUND;" << endl;
        }
    }
        
    void print() {
        for (int i = 0; i < size; i++) {
            cout << i << ":";
            for (int key : table[i]) {
                cout << key << "->";
            }

            cout << ";" << endl;
        }
    }

private:
    int size;
    vector<list<int>> table;
};

int main(int argc, char **argv) {
    int size;
    cin >> size;
    HashTable table(size);

    string input;
    cin >> input;
    char command = input[0];
    int key; 

    while (command != 'e') {
        switch (command) {
            case 'i':
                key = stoi(input.substr(1));
                table.insert(key);
                break;
            case 'd':
                key = stoi(input.substr(1));
                table.remove(key);
                break;
            case 's':
                key = stoi(input.substr(1));
                table.search(key);
                break;
            case 'o':
                table.print();
                break;
        }

        cin >> input;
        command = input[0];
    }
}
