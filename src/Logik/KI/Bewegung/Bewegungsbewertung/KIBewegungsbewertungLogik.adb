with KartenKonstanten;

with LeseEinheitenGebaut;

with KIEAchsenbewertung;
with KIYAchsenbewertung;
with KIXAchsenbewertung;

package body KIBewegungsbewertungLogik is

   function PositionsbewertungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Zielkoordinaten.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenDatentypen.KartenfeldNatural'Last;
            
         when others =>
            return PositionsbewertungKoordinaten (ZielkoordinatenExtern => Zielkoordinaten,
                                                  NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end PositionsbewertungEinheit;
   
   
   
   function PositionsbewertungKoordinaten
     (ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      BewertungEAchse := KIEAchsenbewertung.EAchseBewerten (ZielebeneExtern => ZielkoordinatenExtern.EAchse,
                                                            NeueEbeneExtern => NeueKoordinatenExtern.EAchse);
            
      BewertungYAchse := KIYAchsenbewertung.YAchseBewerten (ZielpunktExtern  => ZielkoordinatenExtern.YAchse,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.YAchse);
            
      BewertungXAchse := KIXAchsenbewertung.XAchseBewerten (ZielpunktExtern  => ZielkoordinatenExtern.XAchse,
                                                            NeuerPunktExtern => NeueKoordinatenExtern.XAchse);
      
      if
        Natural (BewertungEAchse) + Natural (BewertungYAchse) + Natural (BewertungXAchse) >= Natural (KartenDatentypen.KartenfeldPositiv'Last)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      else
         return BewertungEAchse + BewertungYAchse + BewertungXAchse;
      end if;
      
   end PositionsbewertungKoordinaten;

end KIBewegungsbewertungLogik;
