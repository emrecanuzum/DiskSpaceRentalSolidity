// Author : Emrecan Üzüm

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract DiskSpaceRental {
    using SafeMath for uint256;

    // Struct to represent a disk space rental
    struct Rental {
        address payable owner;
        address payable renter;
        uint256 space;
        uint256 duration;
        uint256 price;
        bool active;
    }

    // Mapping from rental ID to rental
    mapping(uint256 => Rental) public rentals;

    // Counter to generate unique rental IDs
    uint256 public rentalCounter;

    // Events for logging rental activity
    event RentalCreated(uint256 rentalId, address owner, uint256 space, uint256 duration, uint256 price);
    event RentalActivated(uint256 rentalId, address renter);
    event RentalTerminated(uint256 rentalId);

    // Constructor function to create a new rental
    constructor() public payable {
        rentalCounter++;
        rentals[rentalCounter] = Rental(payable(msg.sender), payable(address(0)), 0, 0, 0, false);
        emit RentalCreated(rentalCounter, msg.sender, 0, 0, 0);
    }
    // Function to set the details of a rental
    function setRentalDetails(uint256 _rentalId, uint256 _space, uint256 _duration, uint256 _price) public {
        // Retrieve the rental
        Rental storage rental = rentals[_rentalId];

        // Check that the caller is the owner of the rental
        require(msg.sender == rental.owner, "Only the owner can set the details of a rental.");

        // Update the rental with the new details
        rental.space = _space;
        rental.duration = _duration;
        rental.price = _price;

        // Set the rental to active
        rental.active = true;
    }

    // Function for a renter to rent a disk space
    function rent(uint256 _rentalId) public payable {
        // Retrieve the rental
        Rental storage rental = rentals[_rentalId];

        // Check that the rental is active
        require(rental.active, "This rental is not active.");

        // Check that the renter has sufficient funds
        require(msg.value >= rental.price, "Insufficient funds.");

        // Update the rental with the new rental information
        rental.renter = payable(msg.sender);
        rental.active = false;

        // Transfer the funds from the renter to the owner
        rental.owner.transfer(msg.value);

        // Emit an event to log the rental activation
        emit RentalActivated(_rentalId, msg.sender);
    }

    // Function for the owner to terminate a rental early
    function terminateRental(uint256 _rentalId) public payable{
        // Retrieve the rental
        Rental storage rental = rentals[_rentalId];

        // Check that the caller is the owner of the rental
        require(msg.sender == rental.owner && msg.value >= rental.price , "Only the owner can terminate a rental.");

        rental.renter.transfer(msg.value);

        // Set the rental to inactive
        rental.active = false;

        // Emit an event to log the rental termination
        emit RentalTerminated(_rentalId);
    }

    // Function for the renter to retrieve their data
    function retrieveData(uint256 _rentalId) public {
        // Retrieve the rental
        Rental storage rental = rentals[_rentalId];

        // Check that the caller is the renter of the rental
        require(msg.sender == rental.renter, "Only the renter can retrieve their data.");

        // Check that the rental is inactive (indicating that the rental period has ended)
        require(!rental.active, "The rental period has not yet ended.");

        // Allow the renter to retrieve their data
        // (implementation details will depend on your specific use case)
    }
}
