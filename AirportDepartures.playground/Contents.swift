import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case EnRoute
    case Scheduled
    case Canceled
    case Delayed
    case OnTime
    case Landed
    case Boarding
}

struct Airport {
    let destination: String
}

struct Flight {
    let destination: Airport
    let airline: String
    let flight: String
    let departure: Date?
    let terminal: String?
    let status: FlightStatus
}

class DepartureBoard {
    let flights: [Flight]
    
    init(flights: [Flight]) {
        self.flights = flights
    }
    
    func alertPassengers() {
        for flight in flights {
            switch flight.status {
            case .Canceled:
                print("We're sorry your flight to \(flight.destination.destination) was canceled, here is a $500 voucher")
            case .Scheduled:
                if let departureDate = flight.departure {
                    print("Your flight to \(flight.destination.destination) is scheduled to depart at \(departureDate) from terminal: \(flight.terminal ?? "TBD")")
                } else {
                    print("Your flight to \(flight.destination.destination) is scheduled to depart at TBD from terminal: \(flight.terminal ?? "TBD")")
                }
            case .Boarding:
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
            case .Delayed:
                print("Uh oh, your flight to \(flight.destination.destination) has been delayed. Please go to the cafeteria for a free hot chocolate on us.")
            case .EnRoute:
                print("Flight \(flight.flight) to \(flight.destination.destination) is enroute and on schedule. Thank you for flying with us today.")
            default:
                print("Ain't nothin to alert you of.")
            }
        }
    }
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let lax = Airport(destination: "Los Angeles")
let mad = Airport(destination: "Madrid")
let mex = Airport(destination: "Mexico City")
let firstFlight = Flight(destination: lax, airline: "Air Europa", flight: "UX3337", departure: Date(), terminal: "4", status: .Scheduled)
let secondFlight = Flight(destination: mad, airline: "Qantas", flight: "QF12", departure: nil, terminal: "8", status: .Canceled)
let thirdFlight = Flight(destination: mex, airline: "Virgin Atlantic", flight: "VS2894", departure: Date(), terminal: nil, status: .EnRoute)
var allFlights = [Flight]()
allFlights.append(firstFlight)
allFlights.append(secondFlight)
allFlights.append(thirdFlight)
let depBoard = DepartureBoard(flights: allFlights)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for depart in departureBoard.flights {
        if let departureDate = depart.departure {
            print("Destination: \(depart.destination.destination), Airline: \(depart.airline), Flight: \(depart.flight), Departure: \(departureDate), Terminal: \(depart.terminal ?? "Undecided"), Status: \(depart.status)")
        } else {
            print("Destination: \(depart.destination.destination), Airline: \(depart.airline), Flight: \(depart.flight), Departure: , Terminal: \(depart.terminal ?? "Undecided"), Status: \(depart.status)")
        }
    }
}

printDepartures(departureBoard: depBoard)
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled

//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
depBoard.alertPassengers()
//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagCost = 25 * checkedBags
    let ticketCost = 0.1 * Double(distance) * Double(travelers)
    
    let totalAirfare = Double(bagCost) + ticketCost
    return totalAirfare
}

print(calculateAirfare(checkedBags: 3, distance: 700, travelers: 2))
print(calculateAirfare(checkedBags: 1, distance: 200, travelers: 1))
print(calculateAirfare(checkedBags: 7, distance: 300, travelers: 9))
