//arrays, user-defined functions

#include <iostream>
#include <string>
using namespace std;


int main() {

    string products[] = {
        {"SBAPN"},
        {"NBPAN"}
    };

    const int ARRAY_SIZE = sizeof(products) / sizeof(products[0]);

    cout << "--- Product List ---\n";

    for(int i = 0; i < ARRAY_SIZE; i++){
        cout << "Product " << i + 1 << ": " << products[i] << endl;
    }
}
