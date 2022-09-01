pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with TastenbelegungDatentypen;
with AufgabenDatentypen;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseKarten;

with Vergleiche;
with Kartenkoordinatenberechnungssystem;
with Aufgaben;

with KIDatentypen;

with KIAufgabenVerteilt;
with KIEinheitAllgemeinePruefungen;

package body KIEinheitFestlegenVerbesserungen is

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
      
      VerbesserungAnlegen := KartenRecordKonstanten.LeerKoordinate;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
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
   
   
   
   function StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
            
            -- Das Stadtfeld aus der Prüfung nehmen? Stadt zählt ja selbst als Verbesserung und es könnte deswegen zu Problemen führen? äöü
            if
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
               
            else
               VerbesserungKoordinaten := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
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
        LeseKarten.RasseBelegtGrund (KoordinatenExtern => VerbesserungKoordinaten) /= EinheitRasseNummerExtern.Rasse
      then
         return False;
               
      elsif
        -- Auch auf Einheiten ohne die gleiche Aufgabe aber mit gleichem Ziel prüfen? äöü
        True = KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                      RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                      ZielKoordinatenExtern => VerbesserungKoordinaten)
      then
         return False;
            
      elsif
        False = KIEinheitAllgemeinePruefungen.KartenfeldPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 KoordinatenExtern        => KoordinatenExtern)
      then
         return False;
         
      elsif
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern) = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
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
      
      Ressourcen := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        Aufgaben.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Mine_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            if
              BasisGrund = KartengrundDatentypen.Hügel_Enum
              or
                BasisGrund = KartengrundDatentypen.Gebirge_Enum
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
        Aufgaben.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Festung_Bauen_Enum,
                                     KoordinatenExtern        => KoordinatenExtern)
      is
         when True =>
            if
              BasisGrund = KartengrundDatentypen.Eis_Enum
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
        Aufgaben.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Farm_Bauen_Enum,
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
      
      -- Vielleicht ist das Problem ja dass da immer die Koordinaten der Einheit genutzt werden und nicht die ermittelten Koordinaten? äöü
      case
        Aufgaben.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Straße_Bauen_Enum,
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

end KIEinheitFestlegenVerbesserungen;
