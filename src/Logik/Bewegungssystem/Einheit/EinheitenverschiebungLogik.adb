with KartenKonstanten;
with DiplomatieDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;
with LeseDiplomatie;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;

package body EinheitenverschiebungLogik is
   
   procedure VonEigenemLandWerfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                         RasseZweiExtern => KontaktierteRasseExtern)
      is
         when DiplomatieDatentypen.Nichtangriffspakt_Enum | DiplomatieDatentypen.Neutral_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
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
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      EinheitNummer := EinheitenKonstanten.LeerNummer;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (Stadtkoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
                     
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.BelegterGrund (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                KoordinatenExtern => Kartenwert)
            then
               null;
                                                                                                 
            else
               EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => KontaktierteRasseExtern,
                                                                                     KoordinatenExtern => Kartenwert,
                                                                                     LogikGrafikExtern => True);
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
   is
      use type KartenDatentypen.Kartenfeld;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      UmgebungPrüfen := KartenDatentypen.Sichtweite'First;
      BereitsGeprüft := UmgebungPrüfen - 1;
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BereichSchleife:
      while UmgebungPrüfen < KartenDatentypen.Sichtweite'Last loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
                     
               KartenwertVerschieben := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                                    ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
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
                 False = LeseWeltkarte.BelegterGrund (RasseExtern       => RasseLandExtern,
                                                   KoordinatenExtern => KartenwertVerschieben)
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                    NeueKoordinatenExtern    => KartenwertVerschieben)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenwertVerschieben,
                                                                                                          LogikGrafikExtern => True).Nummer
               then
                  SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenwertVerschieben,
                                                       EinheitentauschExtern    => False);
                  return;
                  
               else
                  null;
               end if;
         
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         BereitsGeprüft := UmgebungPrüfen;
         UmgebungPrüfen := UmgebungPrüfen + 1;
         
      end loop BereichSchleife;
      
   end EinheitVerschieben;

end EinheitenverschiebungLogik;
