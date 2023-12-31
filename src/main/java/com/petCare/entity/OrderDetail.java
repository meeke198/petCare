package com.petCare.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Table(name = "order_detail")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String itemName;
    private String image;
    private Integer quantity;
    private Double total;
    private String note;
    @ManyToOne(targetEntity = Orders.class)
    @JoinColumn(name = "orders_id", referencedColumnName = "id")
    private Orders orders;
}
