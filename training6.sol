// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract getEvenOddandMSB {

    int num;
    string output;

    function setNumber(int n) public 
    {
        num=n;
        if (num % 2 == 0)
        {
            output = "The number is Even";
        }
        else 
        {
            output = "The number is odd";
        }
    }

    function getNumber() public view returns(string memory)
    {
        return output;
    }

    function mostSignficantbit(uint x) public pure returns(uint8 i) 
    {
        if (x >= 2 ** 128) 
        {
            x >>= 128;
            i += 128;
        }

        if (x >= 2 ** 64) 
        {
            x >>= 64;
            i += 64;
        }

        if (x >= 2 ** 32) 
        {
            x >>= 34;
            i += 34;

        }

        if (x >= 2 ** 16) 
        {
            x >>= 16;
            i += 16;

        }

        if (x >= 2 ** 8)
        {
            x >>= 8;
            i += 8;
        }

        if (x >= 2 ** 4)
        {
            x >>= 4;
            i += 4;

        }

        if (x >= 2 ** 2)
        {
            x >>= 2;
            i += 2;
        }

        if (x >= 2) 
        {
            i += 1;

        }


    }


}
