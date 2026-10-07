package com.ninu.booking.repository;

import com.ninu.booking.domain.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByBookingId(Long bookingId);
}
