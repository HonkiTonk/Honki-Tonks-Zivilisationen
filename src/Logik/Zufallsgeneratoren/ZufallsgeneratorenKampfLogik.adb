pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

package body ZufallsgeneratorenKampfLogik is

   function KampfErfolg
     return Float
   is begin
      
      Ada.Numerics.Float_Random.Reset (Gen => ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (Gen => ZufälligerFloatWert);
      
   end KampfErfolg;
   
   
   
   function ErreichteErfolge
     (WürfelanzahlExtern : in KampfDatentypen.KampfwerteAllgemein)
      return Natural
   is begin
      
      AnzahlErfolge := 0;
      Würfel.Reset (Gen => Würfelwurf);
      
      WürfelSchleife:
      for WürfelSchleifenwert in 1 .. WürfelanzahlExtern loop
         
         case
           Würfel.Random (Gen => Würfelwurf)
         is
            when BewertungDatentypen.KritischerFehlschlag'Range =>
               AnzahlErfolge := AnzahlErfolge - 1;
               
            when BewertungDatentypen.NormalerFehlschlag =>
               null;
               
            when BewertungDatentypen.NormalerErfolg =>
               AnzahlErfolge := AnzahlErfolge + 1;
               
            when BewertungDatentypen.KritischerErfolg =>
               AnzahlErfolge := AnzahlErfolge + 2;
         end case;
         
      end loop WürfelSchleife;
      
      if
        AnzahlErfolge < 0
      then
         return 0;
         
      else
         return AnzahlErfolge;
      end if;
      
   end ErreichteErfolge;

end ZufallsgeneratorenKampfLogik;
