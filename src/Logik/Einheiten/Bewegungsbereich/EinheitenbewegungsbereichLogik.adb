with KartenKonstanten;
with StadtKonstanten;
with StadtDatentypen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;
with EinheitenbewegungLogik;

package body EinheitenbewegungsbereichLogik is

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      VorhandeneBewegungspunkte := Natural (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Bewegungsbereich := (others => (others => (others => False)));
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
               if
                 YAchseSchleifenwert /= 0
                 or
                   XAchseSchleifenwert /= 0
               then
                  BewegungsbereichErmitteln (BewegungsfeldExtern             => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                             KoordinatenExtern               => AktuelleKoordinaten,
                                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                             NotwendigeBewegungspunkteExtern => 0,
                                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               
               else
                  null;
               end if;
         
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end BewegungsbereichBerechnen;
   
   
   
   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is
      use type KartenDatentypen.Ebene;
   begin

      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                ÄnderungExtern    => (BewegungsfeldExtern.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                LogikGrafikExtern => True);

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
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

               if
                 YAchseSchleifenwert = 0
                 and
                   XAchseSchleifenwert = 0
                   and
                     EAchseSchleifenwert = 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.EAchse < 0
                 and
                   EAchseSchleifenwert > 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.EAchse > 0
                 and
                   EAchseSchleifenwert < 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.XAchse < 0
                 and
                   XAchseSchleifenwert >= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.XAchse > 0
                 and
                   XAchseSchleifenwert <= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.YAchse < 0
                 and
                   YAchseSchleifenwert >= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.YAchse > 0
                 and
                   YAchseSchleifenwert <= 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.EAchse + EAchseSchleifenwert not in KartenDatentypen.EbeneVorhanden'Range
               then
                  null;

               else
                  BewegungsbereichErmitteln (BewegungsfeldExtern             => (BewegungsfeldExtern.EAchse + EAchseSchleifenwert,
                                                                                 BewegungsfeldExtern.YAchse + YAchseSchleifenwert,
                                                                                 BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                                             KoordinatenExtern               => KoordinatenExtern,
                                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

   end BewegungsbereichErmitteln;
   
   
      
   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        NeueKoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => NeueKoordinatenExtern)
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        Bewegungsbereich (NeueKoordinatenExtern.EAchse, NeueKoordinatenExtern.YAchse, NeueKoordinatenExtern.XAchse) = False
      then
         ZwischenrechnungBewegungspunkte := NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                                                                                 EinheitRasseNummerExtern => EinheitRasseNummerExtern));
         
      else
         return SystemDatentypen.False_Enum;
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
         Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinatenExtern,
                                                                          LogikGrafikExtern => True);
      end if;
      
      if
        Stadt.Nummer = StadtKonstanten.LeerNummer
      then
         null;
         
      elsif
        LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => Stadt) /= NeueKoordinatenExtern
      then
         null;
         
      elsif
        Stadt.Rasse = EinheitRasseNummerExtern.Rasse
        and
          Einheit.Rasse = EinheitenKonstanten.LeerRasse
      then
         return SystemDatentypen.True_Enum;
         
      else
         null;
      end if;
         
      if
        EinheitenKonstanten.LeerRasse = Einheit.Rasse
      then
         return SystemDatentypen.True_Enum;
         
      elsif
        Einheit.Rasse /= EinheitRasseNummerExtern.Rasse
      then
         return SystemDatentypen.Neutral_Enum;
         
      elsif
        False = EinheitenbewegungLogik.EinheitentauschPrüfung (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                                                StehendeEinheitExtern  => Einheit)
      then
         return SystemDatentypen.Neutral_Enum;
         
      else
         return SystemDatentypen.True_Enum;
      end if;
      
   end FeldPrüfen;

end EinheitenbewegungsbereichLogik;
