% Knowledge base for the computer hardware expert system

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% motherboard(Tier, Brand, Model, Ram type, ram slots, maximum ram, Socket, Price)

% lga1700 motherboards - they use both ddr4 and ddr5 ram
% ddr4 and lga1700 motherboards
motherboard(high, asus, tuf_gaming_b760_plus_wifi_d4, ddr4, 4, 192, lga1700, 180).
motherboard(medium, asus, prime_b760m_a_wifi_d4, ddr4, 4, 128, lga1700, 130).
motherboard(low, msi, pro_h610m_g_ddr4, ddr4, 2, 64, lga1700, 60).

% ddr5 and lga1700 motherboards
motherboard(high, gigabyte, z790_aorus_master, ddr5, 4, 192, lga1700, 580).
motherboard(medium, asus, rog_strix_b760f_gaming_wifi, ddr5, 4, 192, lga1700, 250).
motherboard(low, msi, b760_gaming_plus_wifi, ddr5, 4, 192, lga1700, 130).

% lga1200 motherboards - they all use ddr4 ram
% ddr4 and lga1200 motherboards
motherboard(high, asus, rog_maximus_xiii_extreme, ddr4, 4, 128, lga1200, 840).
motherboard(medium, msi, mpg_z490_gaming_plus, ddr4, 4, 128, lga1200, 380).
motherboard(low, gigabyte, h410m_h_v2, ddr4, 2, 64, lga1200, 50).

% am5 motherboards - they all use ddr5 ram
% ddr5 and am5 motherboards
motherboard(high, asus, rog_crosshair_x870e_apex, ddr5, 2, 128, am5, 675).
motherboard(medium, asus, rog_strix_b650e_f_gaming_wifi, ddr5, 4, 128, am5, 180).
motherboard(low, msi, pro_a620m_e, ddr5, 2, 96, am5, 70).

% am4 motherboards - they all use ddr4 ram
% ddr4 and am4 motherboards
motherboard(high, asus, rog_strix_b550_f_gaming, ddr4, 4, 128, am4, 155).
motherboard(medium, gigabyte, b550m_ds3h, ddr4, 4, 128, am4, 85).
motherboard(low, msi, a520m_a_pro, ddr4, 2, 64, am4, 50).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ram(type, Size in GB)
% ddr4 ram sizes
ram(ddr4, 8).
ram(ddr4, 16).
ram(ddr4, 32).

% ddr5 ram sizes
ram(ddr5, 8).
ram(ddr5, 16).
ram(ddr5, 24).
ram(ddr5, 32).
ram(ddr5, 48).
ram(ddr5, 64).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interface

run :-
    write("Welcome to UNEE's Computer Hardware Expert System!"), nl,
    write("please answer the questions using numbers followed by a period(.)"), nl,nl,
    get_tier_preference(Tier).

% question to get tierbased on use case
get_tier_preference(Tier):-
    write("What is your primary use case?"), nl, nl,
    write("1. High-end Gaming / Workstation"), nl,
    write("2. Multitasking / Mid-range Gaming"), nl,
    write("3. Basic Office / Home Use"), nl,
    read(Choice),
    (Choice = 1 -> Tier = high ;
    Choice = 2 -> Tier = medium ;
    Choice = 3 -> Tier = low ;
    write("Invalid choice. Please try again."), nl, get_tier_preference(Tier)).



