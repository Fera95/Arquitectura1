//This module receives an Operand and outputs its two's complement if needed
module Complement2 #(parameter bus = 4) (input logic [bus-1:0] OPA, output logic [bus-1:0] c2);

    logic [bus-1:0] ones;
    //assign ones = ~0;
    assign ones = '1;
    assign c2 = (ones ^ OPA) + 1'b1;

endmodule
