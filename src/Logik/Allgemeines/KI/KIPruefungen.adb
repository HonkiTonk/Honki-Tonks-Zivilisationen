pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with TastenbelegungDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIKonstanten;
with KIDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with Aufgaben;

with KIAufgabenVerteilt;
with KIEinheitAllgemeinePruefungen;

package body KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      VerbesserungAnlegen := KIKonstanten.LeerKoordinate;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               VerbesserungAnlegen := StadtUmgebungUnverbessert (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert),
                                                                 EinheitNummerExtern    => EinheitRasseNummerExtern.Nummer);
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            StadtVerbesserungUmgebungKoordinaten
              := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                        LogikGrafikExtern => True);
            
            if
              StadtVerbesserungUmgebungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
            
      if
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern       => KoordinatenExtern)
        = False
      then
         return False;
         
      elsif
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
        and
          LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         return False;
         
      elsif
        EinheitAufFeld.Nummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld.Nummer /= EinheitRasseNummerExtern.Nummer
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      AufgabenSchleife:
      for AufgabeSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range loop
         
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
                  
      case
        KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                   KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                   MindestBewertungFeldExtern => MindestBewertungFeldExtern)
      is
         when False =>
            return FelderDurchgehen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                     MindestBewertungFeldExtern => MindestBewertungFeldExtern);
            
         when True =>
            return KIKonstanten.LeerKoordinate;
      end case;
      
   end UmgebungStadtBauenPrüfen;
   
   
   
   ----------------------------------- Das gibt immer den Nullwert zurück und müsste dann zum Bau einer Stadt führen. Kann so nicht stimmen.
   function FelderDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseKoordinatePrüfen := 1;
      XAchseKoordinatePrüfen := 1;
      YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
      XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
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
           YAchseKoordinatePrüfen > Karten.Karteneinstellungen.Kartengröße.YAchse / 2
           and
             XAchseKoordinatePrüfen > Karten.Karteneinstellungen.Kartengröße.XAchse / 2
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Karteneinstellungen.Kartengröße.YAchse / 2
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen <= Karten.Karteneinstellungen.Kartengröße.XAchse / 2
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung;
      YUmgebungExtern : in KartenDatentypen.KartenfeldPositiv;
      XUmgebungExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseKartenfeldSuchenSchleife:
      for YAchseSchleifenwert in -YUmgebungExtern .. YUmgebungExtern loop
         XAchseKartenfeldSuchenSchleife:
         for XAchseSchleifenwert in -XUmgebungExtern .. XUmgebungExtern loop
               
            StadtBauenUmgebungKoordinaten
              := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                        LogikGrafikExtern => True);
               
            if
              StadtBauenUmgebungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
              or
                (YAchseKoordinatenSchonGeprüft >= abs YAchseSchleifenwert
                 and
                   XAchseKoordinatenSchonGeprüft >= abs XAchseSchleifenwert)
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
                (KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                        RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                        ZielKoordinatenExtern => StadtBauenUmgebungKoordinaten)
                 = False
                 and
                   KIEinheitAllgemeinePruefungen.BlockiertDurchWasser (KoordinatenExtern => StadtBauenUmgebungKoordinaten) = False)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitAufFeld.Nummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld /= EinheitRasseNummerExtern
      then
         return False;
      
      elsif
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern       => KoordinatenExtern)
        = False
      then
         return False;
         
      elsif
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern) = False
      then
         return False;
      
      elsif
        LeseKarten.Bewertung (KoordinatenExtern => KoordinatenExtern,
                              RasseExtern       => EinheitRasseNummerExtern.Rasse)
        < MindestBewertungFeldExtern
      then
         return False;
         
      elsif
        LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         return False;
         
      else
         return FeldBelegt (KoordinatenExtern => KoordinatenExtern);
      end if;
      
   end KartenfeldUmgebungPrüfen;
   
   
   
   function FeldBelegt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      YAchseUmgebungSchleife:
      for YAchseUmgebungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseUmgebungSchleife:
         for XAchseUmgebungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
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
