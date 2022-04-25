pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;

with LeseKarten;

with BewegungPassierbarkeitPruefen;

package body ZufallsgeneratorenStartkoordinaten is

   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Rassen_Unterirdisch_ENum'Range =>
            EAchse := -1;
            
         when RassenDatentypen.Rassen_Überirdisch_Enum'Range =>
            EAchse := 0;
      end case;
      
      PositionBestimmenSchleife:
      loop
         
         YXAchsen := StartPunkteYXFestlegen;
         
         ------------------------ Diese Prüfungen hier mal verbessern/nach SpieleinstellungenRasseSpieler verschieben.
         if
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                  IDExtern              => 1,
                                                                  NeueKoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse))
             = True
           and
             LeseKarten.Grund (KoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse)) /= KartenGrundDatentypen.Eis_Enum
         then
            return (EAchse, YXAchsen.YAchse, YXAchsen.XAchse);
               
         else
            null;
         end if;
         
      end loop PositionBestimmenSchleife;
      
   end Startkoordinaten;
   
   
   
   function StartPunkteYXFestlegen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartenparameter.Kartengröße
      is
         when KartenDatentypen.Kartengröße_20_20_Enum =>
            WerteWählen20.Reset (PositionGewählt20);
            YAchse := WerteWählen20.Random (PositionGewählt20);
            XAchse := WerteWählen20.Random (PositionGewählt20);

         when KartenDatentypen.Kartengröße_40_40_Enum =>
            WerteWählen40.Reset (PositionGewählt40);
            YAchse := WerteWählen40.Random (PositionGewählt40);
            XAchse := WerteWählen40.Random (PositionGewählt40);
            
         when KartenDatentypen.Kartengröße_80_80_Enum =>
            WerteWählen80.Reset (PositionGewählt80);
            YAchse := WerteWählen80.Random (PositionGewählt80);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenDatentypen.Kartengröße_120_80_Enum =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen80.Random (PositionGewählt80);
            
         when KartenDatentypen.Kartengröße_120_160_Enum =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen120.Random (PositionGewählt120);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenDatentypen.Kartengröße_160_160_Enum =>
            WerteWählen160.Reset (PositionGewählt160);
            YAchse := WerteWählen160.Random (PositionGewählt160);
            XAchse := WerteWählen160.Random (PositionGewählt160);
            
         when KartenDatentypen.Kartengröße_240_240_Enum =>
            WerteWählen240.Reset (PositionGewählt240);
            YAchse := WerteWählen240.Random (PositionGewählt240);
            XAchse := WerteWählen240.Random (PositionGewählt240);
            
         when KartenDatentypen.Kartengröße_320_320_Enum =>
            WerteWählen320.Reset (PositionGewählt320);
            YAchse := WerteWählen320.Random (PositionGewählt320);
            XAchse := WerteWählen320.Random (PositionGewählt320);
            
         when KartenDatentypen.Kartengröße_1000_1000_Enum =>
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
                 YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
                 and
                   XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
               then
                  exit BenutzerdefinierteAuswahlSchleife;

               else
                  null;
               end if;
               
            end loop BenutzerdefinierteAuswahlSchleife;
      end case;
      
      return (YAchse, XAchse);
      
   end StartPunkteYXFestlegen;

end ZufallsgeneratorenStartkoordinaten;
