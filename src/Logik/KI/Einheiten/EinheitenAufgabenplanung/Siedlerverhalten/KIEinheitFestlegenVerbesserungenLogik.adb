with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

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
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
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
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
            
      VerbesserungAnlegen := DirekteUmgebung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        VerbesserungAnlegen.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            VerbesserungAnlegen := KIEinheitFestlegenWegeLogik.StädteVerbinden (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
         when others =>
            return VerbesserungAnlegen;
      end case;
      
      case
        VerbesserungAnlegen.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            VerbesserungAnlegen := KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return VerbesserungAnlegen;
      end case;
            
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               VerbesserungAnlegen := StadtumgebungErmitteln (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert),
                                                              EinheitNummerExtern      => EinheitSpeziesNummerExtern.Nummer);
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
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StädteDurchgehen;
   
   
   
   function DirekteUmgebung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               VerbesserungKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitKoordinaten,
                                                                                                                      ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                      LogikGrafikExtern => True);
               
               if
                 VerbesserungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
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
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end DirekteUmgebung;
   
   
   
   function StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
            
            -- Da die Stadt selbst als Verebsserung zählt, sollte diese Prüfung problemlos weg können, oder? äöü
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            else
               VerbesserungKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                      LogikGrafikExtern => True);
            
               if
                 VerbesserungKoordinaten.XAchse = KartenKonstanten.LeerXAchse
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
            end if;
                     
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtumgebungErmitteln;
   
   
   
   function AllgemeineVerbesserungenPrüfungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
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
   -- (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     return Boolean
   is begin
   
      return False;
   
   end VerbesserungErsetzen;

end KIEinheitFestlegenVerbesserungenLogik;
