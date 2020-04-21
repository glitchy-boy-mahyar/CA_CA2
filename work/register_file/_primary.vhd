library verilog;
use verilog.vl_types.all;
entity register_file is
    port(
        read_reg1       : in     vl_logic_vector(4 downto 0);
        read_reg2       : in     vl_logic_vector(4 downto 0);
        write_reg       : in     vl_logic_vector(4 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        reg_write       : in     vl_logic;
        read_data1      : out    vl_logic_vector(31 downto 0);
        read_data2      : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end register_file;
