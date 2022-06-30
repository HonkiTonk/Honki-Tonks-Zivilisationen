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
      
      KartenpunktWählen.Reset (Gen => KartenpunktGewählt);
      
      PositionBestimmenSchleife:
      loop
         
         YAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                              First => KartenDatentypen.KartenfeldPositiv'First,
                                              Last  => Karten.Karteneinstellungen.Kartengröße.YAchse);
      
         XAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                              First => KartenDatentypen.KartenfeldPositiv'First,
                                              Last  => Karten.Karteneinstellungen.Kartengröße.XAchse);
         
         ------------------------ Diese Prüfungen hier mal verbessern/nach SpieleinstellungenRasseSpieler verschieben.
         if
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                  IDExtern              => 1,
                                                                  NeueKoordinatenExtern => (EAchse, YAchse, XAchse))
             = True
           and
             LeseKarten.AktuellerGrund (KoordinatenExtern => (EAchse, YAchse, XAchse)) /= KartengrundDatentypen.Eis_Enum
         then
            return (EAchse, YAchse, XAchse);
               
         else
            null;
         end if;
         
      end loop PositionBestimmenSchleife;
      
   end Startkoordinaten;

end ZufallsgeneratorenStartkoordinaten;
