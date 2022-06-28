pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with TastenbelegungDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with KIDatentypen; use KIDatentypen;

with LeseKarten;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with Aufgaben;

with KIAufgabenVerteilt;

package body KIEinheitAufgabeplanungAllgemeines is

   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      VerbesserungAnlegen := KartenRecordKonstanten.LeerKoordinate;
      
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
      
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
            
            VerbesserungKoordinaten := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                              ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                              LogikGrafikExtern => True);
            
            if
              VerbesserungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                     RasseExtern           => StadtRasseNummerExtern.Rasse,
                                                     ZielKoordinatenExtern => VerbesserungKoordinaten)
              = True
            then
               null;
                  
            elsif
              VerbesserungDortAnlegen (KoordinatenExtern        => VerbesserungKoordinaten,
                                       EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
                = True
            then
               return VerbesserungKoordinaten;
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtUmgebungUnverbessert;
   
   
   
   function VerbesserungDortAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
            
      if
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern    => KoordinatenExtern)
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
        = False
      then
         return False;
         
      else
         return VerbesserungAnlegbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
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

end KIEinheitAufgabeplanungAllgemeines;
