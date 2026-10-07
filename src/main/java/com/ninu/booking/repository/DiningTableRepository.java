package com.ninu.booking.repository;

import com.ninu.booking.domain.DiningTable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DiningTableRepository extends JpaRepository<DiningTable, Long> {
    List<DiningTable> findByRestaurantId(Long restaurantId);
}
