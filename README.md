# DiskSpaceRentingSolidity
Disk Space Renting System demo with Solidity 0.8.0

This is the Solidity code for a smart contract called DiskSpaceRental, which allows users to rent disk space from other users. The contract uses the SafeMath library from OpenZeppelin to perform safe arithmetic operations on uint256 values.

The contract has the following features:

It defines a Rental struct to store information about a rental, including the owner and renter addresses, the amount of space being rented, the duration of the rental, the price of the rental, and a boolean indicating whether the rental is active.

It has a mapping from rental ID to Rental struct, called rentals, and a counter, rentalCounter, to generate unique rental IDs.

It has events for logging rental activity, including RentalCreated, RentalActivated, and RentalTerminated.

It has a constructor function to create a new rental and set the owner address.

It has a function, setRentalDetails, that allows the owner of a rental to set the details of the rental, including the amount of space being rented, the duration of the rental, and the price.

It has a function, rent, that allows a user to rent a disk space by specifying the rental ID and sending the required amount of funds.

It has a function, terminateRental, that allows the owner of a rental to terminate the rental early.

It has a function, retrieveData, that allows the renter of a rental to retrieve their data once the rental period has ended.
