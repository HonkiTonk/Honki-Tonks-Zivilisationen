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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                         SpeziesZweiExtern => KontaktierteSpeziesExtern)
      is
         when DiplomatieDatentypen.Nichtangriffspakt_Enum | DiplomatieDatentypen.Neutral_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               EinheitenErmitteln (StadtSpeziesNummerExtern  => (SpeziesExtern, StadtSchleifenwert),
                                   KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
         end case;
         
      end loop StadtSchleife;
      
   end VonEigenemLandWerfen;
   
   
   
   procedure EinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      EinheitNummer := EinheitenKonstanten.LeerNummer;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) loop
               
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (Stadtkoordinaten.EAchse, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
                     
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.BelegterGrund (SpeziesExtern       => StadtSpeziesNummerExtern.Spezies,
                                                KoordinatenExtern => Kartenwert)
            then
               null;
                                                                                                 
            else
               EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern       => KontaktierteSpeziesExtern,
                                                                                     KoordinatenExtern => Kartenwert,
                                                                                     LogikGrafikExtern => True);
            end if;
               
            case
              EinheitNummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  null;
                     
               when others =>
                  EinheitVerschieben (SpeziesLandExtern          => StadtSpeziesNummerExtern.Spezies,
                                      EinheitSpeziesNummerExtern => (KontaktierteSpeziesExtern, EinheitNummer));
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end EinheitenErmitteln;
   
   

   procedure EinheitVerschieben
     (SpeziesLandExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      UmgebungPrüfen := KartenDatentypen.Sichtweite'First;
      BereitsGeprüft := UmgebungPrüfen - 1;
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                 False = LeseWeltkarte.BelegterGrund (SpeziesExtern       => SpeziesLandExtern,
                                                   KoordinatenExtern => KartenwertVerschieben)
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                    NeueKoordinatenExtern    => KartenwertVerschieben)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KartenwertVerschieben,
                                                                                                          LogikGrafikExtern => True).Nummer
               then
                  SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
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
