with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

package body BewegungspunkteBerechnenLogik is

   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      AktuelleBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      NotwendigeBewegungspunkte := NotwendigeBewegungspunkteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      if
        NotwendigeBewegungspunkte < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         NotwendigeBewegungspunkte := EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         null;
      end if;
      
      if
        AktuelleBewegungspunkte < NotwendigeBewegungspunkte
        and
          AktuelleBewegungspunkte = EinheitenKonstanten.MinimalerBewegungspunkt
      then
         return EinheitenKonstanten.LeerBewegungspunkte;
         
      else
         return NotwendigeBewegungspunkte;
      end if;
      
   end AbzugDurchBewegung;

   

   function NotwendigeBewegungspunkteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      case
        NeueKoordinatenExtern.EAchse
      is
         when KartenDatentypen.EbeneOberfläche =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

            if
              True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                            IDExtern             => EinheitID,
                                                            WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
              or
                True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                              IDExtern             => EinheitID,
                                                              WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum)
            then
               return EinheitenKonstanten.StandardBewegungspunkt;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => NeueKoordinatenExtern);
      
      -- Es gibt hier noch keine Prüfung ob das Ergebnis überhaupt im erlaubten Bereich ist, später einbauen. äöü
      return LeseKartenDatenbanken.BewegungBasisgrund (GrundExtern => Gesamtgrund.Basisgrund,
                                                       RasseExtern => EinheitRasseNummerExtern.Rasse)
        + LeseKartenDatenbanken.BewegungZusatzgrund (GrundExtern => Gesamtgrund.Zusatzgrund,
                                                     RasseExtern => EinheitRasseNummerExtern.Rasse)
        + LeseVerbesserungenDatenbank.BewegungWeg (WegExtern   => LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern),
                                                   RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end NotwendigeBewegungspunkteErmitteln;

end BewegungspunkteBerechnenLogik;
