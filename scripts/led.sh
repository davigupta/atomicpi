#!/bin/bash

. /usr/lib/atomicpi.sh
echo $ATOMICPI_ISH_GPIO_1 >/sys/class/gpio/export
echo $ATOMICPI_ISH_GPIO_2 >/sys/class/gpio/export
echo out > /sys/class/gpio/gpio$ATOMICPI_ISH_GPIO_1/direction    # led green
echo out > /sys/class/gpio/gpio$ATOMICPI_ISH_GPIO_2/direction    # led yellow
