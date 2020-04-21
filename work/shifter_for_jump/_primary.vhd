library verilog;
use verilog.vl_types.all;
entity shifter_for_jump is
    port(
        instructs       : in     vl_logic_vector(31 downto 0);
        pc              : in     vl_logic_vector(31 downto 0);
        shifted_address : out    vl_logic_vector(31 downto 0)
    );
end shifter_for_jump;
