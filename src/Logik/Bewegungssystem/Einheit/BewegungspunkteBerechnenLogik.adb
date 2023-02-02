with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

package body BewegungspunkteBerechnenLogik is

   -- Eventuell Bewegungspunkte entfernen und überall durch NotwendigeBewegungspunkte ersetzen? äöü
   function Bewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
      AktuelleBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      BenötigteBewegungspunkte := NotwendigeBewegungspunkte (NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                                              EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
            
      BewegungspunkteNotwendig := NotwendigeBewegungspunkteErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                      NeueKoordinatenExtern      => NeueKoordinatenExtern);
      
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.Bewegungspunkte
   is begin
      
      case
        NeueKoordinatenExtern.EAchse
      is
         when KartenDatentypen.EbeneOberfläche =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);

            if
              True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                            IDExtern             => EinheitID,
                                                            WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
              or
                True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
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
      
      BewegungspunkteGesamt := Positive (LeseKartenDatenbanken.BewegungBasisgrund (GrundExtern   => Gesamtgrund.Basisgrund,
                                                                                   SpeziesExtern => EinheitSpeziesNummerExtern.Spezies))
        + Natural (LeseKartenDatenbanken.BewegungZusatzgrund (GrundExtern   => Gesamtgrund.Zusatzgrund,
                                                              SpeziesExtern => EinheitSpeziesNummerExtern.Spezies))
        + Integer (LeseVerbesserungenDatenbank.BewegungWeg (WegExtern     => LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern),
                                                            SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      
      if
        BewegungspunkteGesamt >= Positive (EinheitenDatentypen.VorhandeneBewegungspunkte'Last)
      then
         return EinheitenDatentypen.VorhandeneBewegungspunkte'Last;
         
      else
         return EinheitenDatentypen.Bewegungspunkte (BewegungspunkteGesamt);
      end if;
      
   end NotwendigeBewegungspunkteErmitteln;

end BewegungspunkteBerechnenLogik;
