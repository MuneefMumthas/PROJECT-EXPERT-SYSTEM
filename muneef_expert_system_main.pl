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


%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%

% gpu(Tier, Brand, Model, Price)
% Low tier
gpu(low, nvidia, rtx_3050, 250).
gpu(low, amd, rx_6600, 200).

% Medium tier
gpu(medium, nvidia, rtx_4060, 300).
gpu(medium, amd, rx_7600, 250).

% High tier
gpu(high, nvidia, rtx_5070, 500).
gpu(high, amd, rx_9070, 600).


%%%%%%%%%%%%%%%%%%%%%%%

%Rules and Interface for the expert system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%
% Socket priority

% All AM5 and LGA1700 sockets are future proof
socket_priority(am5, future_proof).
socket_priority(lga1700, future_proof).

% All AM4 and LGA1200 sockets are value
socket_priority(am4, value).
socket_priority(lga1200, value).

%%%%%%%%%%%%%%%%%%%%%%%

% CPU Brand preference helper functions

% If user picked a specific brand, use that
cpu_brand_from_pref(intel, [intel]).
cpu_brand_from_pref(amd,   [amd]).

% If user has no preference, allow both brands
cpu_brand_from_pref(any, [intel, amd]).

%%%%%%%%%%%%%%%%%%%%%%%



find_cpu(Tier, Priority, CpuBrandPref, CpuBrand, CpuModel, Socket, CpuPrice) :-

    % selecting the brand based on user preference
    cpu_brand_from_pref(CpuBrandPref, CpuBrandList),

    % selecting all possible CPU that match the tier and brand preference and returning a list
    findall(CpuPrice-CpuBrand-CpuModel-Socket,
    (
        member(CpuBrand, CpuBrandList),
        % selecting the socket that matches the user's priority
        socket_priority(Socket, Priority),

        % picking a CPU that matches the tier, brand, socket
        cpu(Tier, CpuBrand, CpuModel, Socket, CpuPrice)
    ),
    L),

    % sorting the list based on price and returning the cheapest option
    sort(L, [CpuPrice-CpuBrand-CpuModel-Socket|_]).


%%%%%%%%%%%%%%%%%%%%%%%
%Motherboard priority

motherboard_priority(lga1700, ddr5, future_proof).
motherboard_priority(lga1700, ddr4, value).
motherboard_priority(lga1200, ddr4, value).

motherboard_priority(am5, ddr5, future_proof).
motherboard_priority(am4, ddr4, value).


find_motherboard(Tier, Priority, MbBrand, MbModel, MbRam_type, Ram_slots, MbMaximum_ram, Socket, Price):-

    %selecting the motherboard socket and supported ram type based on priority
    motherboard_priority(Socket, MbRam_type, Priority),

    %picking a motherboard that matches the tier, socket, ram type
    motherboard(Tier, MbBrand, MbModel, MbRam_type, Ram_slots, MbMaximum_ram, Socket, Price).

%%%%%%%%%%%%%%%%%%%%%%%

% GPU Brand preference helper functions

% If user picked a specific brand, use that
gpu_brand_from_pref(nvidia, [nvidia]).
gpu_brand_from_pref(amd,   [amd]).

% If user has no preference, allow both brands
gpu_brand_from_pref(any, [nvidia, amd]).



% finding GPU based on tier and brand preference
find_gpu(Tier, GpuBrandPref, GpuBrand, GpuModel, GpuPrice) :-

    % selecting the brand based on user preference
    gpu_brand_from_pref(GpuBrandPref, GpuBrandList),


    % selecting all possible GPUs that match the tier and brand preference and returning a list
    findall(GpuPrice-GpuBrand-GpuModel,
    (
        member(GpuBrand, GpuBrandList),

        % picking a GPU that matches the tier and brand
        gpu(Tier, GpuBrand, GpuModel, GpuPrice)
    ),
    L),

    % sorting the list based on price and returning the cheapest option
    sort(L, [GpuPrice-GpuBrand-GpuModel|_]).

    


%%%%%%%%%%%%%%%%%%%%%%%
% PC Configuration

pc_config(
    Tier, Priority, CpuBrandPref, CpuBrand, CpuModel, Socket, CpuPrice,
    MbBrand, MbModel, MbRam_type, Ram_slots, MbMaximum_ram, MbPrice,
    GpuBrandPref, GpuBrand, GpuModel, GpuPrice) :-

    % Finding a CPU that matches tier, brand preference and socket priority
    find_cpu(Tier, Priority, CpuBrandPref, CpuBrand, CpuModel, Socket, CpuPrice),

    % Finding a compatible motherboard using the same socket and priority
    find_motherboard(Tier, Priority, MbBrand, MbModel, MbRam_type, Ram_slots, MbMaximum_ram, Socket, MbPrice),

    % Finding a GPU that matches tier and brand preference
    find_gpu(Tier, GpuBrandPref, GpuBrand, GpuModel, GpuPrice).

%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interface

run :-
    write("Welcome to UNEE's PC Builder Expert System!"), nl,
    write("please answer the questions using numbers followed by a period(.)"), nl,nl,
    get_tier(Tier),
    get_user_priority(Priority),
    get_cpu_brand(CpuBrandPref),
    get_gpu_brand(GpuBrandPref),
    %get_budget(Budget), nl,

    % Finding a suitable CPU based on user inputs
    pc_config(
    Tier, Priority, 
    CpuBrandPref, CpuBrand, CpuModel, Socket, CpuPrice,
    MbBrand, MbModel, MbRam_type, Ram_slots, MbMaximum_ram, MbPrice,
    GpuBrandPref, GpuBrand, GpuModel, GpuPrice),


    write("===== Hardware Recommendation ====="), nl,
    write("Use-case tier: "), write(Tier), nl,
    write("Priority: "), write(Priority), nl,
    write("CPU Brand preference: "), write(CpuBrandPref), nl, 
    write("GPU Brand preference: "), write(GpuBrandPref), nl,nl,
    
    %cpu details
    write("===== CPU ====="), nl,
    write("CPU: "), write(CpuBrand), write(" "), write(CpuModel), nl,
    write("CPU Socket: "), write(Socket), nl,
    write("Approximate CPU price: "), write(CpuPrice), nl, nl,


    %motherboard details
    write("===== Motherboard ====="), nl,
    write("Motherboard: "), write(MbBrand), write(" "), write(MbModel), nl,
    write("Motherboard Socket: "), write(Socket), nl,
    write("Supported RAM type: "), write(MbRam_type), nl,
    write("RAM slots: "), write(Ram_slots), nl,
    write("Maximum RAM supported (GB): "), write(MbMaximum_ram), nl,
    write("Approximate Motherboard price: "), write(MbPrice), nl, nl,


    %gpu details
    write("===== GPU ====="), nl,
    write("GPU: "), write(GpuBrand), write(" "), write(GpuModel), nl,
    write("Approximate GPU price: "), write(GpuPrice), nl, nl,
    
    fail.
run.





% questions
%getting the tier from the use case
get_tier(Tier):-
    nl,
    write("What is your primary use case?"), nl, nl,
    write("1. High-end Gaming / Workstation"), nl,
    write("2. Multitasking / Mid-range Gaming"), nl,
    write("3. Basic Office / Home Use"), nl, nl,
    read(Choice),
    (Choice = 1 -> Tier = high ;
    Choice = 2 -> Tier = medium ;
    Choice = 3 -> Tier = low ;
    write("Invalid choice. Please try again."), nl, get_tier(Tier)), nl,
    write(Tier), nl.

%getting the user priority for the build
get_user_priority(Priority) :-
    nl,
    write("What is your priority?"), nl, nl,
    write("1. Save money with older hardware"), nl,
    write("2. Be future proof with newer hardware"), nl,
    read(Choice),
    (Choice = 1 -> Priority = value ;
    Choice = 2 -> Priority = future_proof ;
    write("Invalid choice. Please try again."), nl, get_user_priority(Priority)), nl,
    write(Priority), nl.


%getting the cpu brand preference from the user
get_cpu_brand(Brand) :-
    nl,
    write("Do you have a preferred CPU brand?"), nl, nl,
    write("1. Intel"), nl,
    write("2. AMD"), nl,
    write("3. No Preference"), nl, nl,
    read(Choice),
    (Choice = 1 -> Brand = intel ;
    Choice = 2 -> Brand = amd ;
    Choice = 3 -> Brand = any ;
    write("Invalid choice. Please try again."), nl, get_cpu_brand(Brand)), nl,
    write(Brand), nl.

%getting the gpu brand preference from the user
get_gpu_brand(Brand) :-
    nl,
    write("Do you have a preferred GPU brand?"), nl, nl,
    write("1. Nvidia"), nl,
    write("2. AMD"), nl,
    write("3. No Preference"), nl, nl,
    read(Choice),
    (Choice = 1 -> Brand = nvidia ;
    Choice = 2 -> Brand = amd ;
    Choice = 3 -> Brand = any ;
    write("Invalid choice. Please try again."), nl, get_gpu_brand(Brand)), nl,
    write(Brand), nl.


%getting the budget from the user
get_budget(Budget) :-
    nl,
    write("What is your budget?"), nl, nl,
    read(Amount),
    (number(Amount) -> Budget = Amount ;
    write("Invalid budget. Please enter a positive number."), nl, get_budget(Budget)), nl,
    write(Budget), nl.






