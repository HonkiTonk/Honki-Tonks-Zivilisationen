with KartenKonstanten;
with DiplomatieDatentypen;
with SystemDatentypen;
with KartenDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;
with LeseDiplomatie;
with LeseWeltkarteneinstellungen;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;

package body EinheitenverschiebungLogik is
   
   procedure VonEigenemLandWerfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
               exit StadtSchleife;
               
            when others =>
               EinheitenErmitteln (StadtSpeziesNummerExtern  => (SpeziesExtern, StadtSchleifenwert),
                                   KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
         end case;
         
      end loop StadtSchleife;
      
   end VonEigenemLandWerfen;
   
   
   
   procedure EinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      EinheitNummer := EinheitenKonstanten.LeerNummer;
      Umgebungsgröße := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Umgebungsgröße.Senkrechte .. Umgebungsgröße.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Umgebungsgröße.Waagerechte .. Umgebungsgröße.Waagerechte loop
               
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (Stadtkoordinaten.Ebene, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                     
            if
              Kartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              False = LeseWeltkarte.BelegterGrund (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                   KoordinatenExtern => Kartenwert)
            then
               null;
                                                                                                 
            else
               EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => KontaktierteSpeziesExtern,
                                                                                       KoordinatenExtern => Kartenwert,
                                                                                       TaskExtern        => SystemDatentypen.Logik_Task_Enum);
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
         
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end EinheitenErmitteln;
   
   

   procedure EinheitVerschieben
     (SpeziesLandExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      BereitsGeprüft := (0, 0);
      UmgebungPrüfen := (1, 1);
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      BereichSchleife:
      loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in -UmgebungPrüfen.Senkrechte .. UmgebungPrüfen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in -UmgebungPrüfen.Waagerechte .. UmgebungPrüfen.Waagerechte loop
                     
               KartenwertVerschieben
                 := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
               if
                 KartenwertVerschieben.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
               
               elsif
                 BereitsGeprüft.Senkrechte >= abs (SenkrechteSchleifenwert)
                 and
                   BereitsGeprüft.Waagerechte >= abs (WaagerechteSchleifenwert)
               then
                  null;
            
               elsif
                 False = LeseWeltkarte.BelegterGrund (SpeziesExtern     => SpeziesLandExtern,
                                                      KoordinatenExtern => KartenwertVerschieben)
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                    NeueKoordinatenExtern      => KartenwertVerschieben)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KartenwertVerschieben,
                                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum).Nummer
               then
                  SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenwertVerschieben,
                                                       EinheitentauschExtern      => False);
                  return;
                  
               else
                  null;
               end if;
         
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         if
           UmgebungPrüfen.Senkrechte = LeseWeltkarteneinstellungen.Senkrechte
           and
             UmgebungPrüfen.Waagerechte = LeseWeltkarteneinstellungen.Waagerechte
         then
            return;
            
         else
            null;
         end if;
         
         if
           UmgebungPrüfen.Senkrechte < LeseWeltkarteneinstellungen.Senkrechte
         then
            UmgebungPrüfen.Senkrechte := UmgebungPrüfen.Senkrechte + 1;
            BereitsGeprüft.Senkrechte := BereitsGeprüft.Senkrechte + 1;
            
         else
            null;
         end if;
         
         if
           UmgebungPrüfen.Waagerechte < LeseWeltkarteneinstellungen.Waagerechte
         then
            UmgebungPrüfen.Waagerechte := UmgebungPrüfen.Waagerechte + 1;
            BereitsGeprüft.Waagerechte := BereitsGeprüft.Waagerechte + 1;
            
         else
            null;
         end if;
         
      end loop BereichSchleife;
      
   end EinheitVerschieben;

end EinheitenverschiebungLogik;
