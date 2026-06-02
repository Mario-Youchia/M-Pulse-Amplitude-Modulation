clc
clear
close all

%Transmitter
M = 16; % Number of symbols
Pulse_Width = 1; % Duration of one pulse = 1 sec
Sampling_Frequency = 100; % 100 samples/sec
t = 1/Sampling_Frequency:1/Sampling_Frequency:Pulse_Width;
Num_Of_bits_In_Symbol = log2(M); % Finding the number of bits/symbol
msg_signal = randi([0 1],1,Num_Of_bits_In_Symbol*10000);% generating a random sequence of bits
temp = transpose(reshape(msg_signal,Num_Of_bits_In_Symbol,length(msg_signal)/Num_Of_bits_In_Symbol));
Modulated_msg_signal = bi2de(temp,'left-msb'); %convert the binary number in a symbol to decimal
Transmitted_Signal = Modulated_msg_signal.* ones(1,length(t));
Transmitted_Signal = Transmitted_Signal' ; 
Transmitted_Signal = Transmitted_Signal(:)';
%Channel
SNR = zeros(1,30);
BER = zeros(1,30);
for j = 1:30
SNR(j)=j;
Noisy_Signal= awgn(Transmitted_Signal, j,'measured'); % add AWGN on signal
figure(1);
%subplot(2,1,1);

% stem(msg_signal(1:200));
% title('Randomly Generated Symbols')

% plot(Transmitted_Signal(1:Sampling_Frequency*Pulse_Width*50));
% title('Transmitted Signal 16-PAM'); xlabel('Time(s)'); ylabel('m(t)');

%subplot(2,1,2);
% plot(Noisy_Signal(1:Sampling_Frequency*Pulse_Width*50));
% title('Channel Signal   SNR = 30'); xlabel('Time(s)'); ylabel('r(t)');

%Receiver
Filtered_Signal = zeros(1, length(Modulated_msg_signal));
% Passing the signal through a matched filter
for i = 1 : Sampling_Frequency*Pulse_Width : length(Noisy_Signal)
    Pulse = Noisy_Signal(i:i+Sampling_Frequency*Pulse_Width -1); 
    FilteringPulse = conv(fliplr(Pulse),Pulse); % convolve the pulse with its inverted version
    Filtered_Signal(ceil(i/ (Sampling_Frequency*Pulse_Width) )) = sqrt(FilteringPulse(length(Pulse)) / (Sampling_Frequency*Pulse_Width)); % getting the peak of convolution at time = T.
end
Rounded_Filtered_Signal = round(Filtered_Signal); %rounding the amplitude of the signal to obtain the modulated signal again.
Rounded_Filtered_Signal(Rounded_Filtered_Signal>M-1)=M-1; % replace any greater amplitude than M-1 by M-1
% figure(2)
% subplot(3,1,1);
% stem(Modulated_msg_signal(1:40));
% title('Random Generated Symbols 16-PAM');
% subplot(3,1,2);
% stem(Filtered_Signal(1:40));
% title('Received  Symbols 16-PAM');
% subplot(3,1,3);
% stem(Rounded_Filtered_Signal(1:40));
% title('Demodulated Symbols 16-PAM');
Received_Bits =  de2bi(Rounded_Filtered_Signal, Num_Of_bits_In_Symbol ,'left-msb'); % Converting the decimal number to binary to get the intial random generated symbols.
Received_Bits = Received_Bits' ; 
Received_Bits = Received_Bits(:)';
BER(j) = sum(xor(msg_signal,Received_Bits)); % Calculating the BER
end
plot(SNR,BER); title('SNR VS BER 16-PAM');xlabel('SNR'), ylabel('BER'); %Plotting the SNR VS BER graph
	