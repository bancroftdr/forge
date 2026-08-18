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

## Measured â€” four configurations, 20 strikes each

| Config | FSR cap | Peak detect | Buffer | Predicted | Ch1->Ch2 | Ch2->Ch3 | Ch1->Ch3 | sigma |
|---|---|---|---|---|---|---|---|---|
| A | 100 nF | fixed 10 ms | 256 | ~24 ms | | | | |
| B | 10 nF | fixed 10 ms | 256 | ~22 ms | | | | |
| C | 10 nF | adaptive | 256 | ~14 ms | | | | |
| D | 10 nF | adaptive | 64 | ~6 ms | | | | |

## Attribution

## Predicted vs. measured discrepancies
