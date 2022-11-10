pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenGebaut;

with Vergleiche;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

package body KIBewegungsbewertungLogik is

   -- KoordinatenExtern ist der aktuelle Punkt, NeueKoordinatenExtern ist der mögliche neue Punkt.
   function Positionsbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
   is begin
      
      Zielkoordinate := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => Zielkoordinate,
                                         KoordinatenZweiExtern => NeueKoordinatenExtern)
      is
         when True =>
            return KIKonstanten.BewertungBewegungZielpunkt;
         
         when False =>
            BewertungEAchse := EAchseBewerten (ZielebeneExtern     => Zielkoordinate.EAchse,
                                               AktuelleEbeneExtern => KoordinatenExtern.EAchse,
                                               NeueEbeneExtern     => NeueKoordinatenExtern.EAchse);
            
            BewertungYAchse := YAchseBewerten (ZielpunktExtern      => Zielkoordinate.YAchse,
                                               AktuellerPunktExtern => KoordinatenExtern.YAchse,
                                               NeuerPunktExtern     => NeueKoordinatenExtern.YAchse);
            
            BewertungXAchse := XAchseBewerten (ZielpunktExtern      => Zielkoordinate.XAchse,
                                               AktuellerPunktExtern => KoordinatenExtern.XAchse,
                                               NeuerPunktExtern     => NeueKoordinatenExtern.XAchse);
            
            KoordinateAlt := (abs (Zielkoordinate.EAchse - KoordinatenExtern.EAchse),
                              abs (Zielkoordinate.YAchse - KoordinatenExtern.YAchse),
                              abs (Zielkoordinate.XAchse - KoordinatenExtern.XAchse));

            -- Hier scheint es auch noch ein Range Problem zu geben, eventuell lösbar durch Umwandlung nach Integer? äöü
            KoordinateNeu := (abs (Zielkoordinate.EAchse - NeueKoordinatenExtern.EAchse),
                              abs (Zielkoordinate.YAchse - NeueKoordinatenExtern.YAchse),
                              abs (Zielkoordinate.XAchse - NeueKoordinatenExtern.XAchse));
      end case;
              
      if
        KoordinateNeu.EAchse > KoordinateAlt.EAchse
      then
         BewertungEAchse := 5;
         
      elsif
        KoordinateNeu.EAchse = KoordinateAlt.EAchse
      then
         BewertungEAchse := 3;
         
      else
         BewertungEAchse := 1;
      end if;
        
      if
        KoordinateNeu.YAchse < KoordinateAlt.YAchse
      then
         BewertungYAchse := 5;
         
      elsif
        KoordinateNeu.YAchse = KoordinateAlt.YAchse
      then
         BewertungYAchse := 3;
         
      else
         BewertungYAchse := 1;
      end if;
        
      if
        KoordinateNeu.XAchse < KoordinateAlt.XAchse
      then
         BewertungXAchse := 5;
         
      elsif
        KoordinateNeu.XAchse = KoordinateAlt.XAchse
      then
         BewertungXAchse := 3;
         
      else
         BewertungXAchse := 1;
      end if;
      
      return BewertungEAchse + BewertungYAchse + BewertungXAchse;
      
   end Positionsbewertung;
   
   
   
   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.BewegungBewertung
   is begin
      
      if
        AktuelleEbeneExtern = NeueEbeneExtern
      then
         null;
         
      elsif
        ZielebeneExtern = AktuelleEbeneExtern
      then
         null;
         
      else
         null;
      end if;
              
      return 0;
      
   end EAchseBewerten;
   
   
   
   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.BewegungBewertung
   is begin
      
      if
        ZielpunktExtern = AktuellerPunktExtern
        or
          ZielpunktExtern = NeuerPunktExtern
      then
         null;
         
      else
         null;
      end if;
      
      return 0;
      
   end YAchseBewerten;
   
   
   
   function XAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.BewegungBewertung
   is begin
      
      if
        ZielpunktExtern = AktuellerPunktExtern
        or
          ZielpunktExtern = NeuerPunktExtern
      then
         null;
         
      else
         null;
      end if;
      
      return 0;
      
   end XAchseBewerten;

end KIBewegungsbewertungLogik;
