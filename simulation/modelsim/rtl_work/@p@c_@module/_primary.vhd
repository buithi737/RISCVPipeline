library verilog;
use verilog.vl_types.all;
entity PC_Module is
    port(
        CLK             : in     vl_logic;
        Rst             : in     vl_logic;
        PC              : out    vl_logic_vector(31 downto 0);
        PC_Next         : in     vl_logic_vector(31 downto 0)
    );
end PC_Module;
