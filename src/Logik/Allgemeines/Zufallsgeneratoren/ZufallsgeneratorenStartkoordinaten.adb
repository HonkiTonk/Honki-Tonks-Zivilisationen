pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;

with LeseKarten;

with BewegungPassierbarkeitPruefen;

package body ZufallsgeneratorenStartkoordinaten is

   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
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
             LeseKarten.AktuellerGrund (KoordinatenExtern => (EAchse, YXAchsen.YAchse, YXAchsen.XAchse)) /= KartengrundDatentypen.Eis_Enum
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
      
      WerteWählen1000.Reset (PositionGewählt1000);
      
      YAchseSchleife:
      loop
         
         YAchse := WerteWählen1000.Random (PositionGewählt1000);
         
         if
           YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
         then
            exit YAchseSchleife;
            
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
      XAchseSchleife:
      loop
         
         XAchse := WerteWählen1000.Random (PositionGewählt1000);
         
         if
           XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
         then
            exit XAchseSchleife;
            
         else
            null;
         end if;
         
      end loop XAchseSchleife;
      
      return (YAchse, XAchse);
      
   end StartPunkteYXFestlegen;

end ZufallsgeneratorenStartkoordinaten;
