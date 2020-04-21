library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        MTYPE           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        BTYPE           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        RTYPE           : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        JTYPE           : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        REGISTER_TYPE   : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        LW              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        SW              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi1);
        BEQ             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        BNE             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        J               : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        JAL             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        ADDI            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        ANDI            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        JR              : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        ADD             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        \AND\           : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi0)
    );
    port(
        ZERO            : in     vl_logic;
        opcode          : in     vl_logic_vector(5 downto 0);
        func            : in     vl_logic_vector(5 downto 0);
        reg_dst         : out    vl_logic;
        jal_reg         : out    vl_logic;
        pc_to_reg       : out    vl_logic;
        alu_src         : out    vl_logic;
        mem_to_reg      : out    vl_logic;
        jump_sel        : out    vl_logic;
        pc_jump         : out    vl_logic;
        pc_src          : out    vl_logic;
        reg_write       : out    vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        alu_operation   : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MTYPE : constant is 1;
    attribute mti_svvh_generic_type of BTYPE : constant is 1;
    attribute mti_svvh_generic_type of RTYPE : constant is 1;
    attribute mti_svvh_generic_type of JTYPE : constant is 1;
    attribute mti_svvh_generic_type of REGISTER_TYPE : constant is 1;
    attribute mti_svvh_generic_type of LW : constant is 1;
    attribute mti_svvh_generic_type of SW : constant is 1;
    attribute mti_svvh_generic_type of BEQ : constant is 1;
    attribute mti_svvh_generic_type of BNE : constant is 1;
    attribute mti_svvh_generic_type of J : constant is 1;
    attribute mti_svvh_generic_type of JAL : constant is 1;
    attribute mti_svvh_generic_type of ADDI : constant is 1;
    attribute mti_svvh_generic_type of ANDI : constant is 1;
    attribute mti_svvh_generic_type of JR : constant is 1;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
end controller;
