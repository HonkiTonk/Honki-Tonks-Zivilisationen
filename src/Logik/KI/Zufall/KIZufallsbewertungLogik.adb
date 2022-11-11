with KIDatentypen; use KIDatentypen;

with ZufallsgeneratorenKILogik;

package body KIZufallsbewertungLogik is

   function Bewertung
     (BewertungEinsExtern : in KIDatentypen.BauenBewertung;
      BewertungZweiExtern : in KIDatentypen.BauenBewertung)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        BewertungEinsExtern > BewertungZweiExtern
      then
         return BewertungEinsExtern;
         
      elsif
        BewertungEinsExtern < BewertungZweiExtern
      then
         return BewertungZweiExtern;
         
      else
         case
           ZufallsgeneratorenKILogik.Münzwurf
         is
            when True =>
               return BewertungEinsExtern;
               
            when False =>
               return BewertungZweiExtern;
         end case;
      end if;
      
   end Bewertung;

end KIZufallsbewertungLogik;
