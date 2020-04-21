library verilog;
use verilog.vl_types.all;
entity alu_controller is
    generic(
        MTYPE           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        BTYPE           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        RTYPE           : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        JTYPE           : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        ADD             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        SUB             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi0);
        \AND\           : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        \OR\            : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        SLT             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi0)
    );
    port(
        alu_op          : in     vl_logic_vector(1 downto 0);
        func            : in     vl_logic_vector(5 downto 0);
        alu_operation   : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MTYPE : constant is 1;
    attribute mti_svvh_generic_type of BTYPE : constant is 1;
    attribute mti_svvh_generic_type of RTYPE : constant is 1;
    attribute mti_svvh_generic_type of JTYPE : constant is 1;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of SUB : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of SLT : constant is 1;
end alu_controller;
