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
      
      BenötigteBewegungspunkte := NotwendigeBewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        AktuelleBewegungspunkte < BenötigteBewegungspunkte
        and
          AktuelleBewegungspunkte <= EinheitenKonstanten.MinimalerBewegungspunkt
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
            
      BewegungspunkteNotwendig := NotwendigeBewegungspunkteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      if
        BewegungspunkteNotwendig < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         BewegungspunkteNotwendig := EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         null;
      end if;
      
      return BewegungspunkteNotwendig;
      
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
      
      BewegungspunkteGesamt := Positive (LeseKartenDatenbanken.BewegungBasisgrund (GrundExtern => Gesamtgrund.Basisgrund,
                                                                                   RasseExtern => EinheitRasseNummerExtern.Rasse))
        + Natural (LeseKartenDatenbanken.BewegungZusatzgrund (GrundExtern => Gesamtgrund.Zusatzgrund,
                                                              RasseExtern => EinheitRasseNummerExtern.Rasse))
        + Integer (LeseVerbesserungenDatenbank.BewegungWeg (WegExtern   => LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern),
                                                            RasseExtern => EinheitRasseNummerExtern.Rasse));
      
      if
        BewegungspunkteGesamt >= Positive (EinheitenDatentypen.VorhandeneBewegungspunkte'Last)
      then
         return EinheitenDatentypen.VorhandeneBewegungspunkte'Last;
         
      else
         return EinheitenDatentypen.Bewegungspunkte (BewegungspunkteGesamt);
      end if;
      
   end NotwendigeBewegungspunkteErmitteln;

end BewegungspunkteBerechnenLogik;
