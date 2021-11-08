pragma SPARK_Mode (Off);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package body ZufallGeneratorenSpieleinstellungen is
   
   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum
   is begin
      
      ZufälligeKartengrößeWählen.Reset (ZufälligeKartenGrößeGewählt);
      return ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
        
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
      
      MenschVorhanden := False;
      GlobaleVariablen.RassenImSpiel := (others => SystemDatentypen.Leer);
      ZufälligeRassenWählen.Reset (ZufälligeRassenGewählt);
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         RasseImSpiel := ZufälligeRassenWählen.Random (ZufälligeRassenGewählt);

         if
           RasseImSpiel = SystemDatentypen.Spieler_Mensch
           and
             MenschVorhanden = False
         then
            GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := RasseImSpiel;
            MenschVorhanden := True;
            
         elsif
           RasseImSpiel = SystemDatentypen.Spieler_Mensch
         then
            null;
            
         else
            GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := RasseImSpiel;
         end if;
         
      end loop RassenSchleife;
      
      case
        MenschVorhanden
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      MenschlicherSpielerSchleife:
      for MenschlicheRasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop

         if
           GlobaleVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) = SystemDatentypen.Spieler_KI
         then
            GlobaleVariablen.RassenImSpiel (MenschlicheRasseSchleifenwert) := SystemDatentypen.Spieler_Mensch;
            return;
            
         else
            null;
         end if;
         
      end loop MenschlicherSpielerSchleife;
      
   end ZufälligeRassen;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;

end ZufallGeneratorenSpieleinstellungen;
