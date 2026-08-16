# FORGE

A 4×4 velocity-sensitive sampling instrument that makes its own sound.

**Status:** In active development. Targeting instrument completion January 2027.

## What it is

Two custom boards joined by a defined 16-pin interface:

- **FORGE-PAD** — RP2040, 16 FSR pads through a CD74HC4067 16:1 multiplexer into a
  single ADC channel, W25Q128JV SPI flash for sample storage
- **FORGE-AUDIO** — 4-layer mixed-signal board: PCM5102A DAC, PCM1808 ADC, discrete
  reconstruction and anti-alias filters, DC-coupled headphone amplifier on split rails
  from a charge-pump inverter, jumper-selectable external audio clock

Firmware is C on the Pico SDK, dual-core: control and USB on core 0, a PIO/DMA I²S
audio engine on core 1.

## Why the measurements matter more than the features

The design target is not "it works" but "here is how well it works, and why." The
project carries a 35-measurement characterization campaign covering THD+N, noise floor,
frequency response, channel separation, intermodulation distortion, alias rejection,
end-to-end latency, and digital-activity coupling — each reported against an
established measurement-system noise floor.

## Progress

- [x] Toolchain, voltage divider analysis, ADC characterization
- [ ] Breadboard proof: I²S output, ADC input, pad chain
- [ ] FORGE-AUDIO design and fabrication
- [ ] FORGE-PAD design and fabrication
- [ ] Converter characterization
- [ ] System integration and characterization
- [ ] Instrument completion

## Build tracker

[Live schedule and progress](https://bancroftdr.github.io/forge/tracker/)

## Repository Structure

- `firmware/` — Embedded C source code (Pico SDK, TinyUSB)
- `hardware/` — PCB schematics and layout files (Altium Designer)
- `docs/` — Design notes and test procedures
- `media/` — Photos and demo media
