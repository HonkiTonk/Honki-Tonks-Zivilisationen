pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with DiplomatieDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseKarten;

with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with Kartenkoordinatenberechnungssystem;

package body EinheitVerschieben is
   
   procedure VonEigenemLandWerfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
      is
         when DiplomatieDatentypen.Nichtangriffspakt_Enum | DiplomatieDatentypen.Neutral_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               EinheitenErmitteln (StadtRasseNummerExtern  => (RasseExtern, StadtSchleifenwert),
                                   KontaktierteRasseExtern => KontaktierteRasseExtern);
         end case;
         
      end loop StadtSchleife;
      
   end VonEigenemLandWerfen;
   
   
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      EinheitNummer := EinheitenKonstanten.LeerNummer;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                 ÄnderungExtern    => (Stadtkoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
                     
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseKarten.BelegterGrund (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                KoordinatenExtern => Kartenwert)
            then
               null;
                                                                                                 
            else
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => KontaktierteRasseExtern,
                                                                                KoordinatenExtern => Kartenwert);
            end if;
               
            case
              EinheitNummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  null;
                     
               when others =>
                  EinheitVerschieben (RasseLandExtern          => StadtRasseNummerExtern.Rasse,
                                      EinheitRasseNummerExtern => (KontaktierteRasseExtern, EinheitNummer));
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end EinheitenErmitteln;
   
   

   procedure EinheitVerschieben
     (RasseLandExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      UmgebungPrüfen := KartenDatentypen.Sichtweite'First;
      BereitsGeprüft := UmgebungPrüfen - 1;
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
                     
               KartenwertVerschieben := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                               ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                               LogikGrafikExtern => True);
            
               if
                 KartenwertVerschieben.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 BereitsGeprüft >= abs (YAchseSchleifenwert)
                 and
                   BereitsGeprüft >= abs (XAchseSchleifenwert)
               then
                  null;
            
               elsif
                 False = LeseKarten.BelegterGrund (RasseExtern       => RasseLandExtern,
                                                   KoordinatenExtern => KartenwertVerschieben)
                 and
                   True = BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                     NeueKoordinatenExtern    => KartenwertVerschieben)
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenwertVerschieben).Nummer = EinheitenKonstanten.LeerNummer
               then
                  SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenwertVerschieben);
                  return;
                  
               else
                  null;
               end if;
         
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         case
           UmgebungPrüfen
         is
            when KartenDatentypen.Sichtweite'Last =>
               return;
               
            when others =>
               BereitsGeprüft := UmgebungPrüfen;
               UmgebungPrüfen := UmgebungPrüfen + 1;
         end case;
         
      end loop BereichSchleife;
      
   end EinheitVerschieben;

end EinheitVerschieben;
