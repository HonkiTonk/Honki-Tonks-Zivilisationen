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
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
               if
                 SenkrechteSchleifenwert /= 0
                 or
                   WaagerechteSchleifenwert /= 0
               then
                  BewegungsbereichErmitteln (BewegungsfeldExtern             => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             KoordinatenExtern               => AktuelleKoordinaten,
                                             EinheitSpeziesNummerExtern      => EinheitSpeziesNummerExtern,
                                             NotwendigeBewegungspunkteExtern => 0,
                                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
               
               else
                  null;
               end if;
         
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
   end BewegungsbereichBerechnen;
   
   
   
   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.KartenfeldRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is
      use type KartenDatentypen.Ebene;
   begin

      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                ÄnderungExtern    => (BewegungsfeldExtern.Ebene, BewegungsfeldExtern.Senkrechte, BewegungsfeldExtern.Waagerechte),
                                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);

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
            Bewegungsbereich (Kartenwert.Ebene, Kartenwert.Senkrechte, Kartenwert.Waagerechte) := True;
      end case;

      ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern      => Kartenwert,
                                                                                                        EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop

               if
                 SenkrechteSchleifenwert = 0
                 and
                   WaagerechteSchleifenwert = 0
                   and
                     EbeneSchleifenwert = 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.Ebene < 0
                 and
                   EbeneSchleifenwert > 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.Ebene > 0
                 and
                   EbeneSchleifenwert < 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.Waagerechte < 0
                 and
                   WaagerechteSchleifenwert >= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.Waagerechte > 0
                 and
                   WaagerechteSchleifenwert <= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.Senkrechte < 0
                 and
                   SenkrechteSchleifenwert >= 0
               then
                  null;

               elsif
                 BewegungsfeldExtern.Senkrechte > 0
                 and
                   SenkrechteSchleifenwert <= 0
               then
                  null;
                  
               elsif
                 BewegungsfeldExtern.Ebene + EbeneSchleifenwert not in KartenDatentypen.EbeneVorhanden'Range
               then
                  null;

               else
                  BewegungsbereichErmitteln (BewegungsfeldExtern             => (BewegungsfeldExtern.Ebene + EbeneSchleifenwert,
                                                                                 BewegungsfeldExtern.Senkrechte + SenkrechteSchleifenwert,
                                                                                 BewegungsfeldExtern.Waagerechte + WaagerechteSchleifenwert),
                                             KoordinatenExtern               => KoordinatenExtern,
                                             EinheitSpeziesNummerExtern      => EinheitSpeziesNummerExtern,
                                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
               end if;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;

   end BewegungsbereichErmitteln;
   
   
      
   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.KartenfeldNaturalRecord;
      use type StadtDatentypen.Städtebereich;
   begin
      
      if
        NeueKoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                          NeueKoordinatenExtern      => NeueKoordinatenExtern)
      then
         return SystemDatentypen.False_Enum;
         
      elsif
        Bewegungsbereich (NeueKoordinatenExtern.Ebene, NeueKoordinatenExtern.Senkrechte, NeueKoordinatenExtern.Waagerechte) = False
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
                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
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
