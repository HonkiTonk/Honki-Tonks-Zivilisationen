with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitSuchenLogik;

package body StadtumgebungErreichbarLogik is
   
   function UmgebungErreichbar
     (StadtKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KartenRecords.KartenfeldNaturalRecord
   is begin  
      
      Umgebung := (1, 1);
      BereitsGetestet := (Umgebung.Senkrechte - 1, Umgebung.Waagerechte - 1);
      Stadtumgebung := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      BereichSchleife:
      loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in -Umgebung.Senkrechte .. Umgebung.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in -Umgebung.Waagerechte .. Umgebung.Waagerechte loop
               
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                 
               elsif
                 BereitsGetestet.Senkrechte > abs (SenkrechteSchleifenwert)
                 and
                   BereitsGetestet.Waagerechte > abs (WaagerechteSchleifenwert)
               then
                  null;
                  
               elsif
                 True = Prüfungen (StadtKoordinatenExtern    => StadtKoordinatenExtern,
                                    StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                    IDExtern                  => IDExtern,
                                    AktuelleKoordinatenExtern => KartenWert)
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
            
         if
           Umgebung.Senkrechte = Stadtumgebung.Senkrechte
           and
             Umgebung.Waagerechte = Stadtumgebung.Waagerechte
         then
            return KartenRecordKonstanten.LeerKoordinate;
         
         else
            BereitsGetestet.Senkrechte := Umgebung.Senkrechte;
            BereitsGetestet.Waagerechte := Umgebung.Waagerechte;
            Umgebung := (Umgebung.Senkrechte + 1, Umgebung.Waagerechte + 1);
         end if;
                     
      end loop BereichSchleife;
      
   end UmgebungErreichbar;
   
   
   
   function Prüfungen
     (StadtKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      AktuelleKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type KartenRecords.KartenfeldNaturalRecord;
   begin  
      
      if
        False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                         KoordinatenExtern        => AktuelleKoordinatenExtern)
        or
          EinheitenKonstanten.LeerNummer /= EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                    TaskExtern        => SystemDatentypen.Logik_Task_Enum).Nummer
        or
          False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (SpeziesExtern              => StadtSpeziesNummerExtern.Spezies,
                                                                        IDExtern                   => IDExtern,
                                                                        NeueKoordinatenExtern      => AktuelleKoordinatenExtern,
                                                                        StadtBerücksichtigenExtern => True)
      then
         return False;
         
      elsif
        StadtKoordinatenExtern = AktuelleKoordinatenExtern
      then
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
               
               KartenWertZwei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinatenExtern,
                                                                                                             ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                             TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                  
               elsif
                 SenkrechteSchleifenwert = 0
                 and
                   WaagerechteSchleifenwert = 0
               then
                  null;
                  
               elsif
                 False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (SpeziesExtern              => StadtSpeziesNummerExtern.Spezies,
                                                                               IDExtern                   => IDExtern,
                                                                               NeueKoordinatenExtern      => KartenWertZwei,
                                                                               StadtBerücksichtigenExtern => True)
               then
                  null;
                  
               else
                  return True;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         return False;
         
      else
         return True;
      end if;
            
   end Prüfungen;
     
end StadtumgebungErreichbarLogik;
