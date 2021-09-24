pragma SPARK_Mode (Off);

with LeseKarten;

with BewegungPassierbarkeitPruefen;

package body ZufallGeneratorenKarten is

   function StartPosition
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse := StartPositionEAchse (RasseExtern => RasseExtern);

      PositionBestimmenSchleife:
      loop
         
         StartPunkteYXFestlegen;
         
         if
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                  IDExtern           => 1,
                                                                  NeuePositionExtern => (EAchse, YAchse, XAchse))
             = True
           and
             LeseKarten.Grund (PositionExtern => (EAchse, YAchse, XAchse)) /= GlobaleDatentypen.Eis 
         then
            return (EAchse, YAchse, XAchse);
               
         else
            null;
         end if;
         
      end loop PositionBestimmenSchleife;
      
   end StartPosition;
   
   
   
   function StartPositionEAchse
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.EbeneVorhanden
   is begin
      
      case
        RasseExtern
      is
         when GlobaleDatentypen.Talbidahr | GlobaleDatentypen.Tesorahn =>
            -- Vorübergehend geändert, da alle Rassen gerade den menschlichen Einheitenbaum haben
            return 0; -- -1;
            
         when others =>
            return 0;
      end case;
      
   end StartPositionEAchse;
   
   
   
   procedure StartPunkteYXFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when GlobaleDatentypen.Karte_20_20 =>
            WerteWählen20.Reset (PositionGewählt20);
            YAchse := WerteWählen20.Random (PositionGewählt20);
            XAchse := WerteWählen20.Random (PositionGewählt20);

         when GlobaleDatentypen.Karte_40_40 =>
            WerteWählen40.Reset (PositionGewählt40);
            YAchse := WerteWählen40.Random (PositionGewählt40);
            XAchse := WerteWählen40.Random (PositionGewählt40);
            
         when GlobaleDatentypen.Karte_80_80 =>
            WerteWählen80.Reset (PositionGewählt80);
            YAchse := WerteWählen80.Random (PositionGewählt80);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when GlobaleDatentypen.Karte_120_80 =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when GlobaleDatentypen.Karte_120_160 =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when GlobaleDatentypen.Karte_160_160 =>
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen160.Random (PositionGewählt160);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when GlobaleDatentypen.Karte_240_240 =>
            WerteWählen240.Reset (PositionGewählt240);
            YAchse := WerteWählen240.Random (PositionGewählt240);
            XAchse := WerteWählen240.Random (PositionGewählt240);
            
         when GlobaleDatentypen.Karte_320_320 =>
            WerteWählen320.Reset (PositionGewählt320);
            YAchse := WerteWählen320.Random (PositionGewählt320);
            XAchse := WerteWählen320.Random (PositionGewählt320);
            
         when GlobaleDatentypen.Karte_1000_1000 =>
            WerteWählen1000.Reset (PositionGewählt1000);
            YAchse := WerteWählen1000.Random (PositionGewählt1000);
            XAchse := WerteWählen1000.Random (PositionGewählt1000);

         when others =>
            WerteWählen1000.Reset (PositionGewählt1000);
            BenutzerdefinierteAuswahlSchleife:
            loop
               
               YAchse := WerteWählen1000.Random (PositionGewählt1000);
               XAchse := WerteWählen1000.Random (PositionGewählt1000);

               if
                 YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                 and
                   XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
               then
                  exit BenutzerdefinierteAuswahlSchleife;

               else
                  null;
               end if;
               
            end loop BenutzerdefinierteAuswahlSchleife;
      end case;
      
   end StartPunkteYXFestlegen;



   function ZufälligerWert
     return Float
   is begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end ZufälligerWert;



   function ChaoskarteGrund
     return GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      return WerteWählenChaoskarte.Random (GrundGewählt);
      
   end ChaoskarteGrund;
   
   
   
   function ChaoskarteFluss
     return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      FlussWählenChaoskarte.Reset (FlussGewählt);
      
      WählenSchleife:
      loop
         
         FlussWert := FlussWählenChaoskarte.Random (FlussGewählt);
         
         if
           FlussWert in GlobaleDatentypen.Karten_Fluss_Enum'Range
         then
            return FlussWert;
                  
         else
            return GlobaleDatentypen.Leer;
         end if;
         
      end loop WählenSchleife;
      
   end ChaoskarteFluss;
   
   
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      RessourceWählenChaoskarte.Reset (RessourceGewählt);
      
      WählenSchleife:
      loop
         
         RessourceWert := RessourceWählenChaoskarte.Random (RessourceGewählt);
         
         case
           WasserLandExtern
         is
            when True =>
               if
                 RessourceWert in GlobaleDatentypen.Karten_Grund_Ressourcen_Wasser'Range
               then
                  return RessourceWert;
                  
               else
                  return GlobaleDatentypen.Leer;
               end if;

            when False =>
               if
                 RessourceWert in GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range
               then
                  return RessourceWert;
                  
               else
                  return GlobaleDatentypen.Leer;
               end if;
         end case;
         
      end loop WählenSchleife;
      
   end ChaoskarteRessource;

end ZufallGeneratorenKarten;
