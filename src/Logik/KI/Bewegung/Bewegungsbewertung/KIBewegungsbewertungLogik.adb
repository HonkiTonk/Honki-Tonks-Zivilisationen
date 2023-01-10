with LeseEinheitenGebaut;

with KIEAchsenbewertung;
with KIYAchsenbewertung;
with KIXAchsenbewertung;

package body KIBewegungsbewertungLogik is

   function Positionsbewertung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Zielkoordinate := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      BewertungEAchse := KIEAchsenbewertung.EAchseBewerten (ZielebeneExtern     => Zielkoordinate.EAchse,
                                                            NeueEbeneExtern     => NeueKoordinatenExtern.EAchse);
            
      BewertungYAchse := KIYAchsenbewertung.YAchseBewerten (ZielpunktExtern      => Zielkoordinate.YAchse,
                                                            NeuerPunktExtern     => NeueKoordinatenExtern.YAchse);
            
      BewertungXAchse := KIXAchsenbewertung.XAchseBewerten (ZielpunktExtern      => Zielkoordinate.XAchse,
                                                            NeuerPunktExtern     => NeueKoordinatenExtern.XAchse);
      
      if
        Natural (BewertungEAchse) + Natural (BewertungYAchse) + Natural (BewertungXAchse) >= Natural (KartenDatentypen.KartenfeldPositiv'Last)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      else
         return BewertungEAchse + BewertungYAchse + BewertungXAchse;
      end if;
      
   end Positionsbewertung;

end KIBewegungsbewertungLogik;
