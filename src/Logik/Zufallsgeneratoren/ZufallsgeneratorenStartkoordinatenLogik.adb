with KartenKonstanten;

package body ZufallsgeneratorenStartkoordinatenLogik is

   function Startkoordinaten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
      
      -- Das +1/-1 ist hier, damit man nicht direkt am Kartenrand platziert wird.
      Startkoordinate.YAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First + 1,
                                                           Last  => LeseWeltkarteneinstellungen.YAchse - 1);
      
      Startkoordinate.XAchse := KartenpunktWählen.Random (Gen   => KartenpunktGewählt,
                                                           First => KartenDatentypen.KartenfeldPositiv'First + 1,
                                                           Last  => LeseWeltkarteneinstellungen.XAchse - 1);
         
      return Startkoordinate;
      
   end Startkoordinaten;

end ZufallsgeneratorenStartkoordinatenLogik;
