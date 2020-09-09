class Driver < ApplicationRecord
    has_secure_password
    has_many :deliveries
    has_many :brokers, through: :deliveries
    has_many :receivers, through: :deliveries
    has_many :suppliers, through: :deliveries
    validates :name, :email, :password, presence: true
    validates :name, :email, uniqueness: true

   
    

    def driver_deliveries
        if self.deliveries == []
            self.deliveries
        end
    end

    def new_delivery
        self.deliveries.filter do |delivery|
            delivery.status == "Awaiting Pickup"
        end
    end

    def transit_delivery
        self.deliveries.filter do |delivery|
            delivery.status == "In Transit"
        end
    end

    def delivered_delivery
        self.deliveries.filter do |delivery|
            delivery.status == "Delivery Completed"
        end
    end

    def actual_arrival_display
        if self.actual_arrival == nil
        self.actual_arrival
        else
        self.actual_arrival.strftime("%A, %H:%M %p")
        end
    end
end
