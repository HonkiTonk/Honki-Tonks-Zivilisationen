with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with BefehleDatentypen;
with AufgabenDatentypen;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with AufgabenLogik;

with KIDatentypen;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;

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
      
      return VerbesserungAnlegen;
      
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
               
               -- Den Schleifenbereich verschieben, ist ja in beiden Schleifen gleich. äöü
               -- Dann per Münzwurf auf die jeweilige Schleife verweisen? äöü
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
                       True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern          => VerbesserungKoordinaten,
                                                                  EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
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
                       True = AllgemeineVerbesserungenPrüfungen (KoordinatenExtern          => VerbesserungKoordinaten,
                                                                  EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern))
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
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
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
         WelcheVerbesserung := VerbesserungAnlegbar (KoordinatenExtern          => KoordinatenExtern,
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
            return WegAnlegbar (KoordinatenExtern          => KoordinatenExtern,
                                EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end AllgemeineVerbesserungenPrüfungen;
   
   
   
   function VerbesserungAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
   begin
      
      Ressourcen := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        Ressourcen
      is
         when KartenextraDatentypen.Hochwertiges_Holz_Enum =>
            return False;
            
         when others =>
            Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Mine_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            if
              Basisgrund = KartengrundDatentypen.Hügel_Enum
              or
                Basisgrund = KartengrundDatentypen.Gebirge_Enum
                or
                  Ressourcen = KartenextraDatentypen.Kohle_Enum
                  or
                    Ressourcen = KartenextraDatentypen.Eisen_Enum
                    or
                      Ressourcen = KartenextraDatentypen.Gold_Enum
            then
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       BeschäftigungExtern        => AufgabenDatentypen.Mine_Bauen_Enum);
               return True;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Festung_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            if
              Basisgrund = KartengrundDatentypen.Eis_Enum
            then
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       BeschäftigungExtern        => AufgabenDatentypen.Festung_Bauen_Enum);
               return True;
               
            else
               null;
            end if;
               
         when False =>
            null;
      end case;
         
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Farm_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Farm_Bauen_Enum);
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
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Straße_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern      => AufgabenDatentypen.Straße_Bauen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end WegAnlegbar;

end KIEinheitFestlegenVerbesserungenLogik;
