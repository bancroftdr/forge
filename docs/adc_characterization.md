# ADC Characterization — FORGE v1 (Alpha MF01A-N-221-A01)

Empirical verification of the RP2040 ADC + FSR divider circuit,
using the Alpha MF01A-N-221-A01 sensor (substituted for the
Interlink FSR 402 originally specified in the BOM — see note below).

## Test setup

Single-channel bench test: one FSR wired directly to GP26 (ADC0),
bypassing the mux (not required for a single-sensor test).

3V3 ──[ FSR ]──┬── GP26 (ADC0)
│
[10kΩ]
│
[100nF] ── GND
│
GND

Firmware sampled at 10Hz and transmitted each 12-bit raw value as two
MIDI CC messages (coarse = value >> 5, fine = value & 0x1F),
reconstructed as `adc_raw = coarse × 32 + fine`. Verified via MIDI-OX.

## Results

| Condition        | ADC raw | Voltage (approx) | % of full scale |
|-------------------|--------:|------------------:|-----------------:|
| Unloaded (rest)   |      34 |            0.027V |             0.8% |
| Firm press        |    2719 |             2.19V |               66% |
| Max hand pressure |    3071 |             2.47V |               75% |

**Repeatability:** unloaded reading was re-checked after release and
returned to the same ~34-count value — stable, not drifting or
floating. No evidence of noise or a bad connection.

## Comparison against Day-5 theoretical table

The original `voltage_divider_analysis.md` table was derived from the
**Interlink FSR 402**'s published resistance curve (~100kΩ unloaded →
~200Ω full press), predicting ~372 counts unloaded and ~4015 at full
press.

The Alpha MF01A-N-221-A01 measured here behaves differently:

- **Unloaded resistance is much higher** than the 402's assumed
  ~100kΩ — likely in the megohm range, given the ADC reads only
  ~34 counts (~0.03V) at rest, versus the 402's predicted 372.
- **Full-press resistance does not reach as low** as the 402's
  ~200Ω assumption — max reading here is 3071 (~75% full scale)
  versus the theoretical 4015 (~98%).
- The overall shape (low unloaded, high pressed, large dynamic range)
  is consistent with FSR behavior generally — the *curve* isn't
  wrong, it's shifted relative to the 402-specific numbers.

## Action items before Phase 2 pad array

- [ ] **Retune `VELOCITY_THRESHOLD`** in `config.h` — currently 500
  (assumed floor above the 402's ~372 unloaded reading). With this
  sensor resting at ~34, a much lower threshold (e.g. ~100–150) is
  likely appropriate to reject noise while still catching light
  touches, but should be re-verified once more sensors are in hand
  (sensor-to-sensor variation is normal for FSRs, ~10% per datasheet
  guidance).
- [ ] **Retune `VELOCITY_MAX_ADC`** — currently 3900, assuming the
  402's near-4000 ceiling. This sensor topped out at 3071 under
  firm hand pressure; using 3900 as the "velocity 127" ceiling would
  mean the practical top of the dynamic range never reaches maximum
  MIDI velocity. Consider lowering to something nearer 3000–3200,
  pending data from multiple sensors.
- [ ] **Re-run this characterization on 2–3 more of the 4 received
  FSRs** before finalizing constants — FSR-to-FSR variation is
  expected, and threshold/ceiling values should reflect a
  representative sample, not a single unit.
- [ ] Update `docs/design_decisions.md` noting the FSR substitution
  (Interlink 402 → Alpha MF01A-N-221-A01) and the reason (part
  availability / cost), once that document exists.

## Conclusion

The ADC + divider circuit works correctly: stable, repeatable,
noise-free, with a strong dynamic range in response to pressure. The
firmware's velocity constants were tuned against a different sensor's
assumed curve and should be revisited using real data from this
sensor before the Phase 2 pad array is built.