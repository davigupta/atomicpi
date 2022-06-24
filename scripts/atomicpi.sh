#!/bin/sh

# Kernel-visible signals

# ATOMICPI_* constants: Global GPIO index
# ATOMICPICHIP_* constants: Chip ID " " Index in chip
# Think gpioget $ATOMICPICHIP_ISH_GPIO_0 (without quotes)

gpiochip0=$(cat /sys/bus/gpio/devices/gpiochip0/firmware_node/physical_node/gpio/gpiochip*/base)
gpiochip1=$(cat /sys/bus/gpio/devices/gpiochip1/firmware_node/physical_node/gpio/gpiochip*/base)
gpiochip2=$(cat /sys/bus/gpio/devices/gpiochip2/firmware_node/physical_node/gpio/gpiochip*/base)
gpiochip3=$(cat /sys/bus/gpio/devices/gpiochip3/firmware_node/physical_node/gpio/gpiochip*/base)

# External GPIO
ATOMICPI_ISH_GPIO_0=$(expr $gpiochip2 + 21)
ATOMICPICHIP_ISH_GPIO_0="gpiochip2 21"
ATOMICPI_ISH_GPIO_1=$(expr $gpiochip2 + 18)
ATOMICPICHIP_ISH_GPIO_1="gpiochip2 18"
ATOMICPI_ISH_GPIO_2=$(expr $gpiochip2 + 24)
ATOMICPICHIP_ISH_GPIO_2="gpiochip2 24"
ATOMICPI_ISH_GPIO_3=$(expr $gpiochip2 + 15)
ATOMICPICHIP_ISH_GPIO_3="gpiochip2 15"
ATOMICPI_ISH_GPIO_4=$(expr $gpiochip2 + 22)
ATOMICPICHIP_ISH_GPIO_4="gpiochip2 22"
ATOMICPI_ISH_GPIO_7=$(expr $gpiochip2 + 16)
ATOMICPICHIP_ISH_GPIO_7="gpiochip2 16"

# Volume up pin
ATOMICPI_GPIO_DFX_2=$(expr $gpiochip1 + 7)
ATOMICPICHIP_GPIO_DFX_2="gpiochip1 7"
# Volume down pin
ATOMICPI_GPIO_DFX_4=$(expr $gpiochip1 + 5)
ATOMICPICHIP_GPIO_DFX_4="gpiochip1 5"

# Internal signals
ATOMICPI_I2C2_3P3_SDA=$(expr $gpiochip0 + 62)
ATOMICPICHIP_I2C2_3P3_SDA="gpiochip0 62"
ATOMICPI_I2C2_3P3_SCL=$(expr $gpiochip0 + 66)
ATOMICPICHIP_I2C2_3P3_SCL="gpiochip0 66"
ATOMICPI_AU_MIC_SEL=$(expr $gpiochip1 + 0)
ATOMICPICHIP_AU_MIC_SEL="gpiochip1 0"
ATOMICPI_XMOS_RESET=$(expr $gpiochip1 + 8)
ATOMICPICHIP_XMOS_RESET="gpiochip1 8"
ATOMICPI_BN_INT=$(expr $gpiochip1 + 17)
ATOMICPICHIP_BN_INT="gpiochip1 17"
ATOMICPI_BN_RESET=$(expr $gpiochip1 + 25)
ATOMICPICHIP_BN_RESET="gpiochip1 25"

# Physical connector descriptions
# 26-pin connector interface
ATOMICPICONN_ISH_GPIO_0=24
ATOMICPICONN_ISH_GPIO_1=25
ATOMICPICONN_ISH_GPIO_2=26
ATOMICPICONN_ISH_GPIO_3=18
ATOMICPICONN_ISH_GPIO_4=19
ATOMICPICONN_ISH_GPIO_7=20
# Enchilada breakout board
ATOMICPIENCHCONN_ISH_GPIO_0=9
ATOMICPIENCHCONN_ISH_GPIO_1=10
ATOMICPIENCHCONN_ISH_GPIO_2=11
ATOMICPIENCHCONN_ISH_GPIO_3=3
ATOMICPIENCHCONN_ISH_GPIO_4=4
ATOMICPIENCHCONN_ISH_GPIO_7=5
# LEDs
ATOMICPIENCHLED_GREEN="ISH_GPIO_1"
ATOMICPIENCHLED_YELLOW="ISH_GPIO_2"

# Test if actually running on compatible hardware

ATOMICPI_GPIO_HARDWARE_CHIPS="$gpiochip0 $gpiochip1 $gpiochip2 $gpiochip3"
eval ATOMICPI_GPIO_HARDWARE_NGPIO_$gpiochip3=86
eval ATOMICPI_GPIO_HARDWARE_NGPIO_$gpiochip2=27
eval ATOMICPI_GPIO_HARDWARE_NGPIO_$gpiochip1=73
eval ATOMICPI_GPIO_HARDWARE_NGPIO_$gpiochip0=98

atomicpi_gpio_hardware() {
    for CHIP in $ATOMICPI_GPIO_HARDWARE_CHIPS; do
        eval NGPIO_EXPECTED='$ATOMICPI_GPIO_HARDWARE_NGPIO_'$CHIP
        NGPIO_ACTUAL=`cat "/sys/class/gpio/gpiochip$CHIP/ngpio" || true`
        if [ "$NGPIO_EXPECTED" != "$NGPIO_ACTUAL" ]; then
            return 1
        fi
    done
    return 0
}
