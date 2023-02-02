with KartenKonstanten;
with StadtKonstanten;
with StadtDatentypen;
with SpeziesKonstanten;

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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      VorhandeneBewegungspunkte := Natural (LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
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
                                             EinheitSpeziesNummerExtern      => EinheitSpeziesNummerExtern,
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
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
                     EinheitSpeziesNummerExtern      => EinheitSpeziesNummerExtern,
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

      ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern      => Kartenwert,
                                                                                                        EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
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
                                             EinheitSpeziesNummerExtern      => EinheitSpeziesNummerExtern,
                                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

   end BewegungsbereichErmitteln;
   
   
      
   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        NeueKoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                          NeueKoordinatenExtern      => NeueKoordinatenExtern)
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        Bewegungsbereich (NeueKoordinatenExtern.EAchse, NeueKoordinatenExtern.YAchse, NeueKoordinatenExtern.XAchse) = False
      then
         ZwischenrechnungBewegungspunkte := NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                                                                                                                                 EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
         
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
         Stadt := StadtSuchenLogik.KoordinatenStadtOhneSpezielleSpeziesSuchen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                                               KoordinatenExtern => NeueKoordinatenExtern);
         Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => NeueKoordinatenExtern,
                                                                            LogikGrafikExtern => True);
      end if;
      
      if
        Stadt.Nummer = StadtKonstanten.LeerNummer
      then
         null;
         
      elsif
        LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => Stadt) /= NeueKoordinatenExtern
      then
         null;
         
      elsif
        Stadt.Spezies = EinheitSpeziesNummerExtern.Spezies
        and
          Einheit.Spezies = SpeziesKonstanten.LeerSpezies
      then
         return SystemDatentypen.True_Enum;
         
      else
         null;
      end if;
         
      if
        SpeziesKonstanten.LeerSpezies = Einheit.Spezies
      then
         return SystemDatentypen.True_Enum;
         
      elsif
        Einheit.Spezies /= EinheitSpeziesNummerExtern.Spezies
      then
         return SystemDatentypen.Neutral_Enum;
         
      elsif
        False = EinheitenbewegungLogik.EinheitentauschPrüfung (BewegendeEinheitExtern => EinheitSpeziesNummerExtern,
                                                                StehendeEinheitExtern  => Einheit)
      then
         return SystemDatentypen.Neutral_Enum;
         
      else
         return SystemDatentypen.True_Enum;
      end if;
      
   end FeldPrüfen;

end EinheitenbewegungsbereichLogik;
