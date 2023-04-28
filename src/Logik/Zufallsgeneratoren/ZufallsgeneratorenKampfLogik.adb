package body ZufallsgeneratorenKampfLogik is
   
   function ErreichteErfolge
     (WürfelanzahlExtern : in KampfDatentypen.KampfwerteGroß)
      return Natural
   is begin
      
      AnzahlErfolge := LeerErfolge;
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
        AnzahlErfolge < LeerErfolge
      then
         return LeerErfolge;
         
      else
         return AnzahlErfolge;
      end if;
      
   end ErreichteErfolge;

end ZufallsgeneratorenKampfLogik;
