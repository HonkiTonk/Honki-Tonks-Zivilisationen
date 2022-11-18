with LeseEinheitenGebaut;

with KIKonstanten;

with KIEAchsenbewertung;
with KIYAchsenbewertung;
with KIXAchsenbewertung;

package body KIBewegungsbewertungLogik is

   function Positionsbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Zielkoordinate := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Zielkoordinate = NeueKoordinatenExtern
      is
         when True =>
            return KIKonstanten.BewertungBewegungZielpunkt;
         
         when False =>
            BewertungEAchse := KIEAchsenbewertung.EAchseBewerten (ZielebeneExtern     => Zielkoordinate.EAchse,
                                                                  AktuelleEbeneExtern => AktuelleKoordinatenExtern.EAchse,
                                                                  NeueEbeneExtern     => NeueKoordinatenExtern.EAchse);
            
            BewertungYAchse := KIYAchsenbewertung.YAchseBewerten (ZielpunktExtern      => Zielkoordinate.YAchse,
                                                                  AktuellerPunktExtern => AktuelleKoordinatenExtern.YAchse,
                                                                  NeuerPunktExtern     => NeueKoordinatenExtern.YAchse);
            
            BewertungXAchse := KIXAchsenbewertung.XAchseBewerten (ZielpunktExtern      => Zielkoordinate.XAchse,
                                                                  AktuellerPunktExtern => AktuelleKoordinatenExtern.XAchse,
                                                                  NeuerPunktExtern     => NeueKoordinatenExtern.XAchse);
      
            return BewertungEAchse + BewertungYAchse + BewertungXAchse;
      end case;
      
   end Positionsbewertung;

end KIBewegungsbewertungLogik;
