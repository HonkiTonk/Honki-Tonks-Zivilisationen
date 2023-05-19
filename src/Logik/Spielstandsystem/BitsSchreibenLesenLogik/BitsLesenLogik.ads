with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with BitsDatentypen;

package BitsLesenLogik is
   
   function BooleanLesen
     (DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   BooleanZahlenwert : BitsDatentypen.Bit;

end BitsLesenLogik;
