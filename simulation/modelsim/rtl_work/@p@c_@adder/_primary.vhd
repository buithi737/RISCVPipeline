library verilog;
use verilog.vl_types.all;
entity PC_Adder is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        Result          : out    vl_logic_vector(31 downto 0)
    );
end PC_Adder;
