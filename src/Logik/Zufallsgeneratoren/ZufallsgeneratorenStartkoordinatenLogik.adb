package body ZufallsgeneratorenStartkoordinatenLogik is

   function Startkoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Rassen_Unterirdisch_Enum'Range =>
            Startkoordinate.EAchse := -1;
            
         when RassenDatentypen.Rassen_Überirdisch_Enum'Range =>
            Startkoordinate.EAchse := 0;
      end case;
      
      KartenpunktWählen.Reset (Gen => KartenpunktGewählt);
         
      Startkoordinate.YAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First,
                                                           Last  => Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
      
      Startkoordinate.XAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First,
                                                           Last  => Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
         
      return Startkoordinate;
      
   end Startkoordinaten;

end ZufallsgeneratorenStartkoordinatenLogik;
