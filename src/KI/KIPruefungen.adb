pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;

with KartePositionPruefen, EinheitSuchen, BewegungPassierbarkeitPruefen, KIAufgabenVerteilt, Verbesserungen, LeseKarten, LeseEinheitenGebaut, LeseStadtGebaut;

package body KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      VerbesserungAnlegen := KIKonstanten.NullKoordinate;      
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               VerbesserungAnlegen := StadtUmgebungUnverbessert (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert),
                                                                 EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
         end case;
         
         case
           VerbesserungAnlegen.XAchse
         is
            when GlobaleKonstanten.LeerYXKartenWert =>
               null;
               
            when others =>
               return VerbesserungAnlegen;
         end case;
         
      end loop StadtSchleife;
      
      return VerbesserungAnlegen;
      
   end StadtUmgebungPrüfen;
   
   
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            StadtVerbesserungUmgebungKoordinaten
              := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                               ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              StadtVerbesserungUmgebungKoordinaten.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen,
                                                     RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                     ZielKoordinatenExtern => StadtVerbesserungUmgebungKoordinaten) = True
            then
               null;
                  
            else
               case
                 VerbesserungDortAnlegen (KoordinatenExtern        => StadtVerbesserungUmgebungKoordinaten,
                                          EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
               is
                  when True =>
                     return StadtVerbesserungUmgebungKoordinaten;
                     
                  when False =>
                     null;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.NullKoordinate;
      
   end StadtUmgebungUnverbessert;
   
   
   
   function VerbesserungDortAnlegen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
            
      if
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer),
                                                                   NeuePositionExtern       => KoordinatenExtern) = False
      then
         return False;
         
      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
        and
          LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
      then
         return False;
         
      elsif
        EinheitAufFeld.Platznummer /= GlobaleKonstanten.LeerEinheitStadtNummer
        and
          EinheitAufFeld.Platznummer /= EinheitRasseNummerExtern.Platznummer
      then
         return False;
         
      elsif
        LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                  KoordinatenExtern => KoordinatenExtern) = True
      then
         null;
         
      else
         return False;
      end if;
        
      AufgabenSchleife:
      for AufgabeSchleifenwert in GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range loop
         
         VerbesserungAnlegbar := Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer),
                                                                    BefehlExtern             => AufgabeSchleifenwert);
         
         case
           VerbesserungAnlegbar
         is
            when True =>
               exit AufgabenSchleife;
               
            when False =>
               null;
         end case;
         
      end loop AufgabenSchleife;
      
      return VerbesserungAnlegbar;
      
   end VerbesserungDortAnlegen;
   
   
   
   function UmgebungStadtBauenPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                   KoordinatenExtern          => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                   MindestBewertungFeldExtern => MindestBewertungFeldExtern);
      
      case
        FeldGutUndFrei
      is
         when False =>
            null;
            
         when True =>
            return KIKonstanten.NullKoordinate;
      end case;
      
      YAchseKoordinatePrüfen := 1;
      XAchseKoordinatePrüfen := 1;
      YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
      XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
      
      KartenfeldSuchenSchleife:
      loop
         YAchseKartenfeldSuchenSchleife:
         for YAchseSchleifenwert in -YAchseKoordinatePrüfen .. YAchseKoordinatePrüfen loop
            XAchseKartenfeldSuchenSchleife:
            for XAchseSchleifenwert in -XAchseKoordinatePrüfen .. XAchseKoordinatePrüfen loop
               
               StadtBauenUmgebungKoordinaten := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                              ÄnderungExtern       => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
                                         
               if
                 (YAchseKoordinatenSchonGeprüft >= abs YAchseSchleifenwert
                  and
                    XAchseKoordinatenSchonGeprüft >= abs XAchseSchleifenwert)
                 or
                   StadtBauenUmgebungKoordinaten.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  FeldGutUndFrei := False;
               
               else
                  FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                               KoordinatenExtern          => StadtBauenUmgebungKoordinaten,
                                                               MindestBewertungFeldExtern => MindestBewertungFeldExtern);
               end if;
               
               case
                 FeldGutUndFrei
               is
                  when False =>
                     null;
                     
                  when True =>
                     if
                       KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen,
                                                              RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                              ZielKoordinatenExtern => StadtBauenUmgebungKoordinaten)
                       = False
                     then
                        return StadtBauenUmgebungKoordinaten;
                  
                     else
                        null;
                     end if;
               end case;
            
            end loop XAchseKartenfeldSuchenSchleife;
         end loop YAchseKartenfeldSuchenSchleife;
         
         if
           YAchseKoordinatePrüfen >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             XAchseKoordinatePrüfen > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseKoordinatePrüfen := XAchseKoordinatePrüfen + 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return GlobaleKonstanten.LeerKartenPosition;
      
   end UmgebungStadtBauenPrüfen;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitAufFeld.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
        or
          EinheitAufFeld = EinheitRasseNummerExtern
      then
         null;
            
      else
         return False;
      end if;
      
      case
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      if
        LeseKarten.Bewertung (PositionExtern => KoordinatenExtern,
                              RasseExtern    => EinheitRasseNummerExtern.Rasse) >= MindestBewertungFeldExtern
      then
         null;
         
      else
         return False;
      end if;
      
      case
        LeseKarten.Grund (PositionExtern => KoordinatenExtern)
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Wasser | GlobaleDatentypen.Küstengewässer =>
            return False;
         
         when others =>
            null;
      end case;
      
      YAchseUmgebungSchleife:
      for YAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseUmgebungSchleife:
         for XAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YAchseUmgebungSchleifenwert, XAchseUmgebungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.BelegterGrundLeer (KoordinatenExtern => KartenWert) = False
            then
               return False;
               
            else
               null;
            end if;
            
         end loop XAchseUmgebungSchleife;
      end loop YAchseUmgebungSchleife;
      
      return True;
      
   end KartenfeldUmgebungPrüfen;

end KIPruefungen;
