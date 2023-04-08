with KartenKonstanten;
with KartenRecordKonstanten;
with StadtDatentypen;

with LeseStadtGebaut;
with SchreibeEinheitenGebaut;

with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;
with EinheitVerbessernLogik;

with KIDatentypen;
with KIKonstanten;

with KIZielSuchenLogik;
with KIBewegungAllgemeinLogik;

package body KIEinheitFestlegenModernisierenLogik is

   -- Hier wird weder geprüft ob das Feld schon belegt ist, noch ob sich eine andere Einheit bereits dahin befindet. äöü
   -- Muss prüfen ob die Heimatstadt das mitmacht und die Geldgewinnung. Und natürlich ob eine benötigte Ressource vorhanden ist. äöü
   function EinheitVerbessern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        EinheitVerbessernLogik.EinheitVerbesserbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when EinheitenKonstanten.LeerID =>
            return False;
              
         when others =>
            PlatzGefunden := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           ZielartExtern              => KIDatentypen.Eigenes_Feld_Enum);
      end case;
            
      case
        PlatzGefunden.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Einheit_Verbessern_Enum);
            return True;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtDatentypen.MaximaleStädte'Range loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtSchleifenwert),
                                                        EinheitNummerExtern      => EinheitSpeziesNummerExtern.Nummer);
               
               if
                 PlatzGefunden.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
         end case;
                               
      end loop StadtSchleife;
      
      case
        PlatzGefunden.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return False;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Einheit_Verbessern_Enum);
            return True;
      end case;
      
   end EinheitVerbessern;
   
   
   
   -- Solche Stadtumgebungen auch mal in einer Funktion unterbringen oder soweit es möglich/sinnvoll ist? äöü
   function EinheitVerbessernPlatz
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Kartenfeld;
      use type KIDatentypen.Bewegung_Enum;
   begin
      
      Umgebung := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebung .. Umgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebung .. Umgebung loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern),
                                                                                NeueKoordinatenExtern      => KartenWert)
            then
               null;
               
            elsif
              KIKonstanten.BewegungNormal /= KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern      => KartenWert,
                                                                                    EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern))
            then
               null;
               
            else
               return KartenWert;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end EinheitVerbessernPlatz;

end KIEinheitFestlegenModernisierenLogik;
