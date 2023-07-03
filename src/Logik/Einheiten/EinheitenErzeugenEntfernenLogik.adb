with EinheitenRecordKonstanten;
with ProduktionKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeWichtiges;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with SichtbarkeitsberechnungssystemLogik;
with SpeziesEntfernenLogik;
with EinheitenmodifizierungLogik;
with EinheitentransporterLogik;

package body EinheitenErzeugenEntfernenLogik is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Standardwerte (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern),
                                             IDExtern                   => IDExtern,
                                             KoordinatenExtern          => KoordinatenExtern,
                                             StadtNummerExtern          => StadtSpeziesNummerExtern.Nummer);
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                             IDExtern      => IDExtern)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => True);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => True);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                               PlusMinusExtern => True);
      end case;
      
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern),
                                                          VorzeichenwechselExtern    => ProduktionKonstanten.VorzeichenPositiv);
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern));
      
   end EinheitErzeugen;



   -- Wenn ein Transporter eine Ladung enthält, dann diese erst komplett entfernen (inklusive der Ladungsladung), dann den Transporter entfernen und anschließend erst sortieren. äöü
   procedure EinheitEntfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Ladungsentfernung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Entfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Einheitensortierung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      case
        SpeziesEntfernenLogik.SpeziesExistiertNoch (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when others =>
            null;
      end case;
      
   end EinheitEntfernen;
   
   
   
   procedure Ladungsentfernung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when EinheitenDatentypen.Kein_Transport_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First
        .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                       IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              PlatzExtern                => LadungSchleifenwert)
         is
            when EinheitenKonstanten.LeerNummer =>
               null;
               
            when others =>
               Ladungsentfernung (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                                                        PlatzExtern                => LadungSchleifenwert)));
               Entfernen (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                                                PlatzExtern                => LadungSchleifenwert)));
         end case;
         
      end loop TransporterSchleife;
      
   end Ladungsentfernung;
   
   
   
   procedure Entfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
            
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           VorzeichenwechselExtern    => ProduktionKonstanten.VorzeichenNegativ);
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => False);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => False);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                               PlusMinusExtern => False);
      end case;
      
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            EinheitentransporterLogik.LadungsnummerAnpassen (TransporterExtern      => (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)),
                                                             LadungsnummerAltExtern => EinheitSpeziesNummerExtern.Nummer,
                                                             LadungsnummerNeuExtern => EinheitenKonstanten.LeerNummer);
      end case;

      SchreibeEinheitenGebaut.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Entfernen;
   
   
   
   -- Mit Sortierung sollte es möglich sein diverse Schleifen vorzeitig abzubrechen, die mal durchgehen. äöü
   procedure Einheitensortierung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      Schleifenanfang := EinheitenKonstanten.AnfangNummer;
      Schleifenende := LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern);
      
      SortierenSchleife:
      loop
         
         Einheitennummer := EinheitenKonstanten.LeerNummer;
         
         EinheitSchleife:
         for EinheitSchleifenwert in reverse EinheitenKonstanten.AnfangNummer + 1 .. Schleifenende loop
            
            case
              LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
            is
               when EinheitenKonstanten.LeerID =>
                  null;
               
               when others =>
                  Einheitennummer := EinheitSchleifenwert;
                  exit EinheitSchleife;
            end case;
            
         end loop EinheitSchleife;
         
         case
           Einheitennummer
         is
            when EinheitenKonstanten.LeerNummer =>
               exit SortierenSchleife;
               
            when others =>
               Schleifenende := Einheitennummer - 1;
         end case;
         
         PlatzSchleife:
         for PlatzSchleifenwert in EinheitenKonstanten.AnfangNummer .. Schleifenende loop
            
            case
              LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert))
            is
               when EinheitenKonstanten.LeerID =>
                  SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert),
                                                         EintragExtern              => LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, Einheitennummer)));
                  SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert),
                                                       KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert)),
                                                       EinheitentauschExtern      => True);
                  if
                    LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert)) = EinheitenKonstanten.LeerNummer
                  then
                     null;
                     
                  else
                     EinheitentransporterLogik.LadungsnummerAnpassen (TransporterExtern      => (SpeziesExtern, LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, PlatzSchleifenwert))),
                                                                      LadungsnummerAltExtern => Einheitennummer,
                                                                      LadungsnummerNeuExtern => PlatzSchleifenwert);
                  end if;
                  
                  EinheitentransporterLogik.LadungAnpassen (TransporterExtern => (SpeziesExtern, PlatzSchleifenwert));
                  
                  SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, Einheitennummer),
                                                         EintragExtern              => EinheitenRecordKonstanten.LeerEinheit);
                  
               when others =>
                  null;
            end case;
            
         end loop PlatzSchleife;
      end loop SortierenSchleife;
      
   end Einheitensortierung;

end EinheitenErzeugenEntfernenLogik;
