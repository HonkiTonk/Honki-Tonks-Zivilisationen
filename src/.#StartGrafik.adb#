pragma SPARK_Mode (On);

with SFMLDarstellungAuswahl;
with SFMLDarstellungEinstellungen;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while SFMLDarstellungEinstellungen.FensterErzeugt = False loop
         
         delay SFMLDarstellungEinstellungen.Wartezeit;
         
      end loop GrafikStartenSchleife;
            
      SFMLDarstellungAuswahl.SFMLDarstellungAuswahl;
      
   end StartGrafik;

end StartGrafik;
