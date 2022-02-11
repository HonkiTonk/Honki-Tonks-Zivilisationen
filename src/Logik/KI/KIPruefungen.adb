pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIKonstanten;
with KIDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartePositionPruefen;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with Aufgaben;

with KIAufgabenVerteilt;

package body KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      VerbesserungAnlegen := KIKonstanten.LeerKoordinate;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenDatentypen.Leer_Verbesserung =>
               null;
               
            when others =>
               VerbesserungAnlegen := StadtUmgebungUnverbessert (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert),
                                                                 EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
         end case;
         
         case
           VerbesserungAnlegen.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               null;
               
            when others =>
               return VerbesserungAnlegen;
         end case;
         
      end loop StadtSchleife;
      
      return VerbesserungAnlegen;
      
   end StadtUmgebungPrüfen;
   
   
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            StadtVerbesserungUmgebungKoordinaten
              := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                               ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                               LogikGrafikExtern => True);
            
            if
              StadtVerbesserungUmgebungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen,
                                                     RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                     ZielKoordinatenExtern => StadtVerbesserungUmgebungKoordinaten)
              = True
            then
               null;
                  
            elsif
              VerbesserungDortAnlegen (KoordinatenExtern        => StadtVerbesserungUmgebungKoordinaten,
                                       EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
                = True
            then
               return StadtVerbesserungUmgebungKoordinaten;
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.LeerKoordinate;
      
   end StadtUmgebungUnverbessert;
   
   

   function VerbesserungDortAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
            
      if
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeuePositionExtern       => KoordinatenExtern)
        = False
      then
         return False;
         
      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer_Verbesserung
        and
          LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer_Verbesserung
      then
         return False;
         
      elsif
        EinheitAufFeld.Platznummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld.Platznummer /= EinheitRasseNummerExtern.Platznummer
      then
         return False;
         
      elsif
        LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                  KoordinatenExtern => KoordinatenExtern)
        = True
      then
         null;
         
      else
         return False;
      end if;
        
      return VerbesserungAnlegbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end VerbesserungDortAnlegen;
   
   
   
   function VerbesserungAnlegbar
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      AufgabenSchleife:
      for AufgabeSchleifenwert in SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range loop
         
         VerbesserungTesten := Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            BefehlExtern             => AufgabeSchleifenwert);
         
         case
           VerbesserungTesten
         is
            when True =>
               exit AufgabenSchleife;
               
            when False =>
               null;
         end case;
         
      end loop AufgabenSchleife;
      
      return VerbesserungTesten;
      
   end VerbesserungAnlegbar;
   
   
   
   function UmgebungStadtBauenPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamtbewertungFeld)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
            
      case
        KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                   KoordinatenExtern          => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                   MindestBewertungFeldExtern => MindestBewertungFeldExtern)
      is
         when False =>
            YAchseKoordinatePrüfen := 1;
            XAchseKoordinatePrüfen := 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
            return FelderDurchgehen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                     MindestBewertungFeldExtern => MindestBewertungFeldExtern);
            
         when True =>
            return KIKonstanten.LeerKoordinate;
      end case;
      
   end UmgebungStadtBauenPrüfen;
   
   
   
   function FelderDurchgehen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamtbewertungFeld)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      KartenfeldSuchenSchleife:
      loop
         
         KartenWertZwei := NeuesStadtFeldSuchen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                 MindestBewertungFeldExtern => MindestBewertungFeldExtern,
                                                 YUmgebungExtern            => YAchseKoordinatePrüfen,
                                                 XUmgebungExtern            => XAchseKoordinatePrüfen);
         
         case
           KartenWertZwei.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               null;
               
            when others =>
               return KartenWertZwei;
         end case;
         
         if
           YAchseKoordinatePrüfen > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2
           and
             XAchseKoordinatePrüfen > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2
         then
            XAchseKoordinatePrüfen := XAchseKoordinatePrüfen + 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return KIKonstanten.LeerKoordinate;
      
   end FelderDurchgehen;
     
   
   
   
   function NeuesStadtFeldSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamtbewertungFeld;
      YUmgebungExtern : in KartenDatentypen.KartenfeldPositiv;
      XUmgebungExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseKartenfeldSuchenSchleife:
      for YAchseSchleifenwert in -YUmgebungExtern .. YUmgebungExtern loop
         XAchseKartenfeldSuchenSchleife:
         for XAchseSchleifenwert in -XUmgebungExtern .. XUmgebungExtern loop
               
            StadtBauenUmgebungKoordinaten := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                           LogikGrafikExtern => True);
               
            if
              (YAchseKoordinatenSchonGeprüft >= abs YAchseSchleifenwert
               and
                 XAchseKoordinatenSchonGeprüft >= abs XAchseSchleifenwert)
              or
                StadtBauenUmgebungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
            then
               FeldGutUndFrei := False;
               
            else
               FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                            KoordinatenExtern          => StadtBauenUmgebungKoordinaten,
                                                            MindestBewertungFeldExtern => MindestBewertungFeldExtern);
            end if;
            
            if
              FeldGutUndFrei
              and
                (KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen,
                                                        RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                        ZielKoordinatenExtern => StadtBauenUmgebungKoordinaten)
                 = False)
            then
               return StadtBauenUmgebungKoordinaten;
                  
            else
               null;
            end if;
            
         end loop XAchseKartenfeldSuchenSchleife;
      end loop YAchseKartenfeldSuchenSchleife;
      
      return KIKonstanten.LeerKoordinate;
      
   end NeuesStadtFeldSuchen;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamtbewertungFeld)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitAufFeld.Platznummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld /= EinheitRasseNummerExtern
      then
         return False;
      
      elsif
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeuePositionExtern       => KoordinatenExtern)
        = False
      then
         return False;
         
      elsif
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern) = False
      then
         return False;
      
      elsif
        LeseKarten.Bewertung (PositionExtern => KoordinatenExtern,
                              RasseExtern    => EinheitRasseNummerExtern.Rasse)
        < MindestBewertungFeldExtern
      then
         return False;
         
      elsif
        LeseKarten.Grund (PositionExtern => KoordinatenExtern) = KartenDatentypen.Eis
      then
         return False;
         
      else
         return FeldBelegt (KoordinatenExtern => KoordinatenExtern);
      end if;
      
   end KartenfeldUmgebungPrüfen;
   
   
   
   function FeldBelegt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      YAchseUmgebungSchleife:
      for YAchseUmgebungSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseUmgebungSchleife:
         for XAchseUmgebungSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YAchseUmgebungSchleifenwert, XAchseUmgebungSchleifenwert),
                                                                        LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
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
      
   end FeldBelegt;

end KIPruefungen;
