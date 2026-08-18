# J-LINK â€” Board-to-Board Interface

2x8 2.54 mm pin header. Six of sixteen pins are ground: interleaving returns between
every clock and data line controls loop area across the least-controlled part of the
signal path.

| Pin | Net | Direction | Notes |
|---|---|---|---|
| 1 | +5V | PAD -> AUD | From USB VBUS |
| 2 | GND | - | |
| 3 | +3V3_DIG | PAD -> AUD | Digital logic reference for converters |
| 4 | GND | - | |
| 5 | I2S_BCK | PAD -> AUD | 3.072 MHz |
| 6 | GND | - | Guard between clock and data |
| 7 | I2S_LRCK | PAD -> AUD | 48 kHz |
| 8 | GND | - | Guard |
| 9 | I2S_DIN | PAD -> AUD | To DAC |
| 10 | GND | - | Guard |
| 11 | I2S_DOUT | AUD -> PAD | From ADC |
| 12 | GND | - | Guard |
| 13 | I2S_MCLK | bidir | Direction depends on JP1 â€” document it |
| 14 | I2C_SCL | PAD -> AUD | Reserved / future codec control |
| 15 | I2C_SDA | bidir | Reserved |
| 16 | GND | - | |

## Verification

T11 verifies all 16 pins with the boards separated, before ever mating them. A reversed
connector or a swapped power pin destroys a board.
