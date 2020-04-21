library verilog;
use verilog.vl_types.all;
entity shift_left_2 is
    port(
        sign_extended_address: in     vl_logic_vector(31 downto 0);
        shifted_address : out    vl_logic_vector(31 downto 0)
    );
end shift_left_2;
