# M-Pulse Amplitude Modulation

M-Pulse Amplitude Modulation is a MATLAB and Simulink project that simulates Pulse Amplitude Modulation over an AWGN channel. The project studies M-PAM behavior for different modulation orders, with the main MATLAB implementation focused on 16-PAM, matched-filter-style receiver processing, symbol reconstruction, and SNR-versus-BER analysis.

## Preview

![Simulink model](public/images/projects/m-pulse-amplitude-modulation/mpam-simulink-model.png)

The Simulink model represents the communication chain using random symbol generation, PAM modulation, AWGN channel modeling, matched filtering, demodulation, and error-rate calculation.

![4-PAM transmitted signal](public/images/projects/m-pulse-amplitude-modulation/mpam-4pam-transmitted-signal.png)

The transmitted signal is represented as a sequence of rectangular pulses, where each pulse level corresponds to a PAM symbol.

![4-PAM channel signal](public/images/projects/m-pulse-amplitude-modulation/mpam-4pam-channel-signal.png)

The AWGN channel adds noise to the transmitted signal before the receiver stage.

![4-PAM symbol recovery](public/images/projects/m-pulse-amplitude-modulation/mpam-4pam-symbol-recovery.png)

The receiver estimates the transmitted symbols and rounds the received amplitudes back to valid PAM levels.

![8-PAM symbol recovery](public/images/projects/m-pulse-amplitude-modulation/mpam-8pam-symbol-recovery.png)

With higher modulation order, the symbol levels become closer together and the system becomes more sensitive to noise.

![16-PAM symbol recovery](public/images/projects/m-pulse-amplitude-modulation/mpam-16pam-symbol-recovery.png)

The main MATLAB implementation focuses on the 16-PAM case and compares generated, received, and demodulated symbols.

![16-PAM SNR versus BER](public/images/projects/m-pulse-amplitude-modulation/mpam-16pam-snr-vs-ber.png)

The 16-PAM BER curve shows the decrease in error rate as SNR increases.

![SNR versus BER comparison](public/images/projects/m-pulse-amplitude-modulation/mpam-snr-vs-ber-comparison.png)

The comparison curve shows the general trend that larger PAM orders are more sensitive to noise.

## Main Features

* MATLAB simulation of M-Pulse Amplitude Modulation
* Random bit generation and bit-to-symbol grouping
* Rectangular pulse construction for PAM symbols
* AWGN channel modeling
* Matched-filter-style receiver processing
* Symbol rounding and clipping for demodulation
* Bit reconstruction and BER calculation
* SNR-versus-BER plotting
* Simulink model and report for comparing PAM modulation orders

## Technical Overview

The main MATLAB script is:

```text
Code.m
```

The Simulink model is:

```text
Simulink.slx
```

The MATLAB script defines the PAM order, computes the number of bits per symbol as `log2(M)`, generates a random binary message, groups the bits into symbols, and converts each group from binary to decimal amplitude levels.

The transmitter converts each symbol into a rectangular pulse by repeating the symbol amplitude over the pulse duration. The channel adds AWGN at different SNR values. At the receiver, the signal is divided into pulse segments, each segment is processed through a matched-filter-style convolution/energy estimate, and the resulting amplitude estimate is rounded back to the nearest PAM level.

Finally, the received symbols are converted back to bits and compared against the original message to calculate the error behavior across SNR values. The report also includes Simulink-based BER curves for 2-PAM, 4-PAM, 8-PAM, and 16-PAM.

## How to Run

1. Open MATLAB.
2. Open the project folder.
3. Run the MATLAB script:

```matlab
Code
```

4. MATLAB will generate the SNR-versus-error plot for the 16-PAM simulation.
5. Open `Simulink.slx` in Simulink to inspect the block-diagram model used for the report simulations.

## Limitations

The main MATLAB script focuses on the 16-PAM case and uses a simple matched-filter-style receiver implementation. The plotted value in the original script is based on the number of bit mismatches across the simulated message, so the result is best interpreted as an SNR-versus-error trend.

The project is a course simulation and does not implement a full communications-system toolbox, coding scheme, pulse-shaping design, or optimized demodulator for deployment.
