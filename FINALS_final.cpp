#include <iostream>
#include <iomanip>
#include <limits>
#include <string>
using namespace std;

const int MAX_BUFFER_SIZE = 256; 

int get_validated_integer(const string& prompt_message, const string& error_message) {
    int value;

    while (true) {
        cout << prompt_message;
        
        if (cin >> value) {
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
    cin.ignore(numeric_limits<streamsize>::max(), '\n'); // ensure buffer is clean

    while (true) {
        cout << prompt_message;
        
        if (getline(cin, value)) {
            if (value.empty()) {
                cout << error_message << " (Input cannot be empty).\n";
            } else {
                return value;
            }
        } else {
            cout << error_message << " (Stream error).\n";
            cin.clear();
            cin.ignore(MAX_BUFFER_SIZE, '\n');
        }
    }
}

float get_validated_float(const string& prompt_message, const string& error_message) {
    float value;

    while (true) {
        cout << prompt_message;
        
        if (cin >> value) {
            if (cin.peek() != '\n') {
                cout << error_message << " (Extra or invalid characters detected).\n";
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

// =================================================
// INVENTORY ARRAYS
// =================================================

const int MAX_PRODUCTS = 100;

int ProductID[MAX_PRODUCTS];
int Quantity[MAX_PRODUCTS];
float UnitCost[MAX_PRODUCTS];
string ProductName[MAX_PRODUCTS];
int ProductCount = 0;

// =================================================
// FUNCTION DECLARATIONS
// =================================================

void AddProduct();
void DisplayProducts();
void SearchProduct();
void UpdateQuantity();
void SummaryReport();

// =================================================
// MAIN PROGRAM
// =================================================

int main() {
    int user_input;

    while (true) {
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

        switch (user_input) {
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

// =================================================
// 1. ADD PRODUCT
// =================================================

void AddProduct() {
    if (ProductCount >= MAX_PRODUCTS) {
        cout << "Inventory is full! Cannot add more products.\n";
        return;
    }

    int id = get_validated_integer("Enter Product ID: ",
                                   "Invalid Product ID!");


    for (int i = 0; i < ProductCount; i++) {
        if (ProductID[i] == id) {
            cout << "Error: Product ID already exists!\n";
            return;
        }
    }


    string name = get_validated_string("Enter Product Name: ",
                                       "Invalid name!");

    float cost = get_validated_float("Enter Unit Cost: ",
                                     "Invalid unit cost!");

    int qty = get_validated_integer("Enter Quantity: ",
                                    "Invalid quantity!");

    // Save data
    ProductID[ProductCount] = id;
    ProductName[ProductCount] = name;
    UnitCost[ProductCount] = cost;
    Quantity[ProductCount] = qty;

    ProductCount++;

    cout << "Product added successfully!\n";
}

// =================================================
// 2. DISPLAY PRODUCTS
// =================================================

void DisplayProducts() {
    if (ProductCount == 0) {
        cout << "No products to display.\n";
        return;
    }

    cout << "\nID   Name                UnitCost    Quantity    TotalValue\n";
    cout << "-----------------------------------------------------------------\n";

    for (int i = 0; i < ProductCount; i++) {
        float totalValue = UnitCost[i] * Quantity[i];

        cout << left << setw(5) << ProductID[i]
             << setw(20) << ProductName[i]
             << right << setw(10) << fixed << setprecision(2) << UnitCost[i]
             << setw(12) << Quantity[i]
             << setw(14) << totalValue
             << endl;
    }
}

// =================================================
// 3. SEARCH PRODUCT
// =================================================

void SearchProduct() {
    int id = get_validated_integer("Enter Product ID to search: ",
                                   "Invalid ID!");

    for (int i = 0; i < ProductCount; i++) {
        if (ProductID[i] == id) {
            cout << "\nProduct found!\n";
            cout << "ID: " << ProductID[i] << endl;
            cout << "Name: " << ProductName[i] << endl;
            cout << "Unit Cost: " << UnitCost[i] << endl;
            cout << "Quantity: " << Quantity[i] << endl;
            return;
        }
    }

    cout << "Product not found.\n";
}

// =================================================
// 4. UPDATE QUANTITY
// =================================================

void UpdateQuantity() {
    int id = get_validated_integer("Enter Product ID to update: ",
                                   "Invalid ID!");

    for (int i = 0; i < ProductCount; i++) {
        if (ProductID[i] == id) {
            int newQty = get_validated_integer("Enter new quantity: ",
                                               "Invalid quantity!");

            Quantity[i] = newQty;
            cout << "Quantity updated successfully!\n";
            return;
        }
    }

    cout << "Product not found.\n";
}

// =================================================
// 5. SUMMARY REPORT
// =================================================

void SummaryReport() {
    if (ProductCount == 0) {
        cout << "No products available.\n";
        return;
    }

    float totalValue = 0;
    int highestIndex = 0;
    int lowestIndex = 0;

    for (int i = 0; i < ProductCount; i++) {
        totalValue += UnitCost[i] * Quantity[i];

        if (Quantity[i] > Quantity[highestIndex])
            highestIndex = i;

        if (Quantity[i] < Quantity[lowestIndex])
            lowestIndex = i;
    }

    cout << "\n=== SUMMARY REPORT ===\n";
    cout << "Total products: " << ProductCount << endl;
    cout << "Total inventory value: " << fixed << setprecision(2) << totalValue << endl;

    cout << "\nHighest quantity: " << ProductName[highestIndex]
         << " (" << Quantity[highestIndex] << " pcs)\n";

    cout << "Lowest quantity : " << ProductName[lowestIndex]
         << " (" << Quantity[lowestIndex] << " pcs)\n";
}
