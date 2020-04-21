library verilog;
use verilog.vl_types.all;
entity mux_5_bit is
    port(
        in_0            : in     vl_logic_vector(4 downto 0);
        in_1            : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(4 downto 0);
        \select\        : in     vl_logic
    );
end mux_5_bit;
