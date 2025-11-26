#include <iostream>
#include <iomanip>
using namespace std;

const int MAX_BUFFER_SIZE = 256; 

int get_validated_integer(const string& prompt_message, const string& error_message) {
    int value;

    while (true) {
        cout << prompt_message;
        
        if (cin >> value) {
            
            char remainder;
            if (cin.peek() != '\n') {
                cout << error_message << " (Extra characters detected).\n";
                
                cin.ignore(MAX_BUFFER_SIZE, '\n');
            } else {
                return value;
            }
        } else {
            cout << error_message << " (Incorrect data type).\n";
            
            cin.clear();
            
            cin.ignore(MAX_BUFFER_SIZE, '\n');
        }
    }
}

string get_validated_string(const string& prompt_message, const string& error_message) {
    string value;

    while (true) {
        cout << prompt_message;
        
        if (getline(cin, value)) {
            
            if (value.empty()) {
                cout << error_message << " (Input cannot be empty).\n";
            } else {
                return value;
            }
        } else {
            // Input failed (e.g., stream error or corruption)
            cout << error_message << " (Stream error occurred).\n";
            cin.clear();
            cin.ignore(MAX_BUFFER_SIZE, '\n');
        }
    }
}

float get_validated_float(const string& prompt_message, const string& error_message) {
    float value;

    while (true) {
        cout << prompt_message;
        
        // Attempt to read the float value
        if (cin >> value) {
            
            // Check for leftover characters on the line (e.g., "150.50a")
            if (cin.peek() != '\n') {
                cout << error_message << " (Extra or invalid characters detected).\n";
                
                // Clear the rest of the line
                cin.ignore(MAX_BUFFER_SIZE, '\n');
            } else {
                // Successful read and buffer clear
                return value;
            }
        } else {
            // Input failed (e.g., user entered text when expecting a number)
            cout << error_message << " (Incorrect data type).\n";
            
            // Clear the error flags
            cin.clear();
            
            // Discard remaining bad input
            cin.ignore(MAX_BUFFER_SIZE, '\n');
        }
    }
}

/* store product data
int ProductID[MAX_PRODUCTS];
int Quantity[MAX_PRODUCTS];
float UnitCost[MAX_PRODUCTS];
string ProductName[MAX_PRODUCTS];
int ProductCount = 0;
*/


// functions
void AddProduct(){
    
    int product_id, quantity;
    string product_name;
    float cost;


    cout << "Enter product ID: ";
    cin >> product_id;
    cout << "\nEnter product name: ";
    cin >> product_name;
    cout << "\nEnter unit cost: ";
    cin >> cost; 
    cout << "\nEnter product quantity: ";
    cin >> quantity;

} 
void DisplayProducts(){
    cout << "SBAPN";
}
void SearchProduct(){
    cout << "SBAPN";
}
void UpdateQuantity(){
    cout << "SBAPN";
}
void SummaryReport(){
    cout << "SBAPN";
}

int main() {

    int user_input, kill=0;


    while(true){
        cout << R"(
==============================================
MANUFACTURING INVENTORY MANAGEMENT SYSTEM
==============================================
1. Add Product
2. Display All Products
3. Search Product
4. Update Quantity
5. View Summary Report
6. Exit
Enter your choice: )";
    
    cin >> user_input;

    if (cin.fail()) {
        cin.clear();
        cin.ignore(1000, '\n');
        cout << "\nInvalid input.\n";
        continue;
    }

    
    switch (user_input)
    {
    case 1: AddProduct(); break;
    case 2: DisplayProducts(); break;
    case 3: SearchProduct(); break;
    case 4: UpdateQuantity(); break;
    case 5: SummaryReport(); break;
    case 6:
        cout << "Exiting program... Thank you!" << endl;
        return 0;

    default:
        cout << "Invalid choice. Please try again." << endl;
    }
    
    }

    return 0;
}


