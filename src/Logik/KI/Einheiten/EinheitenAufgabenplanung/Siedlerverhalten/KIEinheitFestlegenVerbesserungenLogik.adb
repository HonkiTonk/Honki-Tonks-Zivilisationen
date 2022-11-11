with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with BefehleDatentypen;
with AufgabenDatentypen;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;

with Vergleiche;
with KartenkoordinatenberechnungssystemLogik;
with AufgabenLogik;

with KIDatentypen;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;

package body KIEinheitFestlegenVerbesserungenLogik is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      ZielVerbesserungKoordinaten := StädteDurchgehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => ZielVerbesserungKoordinaten)
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Verbesserung_Anlegen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => ZielVerbesserungKoordinaten);
            return True;
      end case;
      
   end StadtumgebungVerbessern;
   
   
   
   function StädteDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
            
      VerbesserungAnlegen := DirekteUmgebung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        VerbesserungAnlegen.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            VerbesserungAnlegen := KartenRecordKonstanten.LeerKoordinate;
               
         when others =>
            return VerbesserungAnlegen;
      end case;
            
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               VerbesserungAnlegen := StadtumgebungErmitteln (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert),
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
      
   end StädteDurchgehen;
   
   
   
   function DirekteUmgebung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               VerbesserungKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitKoordinaten,
                                                                                                                      ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                      LogikGrafikExtern => True);
               
               case
                 VerbesserungKoordinaten.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
                     
                  when others =>
                     if
                       True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern        => VerbesserungKoordinaten,
                                                                  EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                     then
                        return VerbesserungKoordinaten;
                  
                     else
                        null;
                     end if;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end DirekteUmgebung;
   
   
   
   function StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
            
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
            
               case
                 VerbesserungKoordinaten.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
                  
                  when others =>
                     if
                       True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern        => VerbesserungKoordinaten,
                                                                  EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
                     then
                        return VerbesserungKoordinaten;
                  
                     else
                        null;
                     end if;
               end case;
            end if;
                     
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtumgebungErmitteln;
   
   
   
   function AllgemeineVerbesserungenPrüfungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      if
        LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => VerbesserungKoordinaten) /= EinheitRasseNummerExtern.Rasse
      then
         return False;
               
      elsif
        True = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                           RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                           ZielKoordinatenExtern => VerbesserungKoordinaten)
      then
         return False;
            
      elsif
        False = KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      KoordinatenExtern        => KoordinatenExtern)
      then
         return False;
         
      elsif
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         WelcheVerbesserung := VerbesserungAnlegbar (KoordinatenExtern        => KoordinatenExtern,
                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         WelcheVerbesserung := VerbesserungErsetzen;
      end if;
            
      case
        WelcheVerbesserung
      is
         when True =>
            return WelcheVerbesserung;
            
         when False =>
            return WegAnlegbar (KoordinatenExtern        => KoordinatenExtern,
                                EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end AllgemeineVerbesserungenPrüfungen;
   
   
   
   function VerbesserungAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Ressourcen := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        Ressourcen
      is
         when KartengrundDatentypen.Hochwertiges_Holz_Enum =>
            return False;
            
         when others =>
            Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      case
        AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => BefehleDatentypen.Mine_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            if
              Basisgrund = KartengrundDatentypen.Hügel_Enum
              or
                Basisgrund = KartengrundDatentypen.Gebirge_Enum
                or
                  Ressourcen = KartengrundDatentypen.Kohle_Enum
                  or
                    Ressourcen = KartengrundDatentypen.Eisen_Enum
                    or
                      Ressourcen = KartengrundDatentypen.Gold_Enum
            then
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern      => AufgabenDatentypen.Mine_Bauen_Enum);
               return True;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      case
        AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => BefehleDatentypen.Festung_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            if
              Basisgrund = KartengrundDatentypen.Eis_Enum
            then
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern      => AufgabenDatentypen.Festung_Bauen_Enum);
               return True;
               
            else
               null;
            end if;
               
         when False =>
            null;
      end case;
         
      case
        AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => BefehleDatentypen.Farm_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => AufgabenDatentypen.Farm_Bauen_Enum);
            return True;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end VerbesserungAnlegbar;



   function VerbesserungErsetzen
     return Boolean
   is begin
   
      return False;
   
   end VerbesserungErsetzen;
   
   
   
   function WegAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => BefehleDatentypen.Straße_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => AufgabenDatentypen.Straße_Bauen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end WegAnlegbar;

end KIEinheitFestlegenVerbesserungenLogik;
