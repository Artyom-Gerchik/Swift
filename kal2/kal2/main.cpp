//
//  main.cpp
//  kal2
//
//  Created by Artyom on 18.04.23.
//

#include <iostream>
using namespace std;

int main() {
    
    int number = 0, remainder = 0;
    int counter[10] = {0};
    
    
    cin >> number;


    while(number > 0) {
        remainder = number % 10;
        counter[remainder]++;
        number /= 10;
    }
    
    for (int index = 0; index < sizeof(counter)/sizeof(int); index++){
        if(counter[index] == 3){
            cout << index << endl;
        }
    }
    cout << endl;
    
    return 0;
}

