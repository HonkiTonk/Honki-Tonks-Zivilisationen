pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body InDerStadtBauenTerminal is

   function AuswahlBauprojektTerminal
     return StadtRecords.BauprojektRecord
   is begin
      
      AktuelleAuswahl := 1;
      NachGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum =>
               if
                 AktuelleAuswahl = Bauliste'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl.Nummer - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Bauliste'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               GewähltesBauprojekt := Bauliste (AktuelleAuswahl);
               exit AuswahlSchleife;

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               if
                 AktuellesBauprojekt.Nummer /= 0
               then
                  GewähltesBauprojekt := AktuellesBauprojekt;
                  
               else
                  GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               end if;
               
               exit AuswahlSchleife;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      NachGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektTerminal;

end InDerStadtBauenTerminal;
