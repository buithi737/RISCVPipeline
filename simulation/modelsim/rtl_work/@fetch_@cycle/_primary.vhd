library verilog;
use verilog.vl_types.all;
entity Fetch_Cycle is
    port(
        CLK             : in     vl_logic;
        Rst             : in     vl_logic;
        PCSrcE          : in     vl_logic;
        PCTargetE       : in     vl_logic_vector(31 downto 0);
        InstrD          : out    vl_logic_vector(31 downto 0);
        PCD             : out    vl_logic_vector(31 downto 0);
        PCPlus4D        : out    vl_logic_vector(31 downto 0)
    );
end Fetch_Cycle;
