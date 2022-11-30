with LeseEinheitenGebaut;

with KIEAchsenbewertung;
with KIYAchsenbewertung;
with KIXAchsenbewertung;

package body KIBewegungsbewertungLogik is

   function Positionsbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Zielkoordinate := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Zielkoordinate = NeueKoordinatenExtern
      is
         when True =>
            return KartenDatentypen.KartenfeldNatural'First;
         
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
      end case;
      
      if
        Natural (BewertungEAchse) + Natural (BewertungYAchse) + Natural (BewertungXAchse) >= Positive (KartenDatentypen.KartenfeldPositiv'Last)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      else
         return BewertungEAchse + BewertungYAchse + BewertungXAchse;
      end if;
      
   end Positionsbewertung;

end KIBewegungsbewertungLogik;
