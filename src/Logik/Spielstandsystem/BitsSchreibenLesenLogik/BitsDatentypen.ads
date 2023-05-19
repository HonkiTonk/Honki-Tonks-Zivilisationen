with Ada.Streams; use Ada.Streams;
with Ada.Finalization; use Ada.Finalization;

package BitsDatentypen is
   
   type Bit is range 0 .. 1;
   type BitArray is array (Positive range <>) of Bit;
   --   type Bit_Stream (Channel : not null access Root_Stream_Type'Class) is limited private;
   
   -- private
               
   type Bit_Stream (Channel : not null access Root_Stream_Type'Class) is new Limited_Controlled with record
         
      Read_Count  : Natural := 0;
      Write_Count : Natural := 0;
      Input       : Stream_Element_Array (1..1) := (others => 0);
      Output      : Stream_Element_Array (1..1) := (others => 0);
         
   end record;

end BitsDatentypen;
