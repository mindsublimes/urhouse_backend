properties = [
  { title: "Spacious Apartment", price_per_month: 2000, address: "123 Maple Street, Downtown", number_of_rooms: 3, mrt: "Downtown Station" },
  { title: "Modern Condo", price_per_month: 2500, address: "45 Elm Street, Central", number_of_rooms: 2, mrt: "Central Station" },
  { title: "Vintage Home", price_per_month: 1500, address: "67 Oak Avenue, Westside", number_of_rooms: 4, mrt: "Westside Station" },
  { title: "Penthouse Suite", price_per_month: 5000, address: "9 Birch Boulevard, Uptown", number_of_rooms: 5, mrt: "Uptown Station" },
  { title: "Cozy Cottage", price_per_month: 1200, address: "101 Pine Place, Eastend", number_of_rooms: 2, mrt: "Eastend Station" },
  { title: "Lakeview Loft", price_per_month: 1800, address: "234 Willow Way, Lakeside", number_of_rooms: 3, mrt: "Lakeside Station" },
  { title: "City Center Studio", price_per_month: 1700, address: "567 Cedar Circle, Midtown", number_of_rooms: 1, mrt: "Midtown Station" },
  { title: "Riverside Residence", price_per_month: 2200, address: "890 Alder Alley, Riverside", number_of_rooms: 3, mrt: "Riverside Station" },
  { title: "Sunlit Sanctuary", price_per_month: 1600, address: "123 Fir Field, Sunnyside", number_of_rooms: 2, mrt: "Sunnyside Station" },
  { title: "Hilltop Hideaway", price_per_month: 2400, address: "456 Spruce Street, Highland", number_of_rooms: 4, mrt: "Highland Station" },
  { title: "Urban Oasis", price_per_month: 2300, address: "789 Maple Avenue, Midville", number_of_rooms: 2, mrt: "Midville Station" },
  { title: "Eco Loft", price_per_month: 1800, address: "90 Birch Lane, GreenTown", number_of_rooms: 1, mrt: "GreenTown Metro" },
  { title: "Lakeshore Mansion", price_per_month: 4500, address: "345 Lakeside Boulevard, LakeTown", number_of_rooms: 5, mrt: "LakeTown MRT" },
  { title: "Downtown Duplex", price_per_month: 2900, address: "67 Central Road, Downtown", number_of_rooms: 3, mrt: "Central MRT" },
  { title: "Country Cottage", price_per_month: 1100, address: "23 Meadow Lane, Countryville", number_of_rooms: 2, mrt: "Countryville Station" },
  { title: "Seaside Sanctuary", price_per_month: 3000, address: "45 Ocean Drive, SeaTown", number_of_rooms: 4, mrt: "SeaTown Metro" },
  { title: "Hillside Haven", price_per_month: 2700, address: "789 Hilltop Road, Hillville", number_of_rooms: 3, mrt: "Hillville MRT" },
  { title: "Forest Retreat", price_per_month: 2200, address: "12 Woodland Way, Forestville", number_of_rooms: 3, mrt: "Forestville Station" },
  { title: "Desert Den", price_per_month: 1500, address: "34 Sand Street, DesertTown", number_of_rooms: 2, mrt: "DesertTown Metro" },
  { title: "River Residency", price_per_month: 2000, address: "56 Riverside Road, RiverTown", number_of_rooms: 4, mrt: "RiverTown MRT" }
]

properties.each do |property|
  Property.create!(property)
end
