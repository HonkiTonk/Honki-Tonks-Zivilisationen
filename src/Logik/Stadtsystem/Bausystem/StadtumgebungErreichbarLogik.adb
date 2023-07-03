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
     (StadtKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin  
      
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YAchseSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XAchseSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                 
               elsif
                 BereitsGetestet > abs (YAchseSchleifenwert)
                 and
                   BereitsGetestet > abs (XAchseSchleifenwert)
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
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         if
           Umgebung = Stadtumgebung
         then
            return KartenRecordKonstanten.LeerKoordinate;
         
         else
            Umgebung := Umgebung + 1;
            BereitsGetestet := Umgebung - 1;
         end if;
                     
      end loop BereichSchleife;
      
   end UmgebungErreichbar;
   
   
   
   function Prüfungen
     (StadtKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
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
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               KartenWertZwei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinatenExtern,
                                                                                                             ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                             TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 YAchseSchleifenwert = 0
                 and
                   XAchseSchleifenwert = 0
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
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         return False;
         
      else
         return True;
      end if;
            
   end Prüfungen;
     
end StadtumgebungErreichbarLogik;
