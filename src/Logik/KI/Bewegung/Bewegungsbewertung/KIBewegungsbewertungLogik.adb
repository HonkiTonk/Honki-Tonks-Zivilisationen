with KartenKonstanten;

with LeseEinheitenGebaut;

with KIEAchsenbewertung;
with KIYAchsenbewertung;
with KIXAchsenbewertung;

package body KIBewegungsbewertungLogik is

   function PositionsbewertungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Zielkoordinaten.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenDatentypen.SenkrechteNatural'Last;
            
         when others =>
            return PositionsbewertungKoordinaten (ZielkoordinatenExtern => Zielkoordinaten,
                                                  NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end PositionsbewertungEinheit;
   
   
   
   function PositionsbewertungKoordinaten
     (ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      BewertungEAchse := KIEAchsenbewertung.EAchseBewerten (ZielebeneExtern => ZielkoordinatenExtern.EAchse,
                                                            NeueEbeneExtern => NeueKoordinatenExtern.EAchse);
            
      BewertungYAchse := KIYAchsenbewertung.YAchseBewerten (ZielpunktExtern  => ZielkoordinatenExtern.YAchse,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.YAchse);
            
      BewertungXAchse := KIXAchsenbewertung.XAchseBewerten (ZielpunktExtern  => ZielkoordinatenExtern.XAchse,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.XAchse);
      
      if
        Natural (BewertungEAchse) + Natural (BewertungYAchse) + Natural (BewertungXAchse) >= Natural (KartenDatentypen.SenkrechtePositiv'Last)
      then
         return KartenDatentypen.SenkrechtePositiv'Last;
         
      else
         return BewertungEAchse + BewertungYAchse + KartenDatentypen.Senkrechte (BewertungXAchse);
      end if;
      
   end PositionsbewertungKoordinaten;

end KIBewegungsbewertungLogik;
