with KartenKonstanten;
with KartenRecordKonstanten;
with StadtDatentypen;
with SystemDatentypen;
with KartenDatentypen;

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
      use type KartenDatentypen.Waagerechte;
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
        PlatzGefunden.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Einheit_Verbessern_Enum);
            return True;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtDatentypen.StädtebereichVorhanden'Range loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtSchleifenwert),
                                                        EinheitNummerExtern      => EinheitSpeziesNummerExtern.Nummer);
               
               if
                 PlatzGefunden.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
         end case;
                               
      end loop StadtSchleife;
      
      case
        PlatzGefunden.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
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
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
      use type KIDatentypen.Bewegung_Enum;
   begin
      
      Umgebung := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Umgebung.Senkrechte .. Umgebung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Umgebung.Waagerechte .. Umgebung.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
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
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end EinheitVerbessernPlatz;

end KIEinheitFestlegenModernisierenLogik;
