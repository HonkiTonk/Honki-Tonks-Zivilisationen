with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with SystemDatentypen;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;

with KIDatentypen;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIVerbesserungAnlegbarLogik;
with KIEinheitFestlegenWegeLogik;

package body KIEinheitFestlegenVerbesserungenLogik is

   function StadtumgebungVerbessern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.KartenfeldNaturalRecord;
   begin
      
      ZielVerbesserungKoordinaten := StädteDurchgehen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      case
        ZielVerbesserungKoordinaten = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Verbesserung_Anlegen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => ZielVerbesserungKoordinaten);
            return True;
      end case;
      
   end StadtumgebungVerbessern;
   
   
   
   function StädteDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
            
      VerbesserungAnlegen := DirekteUmgebung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        VerbesserungAnlegen.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            VerbesserungAnlegen := KIEinheitFestlegenWegeLogik.StädteVerbinden (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
         when others =>
            return VerbesserungAnlegen;
      end case;
      
      case
        VerbesserungAnlegen.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            VerbesserungAnlegen := KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return VerbesserungAnlegen;
      end case;
            
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               VerbesserungAnlegen := StadtumgebungErmitteln (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert),
                                                              EinheitNummerExtern      => EinheitSpeziesNummerExtern.Nummer);
         end case;
         
         case
           VerbesserungAnlegen.Waagerechte
         is
            when KartenKonstanten.LeerWaagerechte =>
               null;
               
            when others =>
               return VerbesserungAnlegen;
         end case;
         
      end loop StadtSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StädteDurchgehen;
   
   
   
   function DirekteUmgebung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
               
               VerbesserungKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitKoordinaten,
                                                                                                                      ÄnderungExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 VerbesserungKoordinaten.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                     
               elsif
                 True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern          => VerbesserungKoordinaten,
                                                            EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
               then
                  return VerbesserungKoordinaten;
                  
               else
                  null;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end DirekteUmgebung;
   
   
   
   function StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      Stadtumgebung := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Stadtumgebung.Senkrechte .. Stadtumgebung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Stadtumgebung.Waagerechte .. Stadtumgebung.Waagerechte loop
            
            -- Da die Stadt selbst als Verbesserung zählt, sollte diese Prüfung problemlos weg können, oder? äöü
            -- Um das zu testen die Prüfung mal ausgeklammert, wenn alles weiterhin funktioniert dann kann das ja weg. äöü
            -- if
            --   SenkrechteSchleifenwert = 0
            --   and
            --    WaagerechteSchleifenwert = 0
            -- then
            --   null;
               
            -- else
            VerbesserungKoordinaten
              := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                             ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                             TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              VerbesserungKoordinaten.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                  
            elsif
              True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern          => VerbesserungKoordinaten,
                                                         EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern))
            then
               return VerbesserungKoordinaten;
                  
            else
               null;
            end if;
            -- end if;
                     
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtumgebungErmitteln;
   
   
   
   function AllgemeineVerbesserungenPrüfungen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      if
        LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => VerbesserungKoordinaten) /= EinheitSpeziesNummerExtern.Spezies
      then
         return False;
         
      elsif
        True = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                           SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                           ZielKoordinatenExtern => VerbesserungKoordinaten)
      then
         return False;
            
      elsif
        False = KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                      KoordinatenExtern          => KoordinatenExtern)
      then
         return False;
         
      elsif
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         WelcheVerbesserung := KIVerbesserungAnlegbarLogik.VerbesserungAnlegbar (KoordinatenExtern          => KoordinatenExtern,
                                                                                 EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      else
         WelcheVerbesserung := VerbesserungErsetzen;
      end if;
            
      case
        WelcheVerbesserung
      is
         when True =>
            return WelcheVerbesserung;
            
         when False =>
            return KIEinheitFestlegenWegeLogik.WegAnlegbar (KoordinatenExtern          => KoordinatenExtern,
                                                            EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end AllgemeineVerbesserungenPrüfungen;
   


   function VerbesserungErsetzen
   -- (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     return Boolean
   is begin
   
      return False;
   
   end VerbesserungErsetzen;

end KIEinheitFestlegenVerbesserungenLogik;
