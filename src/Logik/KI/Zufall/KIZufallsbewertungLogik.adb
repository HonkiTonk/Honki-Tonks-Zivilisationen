package body KIZufallsbewertungLogik is

   -- Wird das überhaupt noch gebraucht? äöü
   function Bewertung
     (BewertungEinsExtern : in KIDatentypen.BauenBewertung;
      BewertungZweiExtern : in KIDatentypen.BauenBewertung)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      if
        BewertungEinsExtern > BewertungZweiExtern
      then
         return BewertungEinsExtern;
         
      elsif
        BewertungEinsExtern < BewertungZweiExtern
      then
         return BewertungZweiExtern;
         
      else
         return BewertungEinsExtern;
      end if;
      
   end Bewertung;

end KIZufallsbewertungLogik;
