library verilog;
use verilog.vl_types.all;
entity data_path is
    port(
        reg_dst         : in     vl_logic;
        jal_reg         : in     vl_logic;
        pc_to_reg       : in     vl_logic;
        alu_src         : in     vl_logic;
        mem_to_reg      : in     vl_logic;
        jump_sel        : in     vl_logic;
        pc_jump         : in     vl_logic;
        pc_src          : in     vl_logic;
        reg_write       : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        alu_cntrl       : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ZERO            : out    vl_logic;
        opcode          : out    vl_logic_vector(5 downto 0);
        func            : out    vl_logic_vector(5 downto 0)
    );
end data_path;
