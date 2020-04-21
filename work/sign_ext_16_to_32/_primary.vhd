library verilog;
use verilog.vl_types.all;
entity sign_ext_16_to_32 is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end sign_ext_16_to_32;
