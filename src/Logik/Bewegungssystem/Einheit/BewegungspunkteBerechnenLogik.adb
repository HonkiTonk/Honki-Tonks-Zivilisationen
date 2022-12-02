with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

package body BewegungspunkteBerechnenLogik is

   function Bewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
      AktuelleBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BenötigteBewegungspunkte := NotwendigeBewegungspunkteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      if
        BenötigteBewegungspunkte < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         BenötigteBewegungspunkte := EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         null;
      end if;
      
      if
        AktuelleBewegungspunkte < BenötigteBewegungspunkte
        and
          AktuelleBewegungspunkte = EinheitenKonstanten.MinimalerBewegungspunkt
      then
         return EinheitenKonstanten.LeerBewegungspunkte;
         
      else
         return BenötigteBewegungspunkte;
      end if;
      
   end Bewegungspunkte;
   
   
   
   function NotwendigeBewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
            
      BenötigteBewegungspunkte := NotwendigeBewegungspunkteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      if
        BenötigteBewegungspunkte < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         BenötigteBewegungspunkte := EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         null;
      end if;
      
      return BenötigteBewegungspunkte;
      
   end NotwendigeBewegungspunkte;

   

   function NotwendigeBewegungspunkteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
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
