pragma SPARK_Mode (Off);

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
     return KartenDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum
   is begin
      
      ZufälligeKartenressourcenWählen.Reset (ZufälligeKartenressourcenGewählt);
      return ZufälligeKartenressourcenWählen.Random (ZufälligeKartenressourcenGewählt);
      
   end ZufälligeKartenressourcen;
   
   
   
   function ZufälligeSpieleranzahl
     return Positive
   is begin
      
      ZufälligeSpieleranzahlRasseWählen.Reset (ZufälligeSpieleranzahlRasseGewählt);
      return SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (ZufälligeSpieleranzahlRasseWählen.Random (ZufälligeSpieleranzahlRasseGewählt));
      
   end ZufälligeSpieleranzahl;
   
   
   
   function ZufälligeRasse
     return SonstigeDatentypen.Rassen_Verwendet_Enum
   is begin
      
      ZufälligeSpieleranzahlRasseWählen.Reset (ZufälligeSpieleranzahlRasseGewählt);
      
      RasseWählenSchleife:
      loop
         
         RasseGewählt := ZufälligeSpieleranzahlRasseWählen.Random (ZufälligeSpieleranzahlRasseGewählt);
      
         case
           GlobaleVariablen.RassenImSpiel (RasseGewählt)
         is
            when SonstigeDatentypen.Leer =>
               return RasseGewählt;
            
            when others =>
               null;
         end case;
         
      end loop RasseWählenSchleife;
      
   end ZufälligeRasse;
   
   
   
   function ZufälligerSchwiewrigkeitsgrad
     return GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum
   is begin
      
      ZufälligenSchwierigkeitsgradWählen.Reset (ZufälligerSchwierigkeitsgradGewählt);
      return ZufälligenSchwierigkeitsgradWählen.Random (ZufälligerSchwierigkeitsgradGewählt);
      
   end ZufälligerSchwiewrigkeitsgrad;

end ZufallGeneratorenSpieleinstellungen;
