// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Refund_Contract {
    address owner;          //the creator of the contract
    int256 private constant RESOLUTION = 1000000000000000;  //to be used as the denominator when calculating the coordinates
    uint256 private constant RADIUS =100;         //the maximum possible allowed radius around the exact location where the employee is expected to be
    address[] employee_list;      //A list of employee. Employees are identified by their public key addresses

    mapping(address => Employee_Info) public contractInfo;

    struct Coordinate {
        uint256 lat;
        uint256 long;
    }                   //represents a location on a map

    struct Employee_Info{
        Coordinate expected_location;       //location where the employee is expected to checkin
        uint budget;                        //the amount the employee is supposed to be reimbursed if he/she is compliant with the contract
        bool isCompliant;        //true if the employee is compliant with the contract
        uint count;             //keeps track of number of times the employee has been checked to comply with the contract
    }

    // This is the constructor which registers the creator of the contract and a list of employees
constructor(){
    owner=msg.sender;
}

/**
 *Checks if the employee already exist in the list of employees in the contracts
 *@param empAddress The public key of the employee
 *@return true if the employee is already added to the list otherwise 
 */
function checkEmployeeExistance(address empAddress) private view returns(bool){ 
    for(uint256 i = 0; i < employee_list.length; i++){ 
        if(employee_list[i] == empAddress)
        return true;  
}        
return false;
}

/**
 *Add an employee to the employee list
 *@param id Public key of the employee
 *@param lat The latitude value of the employee's location
 *@param lon The longitude value of the employee's location
 *@param budget The amount of ETH the employee will be reimbursed
 */
 function addEmployee(address id, uint256 lat, uint256 lon, uint8 budget) public  {
    require(!checkEmployeeExistance(id));
    contractInfo[id].expected_location = Coordinate(lat, lon);
    contractInfo[id].budget = budget;
    contractInfo[id].isCompliant = true;
    contractInfo[id].count = 0;
    employee_list.push(id);
 }

/**
 *Terminates the contract. Only the owner of the contract can terminate it
 */
function kill() public { 
    if(msg.sender == owner) selfdestruct(payable(owner));   
 }

/**
 *Calculates the square root of an integer
 *@param x The integer to get it square root
 *@return y the square root of the integer
 */
function sqrt(uint x) private pure returns (uint y) {
  uint z = (x + 1) / 2;
    y = x;
    while (z < y) {
        y = z;
        z = (x / z + z) / 2;
    }
  } 

function getDistance(uint256 lat, uint256 lon, address _employeeAddress) private view returns(uint256) {
    uint256 x = lat - contractInfo[_employeeAddress].expected_location.lat;
        uint256 y = lon - contractInfo[_employeeAddress].expected_location.long;
        uint256 radius = sqrt(x**2 + y**2);
        return radius;
}

   function checkDistance(uint256 lat, uint256 lon) public {
        uint256 new_radius = getDistance(lat, lon, msg.sender);
        if(new_radius < RADIUS){
            contractInfo[msg.sender].isCompliant = true;
        }else{
            contractInfo[msg.sender].isCompliant = false;
        }
    }
function reimburse(address payable _to) public {
        require(checkEmployeeExistance(_to));
        require(contractInfo[_to].isCompliant == true);
        bool sent = _to.send(contractInfo[_to].budget);
        require(sent, "Failed reimburse the employee!!");
        contractInfo[_to].isCompliant=false;
    }
}