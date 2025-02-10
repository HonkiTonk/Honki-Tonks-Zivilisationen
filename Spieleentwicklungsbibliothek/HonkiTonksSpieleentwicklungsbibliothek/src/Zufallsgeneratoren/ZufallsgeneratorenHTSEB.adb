package body ZufallsgeneratorenHTSEB is

  function Münzwurf
     return Boolean
   is begin
      
      Münze.Reset (Gen => GeworfeneMünze);
      return Münze.Random (Gen => GeworfeneMünze);
      
   end Münzwurf;
   
   
   
   function VorgegebenerZahlenbereich
     (AnfangExtern : in Integer;
      EndeExtern : in Integer)
      return Integer
   is begin
      
      if
        AnfangExtern > EndeExtern
      then
         Anfang := EndeExtern;
         Ende := AnfangExtern;
         
      else
         Anfang := AnfangExtern;
         Ende := EndeExtern;
      end if;
      
      Zahlenbereich.Reset (Gen => GewählteZahl);
      
      return Zahlenbereich.Random (Gen   => GewählteZahl,
                                   First => Anfang,
                                   Last  => Ende);
      
   end VorgegebenerZahlenbereich;
   
   
   
   function ErreichteErfolge
     (WürfelanzahlExtern : in GanzeZahl)
      return Natural
   is begin
      
      AnzahlErfolge := LeerErfolge;
      Würfel.Reset (Gen => Würfelwurf);
      
      WürfelSchleife:
      for WürfelSchleifenwert in 1 .. WürfelanzahlExtern loop
         
         case
           Würfel.Random (Gen => Würfelwurf)
         is
            when ZufallsgeneratorenDatentypenHTSEB.KritischerFehlschlag'Range =>
               AnzahlErfolge := AnzahlErfolge - 1;
               
            when ZufallsgeneratorenDatentypenHTSEB.NormalerFehlschlag =>
               null;
               
            when ZufallsgeneratorenDatentypenHTSEB.NormalerErfolg =>
               AnzahlErfolge := AnzahlErfolge + 1;
               
            when ZufallsgeneratorenDatentypenHTSEB.KritischerErfolg =>
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

end ZufallsgeneratorenHTSEB;
