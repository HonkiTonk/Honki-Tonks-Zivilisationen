with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;
with EinheitenbewegungLogik;

with Diagnoseinformationen;

package body EinheitenbewegungsbereichLogik is

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      VorhandeneBewegungspunkte := Natural (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Bewegungsbereich := (others => (others => (others => False)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            if
              YAchseSchleifenwert /= 0
              or
                XAchseSchleifenwert /= 0
            then
               BewegungsbereichErmitteln (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                          KoordinatenExtern               => AktuelleKoordinaten,
                                          EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                          NotwendigeBewegungspunkteExtern => 0,
                                          VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               
            else
               null;
            end if;
         
         end loop XAchseSchleife;
         
         Diagnoseinformationen.Zahl (ZahlExtern => Integer (YAchseSchleifenwert));
         
      end loop YAchseSchleife;
      
   end BewegungsbereichBerechnen;
   
   
   
   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
   
      if
      abs (Integer (BewegungsfeldExtern.YAchse)) > VorhandeneBewegungspunkteExtern
        or
      abs (Integer (BewegungsfeldExtern.YAchse)) > Positive (LeseWeltkarteneinstellungen.YAchse)
        or
      abs (Integer (BewegungsfeldExtern.XAchse)) > VorhandeneBewegungspunkteExtern
        or
      abs (Integer (BewegungsfeldExtern.XAchse)) > Positive (LeseWeltkarteneinstellungen.XAchse)
      then
         return;
         
      else
         null;
      end if;
      
      case
        NotwendigeBewegungspunkteExtern
      is
         when 0 .. 25 =>
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                      LogikGrafikExtern => True);
         
         when others =>
            return;
      end case;
      
      case
        FeldPrüfen (NeueKoordinatenExtern           => Kartenwert,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when SystemDatentypen.False_Enum =>
            return;
            
         when SystemDatentypen.Neutral_Enum =>
            null;
            
         when SystemDatentypen.True_Enum =>
            Bewegungsbereich (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse) := True;
      end case;
         
      ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => Kartenwert,
                                                                                                        EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.XAchse < 0
              and
                XAchseSchleifenwert > 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.XAchse > 0
              and
                XAchseSchleifenwert < 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse < 0
              and
                YAchseSchleifenwert > 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse > 0
              and
                YAchseSchleifenwert < 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
                  
            else
               BewegungsbereichErmitteln (BewegungsfeldExtern             => (Kartenwert.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                          KoordinatenExtern               => KoordinatenExtern,
                                          EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                          NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                          VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewegungsbereichErmitteln;
   
   
      
   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      if
        NeueKoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return SystemDatentypen.False_Enum;
         
         -- elsif
         --   Bewegungsbereich (NeueKoordinatenExtern.EAchse, NeueKoordinatenExtern.YAchse, NeueKoordinatenExtern.XAchse) = True
         -- then
         --    return SystemDatentypen.False_Enum;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => NeueKoordinatenExtern)
      then
         return SystemDatentypen.False_Enum;
         
      else
         ZwischenrechnungBewegungspunkte := NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                                                                                 EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      end if;
         
      if
        VorhandeneBewegungspunkteExtern = ZwischenrechnungBewegungspunkte
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        VorhandeneBewegungspunkteExtern < ZwischenrechnungBewegungspunkte
        and
          VorhandeneBewegungspunkteExtern - NotwendigeBewegungspunkteExtern <= Positive (EinheitenKonstanten.MinimalerBewegungspunkt)
      then
         return SystemDatentypen.False_Enum;
         
      else
         Stadt := StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => NeueKoordinatenExtern);
      end if;
      
      if
        Stadt.Rasse = StadtKonstanten.LeerRasse
        or
          Stadt.Rasse = EinheitRasseNummerExtern.Rasse
      then
         Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinatenExtern,
                                                                          LogikGrafikExtern => True);
            
      else
         return SystemDatentypen.Neutral_Enum;
      end if;
         
      if
        EinheitenKonstanten.LeerRasse = Einheit.Rasse
      then
         return SystemDatentypen.True_Enum;
         
      elsif
        Einheit.Rasse = EinheitRasseNummerExtern.Rasse
        and
          True = EinheitenbewegungLogik.EinheitentauschPrüfung (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                                                 StehendeEinheitExtern  => Einheit)
      then
         return SystemDatentypen.True_Enum;
         
      else
         return SystemDatentypen.Neutral_Enum;
      end if;
      
   end FeldPrüfen;

end EinheitenbewegungsbereichLogik;
