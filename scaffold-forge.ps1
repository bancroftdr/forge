<#
    FORGE repository scaffold
    Run from the repo root:  cd C:\pico\forge  then  .\scaffold-forge.ps1

    Safe to re-run. Never overwrites an existing file.
#>

$ErrorActionPreference = "Stop"

if (-not (Test-Path ".git")) {
    Write-Host "ERROR: no .git here. cd to the repo root first." -ForegroundColor Red
    exit 1
}

function New-Dir($p) {
    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Force -Path $p | Out-Null
        Write-Host "  dir   $p" -ForegroundColor DarkGray
    }
}

function New-Doc($p, $body) {
    if (Test-Path $p) {
        Write-Host "  skip  $p (exists)" -ForegroundColor DarkYellow
    } else {
        Set-Content -Path $p -Value $body -Encoding UTF8
        Write-Host "  file  $p" -ForegroundColor Green
    }
}

function New-Keep($p) {
    New-Dir $p
    $k = Join-Path $p ".gitkeep"
    if (-not (Test-Path $k)) { Set-Content -Path $k -Value "" -Encoding UTF8 }
}

Write-Host "`nFORGE repository scaffold`n" -ForegroundColor Cyan

# ---------------------------------------------------------------- directories
Write-Host "Directories" -ForegroundColor Cyan
New-Dir  "docs"
New-Keep "docs/plots"
New-Dir  "hardware"
New-Keep "hardware/forge-pad"
New-Keep "hardware/forge-audio"
New-Dir  "hardware/interface"
New-Keep "hardware/enclosure"
New-Dir  "firmware"
New-Keep "firmware/src"
New-Dir  "firmware/tests"
New-Keep "firmware/tests/results"
New-Keep "tools"
New-Dir  "media"
New-Keep "media/photos"
New-Dir  ".vscode"

# ---------------------------------------------------------------- docs
Write-Host "`nDocuments" -ForegroundColor Cyan

New-Doc "docs/design_decisions.md" @'
# Design Decisions — FORGE v2

The portfolio centerpiece. One polished paragraph per entry stating **what I chose, what
the alternatives were, why I chose it, and what tradeoff I accepted.**

Written the week each decision is made. Reconstructed reasoning reads as reconstructed.

★ marks the four that carry the strongest interview material.

---

## 1 — Overall architecture
**Chosen:** Two boards, defined 16-pin interface · **Alternative:** Single integrated board
**Week:** 0 · **Status:** [ ] not written

> 

## 2 — Controller
**Chosen:** RP2040 (Pico module) · **Alternative:** STM32H5, ESP32
**Week:** 7 · **Status:** [ ] not written

> 

## 3 — Pad sensing
**Chosen:** FSR resistive (Alpha MF01A-N-221-A01) · **Alternative:** Piezo, load cell, capacitive
**Week:** 3 · **Status:** [ ] not written

> 

## 4 — Pad multiplexing
**Chosen:** CD74HC4067 16:1 · **Alternative:** 16 discrete ADC channels
**Week:** 7 · **Status:** [ ] not written

> 

## 5 — FSR readout topology
**Chosen:** Voltage divider · **Alternative:** Direct resistance measurement
**Week:** 7 · **Status:** [ ] not written

> 

## 6 — FSR filter corner ★
**Chosen:** 10 nF (1.59 kHz) · **Alternative:** 100 nF (159 Hz) — Defect 1
**Week:** 3 · **Status:** [ ] not written

> 

## 7 — Divider excitation rail
**Chosen:** Separate isolated LDO · **Alternative:** Shared digital 3V3
**Week:** 7 · **Status:** [ ] not written

> 

## 8 — Velocity detection ★
**Chosen:** Adaptive peak, timeout backstop · **Alternative:** Fixed 10 ms window — Defect 2
**Week:** 3 · **Status:** [ ] not written

> 

## 9 — Velocity curve
**Chosen:** Logarithmic · **Alternative:** Linear, piecewise LUT
**Week:** 3 · **Status:** [ ] not written

> 

## 10 — FSR grade and calibration
**Chosen:** [decide after M-SYS-02] · **Alternative:** Matched premium sensors
**Week:** 14 · **Status:** [ ] not written

> 

## 11 — DAC
**Chosen:** PCM5102A · **Alternative:** Integrated codec (WM8731, TLV320AIC3204)
**Week:** 4 · **Status:** [ ] not written

> 

## 12 — ADC
**Chosen:** PCM1808 · **Alternative:** Same integrated codec
**Week:** 5 · **Status:** [ ] not written

> 

## 13 — Anti-alias filter
**Chosen:** Single-pole RC · **Alternative:** Multi-pole active
**Week:** 5 · **Status:** [ ] not written

> 

## 14 — Headphone amplifier
**Chosen:** Dual audio op-amp, SOIC-8 generic footprint · **Alternative:** Single supply + coupling caps; integrated DirectPath part
**Week:** 4 · **Status:** [ ] not written

> 

## 15 — Negative rail
**Chosen:** TPS60403 charge pump · **Alternative:** Single supply, or boost+LDO
**Week:** 3 · **Status:** [ ] not written

> 

## 16 — Analog LDO
**Chosen:** LP5907 · **Alternative:** Generic LDO (MCP1700)
**Week:** 4 · **Status:** [ ] not written

> 

## 17 — Clock architecture ★
**Chosen:** Jumper-selectable internal-derived vs. external XO · **Alternative:** Pick one
**Week:** 2 · **Status:** [ ] not written

> 

## 18 — Sample rate
**Chosen:** 48 kHz · **Alternative:** 44.1 kHz
**Week:** 1 · **Status:** [ ] not written

> 

## 19 — Sample storage
**Chosen:** W25Q128JV external SPI flash · **Alternative:** Pico internal flash; SD card
**Week:** 2 · **Status:** [ ] not written

> 

## 20 — Audio buffer depth
**Chosen:** [empirically floored — M-SYS-08] · **Alternative:** 256 frames
**Week:** 16 · **Status:** [ ] not written

> 

## 21 — Core partitioning
**Chosen:** Core 0 control, Core 1 audio · **Alternative:** Single core with ISR
**Week:** 19 · **Status:** [ ] not written

> 

## 22 — PAD stackup
**Chosen:** 2-layer + bottom GND plane · **Alternative:** 4-layer
**Week:** 7 · **Status:** [ ] not written

> 

## 23 — AUDIO stackup
**Chosen:** 4-layer, L2 solid GND · **Alternative:** 2-layer
**Week:** 4 · **Status:** [ ] not written

> 

## 24 — Ground strategy ★
**Chosen:** Single unbroken plane, partitioned by placement · **Alternative:** Split analog/digital planes
**Week:** 6 · **Status:** [ ] not written

> Include the explicit MSB 27A comparison: same principle (control return current),
> different aggressor. Tested by M-SYS-05.

## 25 — Board interconnect
**Chosen:** 2x8 header, six ground pins · **Alternative:** 8-pin minimum, or FFC
**Week:** 5 · **Status:** [ ] not written

> 

## 26 — USB device class
**Chosen:** Composite MIDI + CDC · **Alternative:** MIDI only
**Week:** 7 · **Status:** [ ] not written

> 

## 27 — Pico mounting
**Chosen:** Socketed on female headers · **Alternative:** Soldered; bare RP2040
**Week:** 7 · **Status:** [ ] not written

> 

## 28 — Output cap fallback
**Chosen:** Footprints + 0 ohm bypass · **Alternative:** Commit to DC coupling
**Week:** 4 · **Status:** [ ] not written

> 

## 29 — Pad mechanical stack
**Chosen:** [decide Week 7] · **Alternative:** Bare FSR, no force-spreading disc
**Week:** 7 · **Status:** [ ] not written

> Force-spreading disc, pad durometer, and pitch. Measure velocity variance across the
> pad surface with and without the disc.
'@

New-Doc "docs/datasheet_extracts.md" @'
# Datasheet Extracts

Every `[VERIFY]` in the master spec resolves here. Record the value, the datasheet
revision, and the date you pulled it. "The datasheet says -93 dB" invites "which
revision, and at what load?" — have the answer.

| # | Item | Value | Rev | Date | Done |
|---|---|---|---|---|---|
| 1 | PCM5102A — THD+N typical | | | | [ ] |
| 2 | PCM5102A — full-scale output Vrms | | | | [ ] |
| 3 | PCM5102A — config pins: FMT, XSMT, FLT, DEMP, SCK | | | | [ ] |
| 4 | PCM5102A — SCK-less mode supported rates | | | | [ ] |
| 5 | PCM5102A — interpolation filter group delay | | | | [ ] |
| 6 | PCM5102A — recommended external filter values | | | | [ ] |
| 7 | PCM1808 — supply requirements (VDD / VCC) | | | | [ ] |
| 8 | PCM1808 — input full-scale and biasing | | | | [ ] |
| 9 | PCM1808 — mode pins: master/slave, format | | | | [ ] |
| 10 | PCM1808 — SCKI ratio requirement | | | | [ ] |
| 11 | Op-amp — output current, 32 ohm drive | | | | [ ] |
| 12 | Op-amp — unity-gain stability confirmed | | | | [ ] |
| 13 | Op-amp — PSRR at 250 kHz | | | | [ ] |
| 14 | LP5907 — output noise in uVrms | | | | [ ] |
| 15 | TPS60403 — switching frequency | | | | [ ] |
| 16 | TPS60403 — flying and reservoir cap values | | | | [ ] |
| 17 | TPS60403 — output ripple spec | | | | [ ] |
| 18 | W25Q128JV — JEDEC ID bytes | | | | [ ] |
| 19 | W25Q128JV — maximum SPI clock | | | | [ ] |
| 20 | CD74HC4067 — on-resistance and switching time | | | | [ ] |
| 21 | RP2040 — ADC conversion time and offset error | | | | [ ] |
| 22 | RP2040 — GPIO pin function table (I2S adjacency, SPI1, I2C0) | | | | [ ] |
| 23 | RP2040 — PLL configuration range for audio clock | | | | [ ] |
| 24 | XO — supply voltage (3.3 V required, not 5 V) | | | | [ ] |
| 25 | XO — jitter spec in ps RMS | | | | [ ] |
| 26 | MOTU M2 — THD+N and noise floor spec | | | | [ ] |
| 27 | FSR MF01A-N-221-A01 — force range, repeatability | | | | [ ] |
| 28 | JLCPCB — 4-layer stackup and dielectric | | | | [ ] |
| 29 | Pico — VSYS and 3V3 current limits | | | | [ ] |
| 30 | TinyUSB — composite MIDI+CDC descriptor requirements | | | | [ ] |
'@

New-Doc "docs/architecture.md" @'
# Architecture

Block diagram, clock architecture, power architecture, and dual-core partitioning.
Written Week 0 while the two-board reasoning is fresh; extended as decisions resolve.

## Two-board decision

## Block diagram

## Clock architecture

## Power architecture

## Firmware partitioning
'@

New-Doc "docs/clock_analysis.md" @'
# Clock Analysis

System PLL and PIO divider derivation for 48.000 kHz LRCK / 3.072 MHz BCK.
**Record the failed attempts too** — the derivation is the interesting part.

## Requirement

LRCK = 48.000 kHz, BCK = 48000 x 32 bits x 2 channels = 3.072 MHz

## Derivation (by hand, before implementing)

## Measured LRCK

| Attempt | sysclk | PIO divider | Predicted LRCK | Measured | Error (ppm) | Error (cents) |
|---|---|---|---|---|---|---|
| | | | | | | |

## Clock-domain resolution (Week 2)

Options tested:
- (a) XO -> PCM1808 SCKI, PCM1808 as I2S master, RP2040 slaving
- (b) XO -> RP2040 CLK_GPIN0 (GP20), RP2040 as master
- (c) Two domains, DAC only

Outcome and rejected options:
'@

New-Doc "docs/measurement_setup.md" @'
# Measurement Setup

Equipment, calibration, and the system noise floor. **Every M-series result must be
reported alongside the relevant floor figure from this file.**

## Equipment

| Item | Model | Firmware / driver | Notes |
|---|---|---|---|
| Audio interface | | | |
| Oscilloscope | | | |
| Function generator | | | |
| Analysis software | | | |

## Gain settings

Record exactly. Reproducibility depends on it.

## M-CAL-01 loopback results

| Session | Date | THD+N (dB) | Noise unwt (dBFS) | Noise A-wt (dBFS) | FR flatness | Ch. sep (dB) |
|---|---|---|---|---|---|---|
| 1 | | | | | | |
| 2 | | | | | | |
| 3 | | | | | | |

**Session-to-session spread:** ___ dB
This is the smallest delta you are entitled to claim on the DUT.
'@

New-Doc "docs/measurement_report.md" @'
# Measurement Report

All 35 M-series measurements in consistent record-sheet format. Written as each campaign
completes, not in February.

## Executive summary

| Parameter | Measured | Conditions |
|---|---|---|
| THD+N | | 1 kHz, -1 dBFS, 32 ohm, unweighted |
| Noise floor | | A-weighted, digital silence |
| Dynamic range | | AES17 method |
| Frequency response | | 20 Hz - 20 kHz |
| Channel separation | | 1 kHz |
| Output impedance | | 1 kHz |
| Full-scale output | | 1 kHz, unloaded |
| End-to-end latency | | Pad strike to audio onset, mean of 20 |
| Sequencer timing sigma | | 120 BPM, 1000 steps |
| Sample rate accuracy | | LRCK, measured |
| Measurement system floor | | Loopback, M-CAL-01 |

## Clock (M-CLK)

## DAC / output path (M-DAC)

## ADC / input path (M-ADC)

## System (M-SYS)

## Power (M-PWR)
'@

New-Doc "docs/latency_budget.md" @'
# Latency Budget

Derivation, prediction, four measured configurations, attribution, and discrepancy
analysis. **The most persuasive artifact in the project.**

## Requirement derivation

Target < 10 ms measured, stretch < 7 ms.

## Predicted budget

| Term | v1.0 as designed | v2 design |
|---|---|---|
| FSR mechanical + RC settle | | |
| Detection latency (1 full scan) | | |
| Debounce | | |
| Peak detection | | |
| Audio buffer | | |
| DAC group delay | | |
| **Total** | | |

## Measured — four configurations, 20 strikes each

| Config | FSR cap | Peak detect | Buffer | Predicted | Ch1->Ch2 | Ch2->Ch3 | Ch1->Ch3 | sigma |
|---|---|---|---|---|---|---|---|---|
| A | 100 nF | fixed 10 ms | 256 | ~24 ms | | | | |
| B | 10 nF | fixed 10 ms | 256 | ~22 ms | | | | |
| C | 10 nF | adaptive | 256 | ~14 ms | | | | |
| D | 10 nF | adaptive | 64 | ~6 ms | | | | |

## Attribution

## Predicted vs. measured discrepancies
'@

New-Doc "docs/ground_strategy.md" @'
# Ground Strategy

Why FORGE-AUDIO uses a single unbroken plane partitioned by placement, and why that
answer differs in its reasoning from MSB 27A despite reaching the same conclusion.

## The MSB 27A precedent

## Why splitting the plane is obsolete advice

## Partitioning by placement

## The synthesis

Same principle in both designs: control where return current flows. What differs is the
aggressor.

## Tested by measurement

M-SYS-05 results and interpretation:
'@

New-Doc "docs/assembly_log.md" @'
# Assembly Log

Every issue found, its root cause, and what I would do differently. This is what makes a
lab notebook trustworthy, and it answers "walk me through a problem you debugged."

| Date | Board | Issue | Root cause | Fix | Would do differently |
|---|---|---|---|---|---|
| | | | | | |
'@

New-Doc "docs/calibration.md" @'
# Calibration

Per-pad procedure, final constants, and the reasoning behind them.

## Procedure

## Measured per-pad floor and ceiling

| Pad | Floor (counts) | Ceiling (counts) | sigma | Notes |
|---|---|---|---|---|
| 00 | | | | |

## Final constants

| Constant | Value | Derived from |
|---|---|---|
| PAD_SCAN_SETTLE_US | | |
| DEBOUNCE_SAMPLES | | |
| PEAK_DROP_COUNTS | | M-SYS-01: ceil(3 * sigma) |
| PEAK_MAX_MS | | |
| VELOCITY_HYSTERESIS | | |

## Before / after inter-pad spread

The improvement pair is the deliverable, not the after alone.
'@

New-Doc "docs/build_guide.md" @'
# Build Guide

Reproducible assembly instructions. Someone with general soldering experience should be
able to build this board from this document alone.

## Tools required

## FORGE-AUDIO assembly sequence

## FORGE-PAD assembly sequence

## Post-assembly inspection checklist

## Bring-up sequence
'@

New-Doc "docs/status_log.md" @'
# Status Log

Every Friday, three sentences. The value is in the honesty and in having a record when
you are trying to remember what happened in October.

1. Did this week's deliverables complete? If not, which and why?
2. Is the current gate still achievable on its date?
3. Are the design-decision entries for this week's decisions written?

---

## Week 1 — Aug 17-23

1.
2.
3.
'@

New-Doc "hardware/interface/j-link-spec.md" @'
# J-LINK — Board-to-Board Interface

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
| 13 | I2S_MCLK | bidir | Direction depends on JP1 — document it |
| 14 | I2C_SCL | PAD -> AUD | Reserved / future codec control |
| 15 | I2C_SDA | bidir | Reserved |
| 16 | GND | - | |

## Verification

T11 verifies all 16 pins with the boards separated, before ever mating them. A reversed
connector or a swapped power pin destroys a board.
'@

New-Doc "CHANGELOG.md" @'
# Changelog

## [Unreleased]

### v0.1-breadboard — target Sep 6, 2026
- Breadboard proof: I2S output, ADC input, pad chain, analog output stage
'@

# ---------------------------------------------------------------- gitignore
Write-Host "`nConfig" -ForegroundColor Cyan

$gi = @'
# Build
build/
*.uf2
*.elf
*.bin
*.hex
*.map
*.o
*.d

# Altium
History/
__Previews/
Project Logs*/
Project Outputs*/
*.SchDocPreview
*.PcbDocPreview
*.~*
*.Zip

# OS
.DS_Store
Thumbs.db
desktop.ini

# Editor
*.code-workspace
.vscode/ipch/

# Data
*.tmp
*.bak
'@

if (Test-Path ".gitignore") {
    $cur = Get-Content ".gitignore" -Raw
    if ($cur -notmatch "Altium") {
        Add-Content ".gitignore" "`n$gi"
        Write-Host "  appended to .gitignore" -ForegroundColor Green
    } else {
        Write-Host "  skip  .gitignore (already has Altium rules)" -ForegroundColor DarkYellow
    }
} else {
    New-Doc ".gitignore" $gi
}

New-Doc ".vscode/settings.json" @'
{
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "editor.rulers": [100],
  "[c]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": true
  },
  "[markdown]": {
    "editor.wordWrap": "on",
    "files.trimTrailingWhitespace": false
  },
  "C_Cpp.default.cStandard": "c11",
  "search.exclude": {
    "**/build": true,
    "**/History": true
  }
}
'@

New-Doc ".vscode/extensions.json" @'
{
  "recommendations": [
    "ms-vscode.cpptools",
    "ms-vscode.cmake-tools",
    "marus25.cortex-debug",
    "yzhang.markdown-all-in-one",
    "streetsidesoftware.code-spell-checker"
  ]
}
'@

# ---------------------------------------------------------------- summary
Write-Host "`nDone.`n" -ForegroundColor Cyan
Write-Host "Next:" -ForegroundColor Cyan
Write-Host "  git status"
Write-Host "  git add ."
Write-Host '  git commit -m "Restructure repo for two-board architecture"'
Write-Host "  git push"
Write-Host ""
