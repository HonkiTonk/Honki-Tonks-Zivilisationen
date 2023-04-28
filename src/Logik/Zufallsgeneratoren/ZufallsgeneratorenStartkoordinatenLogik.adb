with KartenKonstanten;

package body ZufallsgeneratorenStartkoordinatenLogik is

   function Startkoordinaten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Spezies_Unterirdisch_Enum'Range =>
            Startkoordinate.EAchse := KartenKonstanten.UnterflächeKonstante;
            
         when SpeziesDatentypen.Spezies_Überirdisch_Enum'Range =>
            Startkoordinate.EAchse := KartenKonstanten.OberflächeKonstante;
      end case;
      
      KartenpunktWählen.Reset (Gen => KartenpunktGewählt);
      
      -- Warum ist das hier +2/-2 und nicht +1/-1? äöü
      Startkoordinate.YAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First + 2,
                                                           Last  => LeseWeltkarteneinstellungen.YAchse - 2);
      
      Startkoordinate.XAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First + 2,
                                                           Last  => LeseWeltkarteneinstellungen.XAchse - 2);
         
      return Startkoordinate;
      
   end Startkoordinaten;

end ZufallsgeneratorenStartkoordinatenLogik;
