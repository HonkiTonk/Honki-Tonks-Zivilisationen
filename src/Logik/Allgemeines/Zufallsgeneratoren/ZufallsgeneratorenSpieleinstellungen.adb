pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;

with Karten;

package body ZufallsgeneratorenSpieleinstellungen is
   
   function ZufälligeVordefinierteKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum
   is begin
      
      ZufälligeVordefinierteKartengrößeWählen.Reset (ZufälligeVordefinierteKartengrößeGewählt);
      return ZufälligeVordefinierteKartengrößeWählen.Random (ZufälligeVordefinierteKartengrößeGewählt);
        
   end ZufälligeVordefinierteKartengröße;
   
   
   
   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum
   is begin
      
      ZufälligeKartengrößeWählen.Reset (ZufälligeKartengrößeGewählt);
      
      YAchseBestimmenSchleife:
      loop
         
         AuswahlGröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           AuswahlGröße >= 20
         then
            Karten.Kartengrößen (RueckgabeDatentypen.Karte_Größe_Nutzer_Enum).YAchsenGröße := AuswahlGröße;
            exit YAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop YAchseBestimmenSchleife;

      XAchseBestimmenSchleife:
      loop

         AuswahlGröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
         
         if
           AuswahlGröße >= 20
         then
            Karten.Kartengrößen (RueckgabeDatentypen.Karte_Größe_Nutzer_Enum).XAchsenGröße := AuswahlGröße;
            exit XAchseBestimmenSchleife;

         else
            null;
         end if;

      end loop XAchseBestimmenSchleife;
      
      return RueckgabeDatentypen.Karte_Größe_Nutzer_Enum;
      
   end ZufälligeKartengröße;
   
   
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Verwendet_Enum
   is begin
      
      ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
      return ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
      
   end ZufälligeKartenart;
   
   
   
   function ZufälligeKartenform
     return KartenDatentypen.Kartenform_Verwendet_Enum
   is begin
      
      ZufälligeKartenformWählen.Reset (ZufälligeKartenformGewählt);
      return ZufälligeKartenformWählen.Random (ZufälligeKartenformGewählt);
      
   end ZufälligeKartenform;

   
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Verwendet_Enum
   is begin
      
      ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
      return ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
      
   end ZufälligeKartentemperatur;

   
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Verwendet_Enum
   is begin
      
      ZufälligeKartenressourcenWählen.Reset (ZufälligeKartenressourcenGewählt);
      return ZufälligeKartenressourcenWählen.Random (ZufälligeKartenressourcenGewählt);
      
   end ZufälligeKartenressourcen;
   
   
   
   procedure ZufälligeRassen
   is begin
      
      SpielerVorhanden := False;
      GlobaleVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      ZufälligeRassenWählen.Reset (ZufälligeRassenGewählt);
      
      SpielerSchleife:
      while SpielerVorhanden = False loop
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
            RasseImSpiel := ZufälligeRassenWählen.Random (ZufälligeRassenGewählt);

            if
              RasseImSpiel = RassenDatentypen.Spieler_KI_Enum
            then
               GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := RasseImSpiel;
               SpielerVorhanden := True;
            
            else
               null;
            end if;
         
         end loop RassenSchleife;
      end loop SpielerSchleife;
      
      ZufälligeRassenWählen.Reset (ZufälligeRassenGewählt);
      
      MenschFestlegenSchleife:
      loop
         MenschlicherSpielerSchleife:
         for MenschlicheRasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

            if
              GlobaleVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) = RassenDatentypen.Spieler_KI_Enum
            then
               RasseImSpiel := ZufälligeRassenWählen.Random (ZufälligeRassenGewählt);
               
               case
                 RasseImSpiel
               is
                  when RassenDatentypen.Spieler_Mensch_Enum =>
                     GlobaleVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) := RassenDatentypen.Spieler_Mensch_Enum;
                     return;
                     
                  when others =>
                     null;
               end case;
            
            else
               null;
            end if;
         
         end loop MenschlicherSpielerSchleife;
      end loop MenschFestlegenSchleife;
      
   end ZufälligeRassen;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return RueckgabeDatentypen.Schwierigkeitsgrad_Verwendet_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;

end ZufallsgeneratorenSpieleinstellungen;
