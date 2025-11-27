% Knowledge base for the computer hardware expert system


% cpu(Tier, Brand, Model, Socket, Price)

%intel cpus
% lga1700 socket cpus
cpu(high, intel, i9_14900KS, lga1700, 630).
cpu(medium, intel, i7_14700K, lga1700, 420).
cpu(low, intel, i3_12100F, lga1700, 90).

% lga1200 socket cpus
cpu(high, intel, i9_11900K, lga1200, 350).
cpu(medium, intel, i5_11600K, lga1200, 175).
cpu(low, intel, i3_10100F, lga1200, 75).

%amd cpus
% AM5 socket cpus
cpu(high, amd, ryzen_9_9950x, am5, 660).
cpu(medium, amd, ryzen_7_7700x, am5, 360).
cpu(low, amd, ryzen_5_7600, am5, 220).

% AM4 socket cpus
cpu(high, amd, ryzen_9_5950X, am4, 500).
cpu(medium, amd, ryzen_5_5600X, am4, 260).
cpu(low, amd, ryzen_3_4100, am4, 60).


% motherboard(Tier, Brand, Model, Socket, Ram type, Price)
% ddr4 and lga1700 motherboards
motherboard(high, asus, tuf_gaming_b760_plus_wifi_d4, ddr4, lga1700, 180).
motherboard(medium, asus, prime_b760m_a_wifi_d4, ddr4, lga1700, 130).
motherboard(low, msi, pro_h610m_g_ddr4, ddr4, lga1700, 60).

% ddr5 and lga1700 motherboards
motherboard(high, gigabyte, z790_aorus_master, ddr5, lga1700, 580).
motherboard(medium, asus, rog_strix_b760f_gaming_wifi, ddr5, lga1700, 250).
motherboard(low, msi, b760_gaming_plus_wifi, ddr5, lga1700, 130).





