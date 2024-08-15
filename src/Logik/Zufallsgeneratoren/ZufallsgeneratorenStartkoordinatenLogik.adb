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
      
      YKartenpunktWählen.Reset (Gen => YKartenpunktGewählt);
      
      -- Das +1/-1 ist hier, damit man nicht direkt am Kartenrand platziert wird.
      Startkoordinate.YAchse := YKartenpunktWählen.Random (Gen   => YKartenpunktGewählt,
                                                            First => KartenDatentypen.SenkrechtePositiv'First + 1,
                                                            Last  => LeseWeltkarteneinstellungen.YAchse - 1);
      
      XKartenpunktWählen.Reset (Gen => XKartenpunktGewählt);

      -- Das +1/-1 ist hier, damit man nicht direkt am Kartenrand platziert wird.
      Startkoordinate.XAchse := XKartenpunktWählen.Random (Gen   => XKartenpunktGewählt,
                                                            First => KartenDatentypen.WaagerechtePositiv'First + 1,
                                                            Last  => LeseWeltkarteneinstellungen.XAchse - 1);
         
      return Startkoordinate;
      
   end Startkoordinaten;

end ZufallsgeneratorenStartkoordinatenLogik;
