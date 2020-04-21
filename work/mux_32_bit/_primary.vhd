library verilog;
use verilog.vl_types.all;
entity mux_32_bit is
    port(
        in_0            : in     vl_logic_vector(31 downto 0);
        in_1            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic
    );
end mux_32_bit;
