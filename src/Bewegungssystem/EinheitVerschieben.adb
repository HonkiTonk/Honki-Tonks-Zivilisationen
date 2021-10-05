pragma SPARK_Mode (On);

with GlobaleVariablen, KartenKonstanten, EinheitenKonstanten, StadtKonstanten, KartenDatentypen, EinheitStadtDatentypen;
use KartenDatentypen, EinheitStadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseStadtGebaut, LeseKarten;

with EinheitSuchen, KartePositionPruefen, BewegungPassierbarkeitPruefen;

package body EinheitVerschieben is
   
   procedure VonEigenemLandWerfen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
      is
         when SonstigeDatentypen.Nichtangriffspakt | SonstigeDatentypen.Neutral =>
            EinheitNummer := 0;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern   => (LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern).EAchse, YAchseSchleifenwert, XAchseSchleifenwert));
                     
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.BelegterGrund (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                        KoordinatenExtern => KartenWert)
              = False
            then
               null;
                  
            else
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => KontaktierteRasseExtern,
                                                                                KoordinatenExtern => KartenWert);
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
     (RasseLandExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      UmgebungPrüfen := KartenDatentypen.Sichtweite'First;
      BereitsGeprüft := UmgebungPrüfen - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
                     
               KartenWertVerschieben := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                      ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
               if
                 KartenWertVerschieben.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 BereitsGeprüft >= abs (YAchseSchleifenwert)
                 and
                   BereitsGeprüft >= abs (XAchseSchleifenwert)
               then
                  null;
            
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseLandExtern,
                                           KoordinatenExtern => KartenWertVerschieben)
                 = False
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                              NeuePositionExtern       => KartenWertVerschieben)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWertVerschieben).Platznummer = EinheitenKonstanten.LeerNummer
               then
                  SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PositionExtern           => KartenWertVerschieben);
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
