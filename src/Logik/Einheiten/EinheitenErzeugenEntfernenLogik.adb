with EinheitenRecordKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeWichtiges;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

with SichtbarkeitsberechnungssystemLogik;
with SpeziesEntfernenLogik;
with EinheitenmodifizierungLogik;
with EinheitentransporterLogik;

package body EinheitenErzeugenEntfernenLogik is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitenDatentypen.EinheitenID;
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
                                                           VorzeichenWechselExtern    => 1);
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern));
      
   end EinheitErzeugen;



   -- Wenn ein Transporter eine Ladung enthält, dann diese erst komplett entfernen (inklusive der Ladungsladung), dann den Transporter entfernen und anschließend erst sortieren. äöü
   procedure EinheitEntfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Ladungsentfernung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Entfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Einheitensortierung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                                                           VorzeichenWechselExtern    => -1);
      
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

      SchreibeEinheitenGebaut.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Entfernen;
   
   
   
   -- Mit Sortierung sollte es möglich sein diverse Schleifen vorzeitig abzubrechen, die mal durchgehen. äöü
   procedure Einheitensortierung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Schleifenende := LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      SortierenSchleife:
      loop
         EinheitSchleife:
         for EinheitSchleifenwert in reverse EinheitenKonstanten.AnfangNummer .. Schleifenende loop
         
            case
              LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitSchleifenwert))
            is
               when EinheitenKonstanten.LeerID =>
                  null;
               
               when others =>
                  Sortierungsnummer := EinheitSchleifenwert;
                  exit EinheitSchleife;
            end case;
            
         end loop EinheitSchleife;
         
         PlatzSchleife:
         for PlatzSchleifenwert in EinheitenKonstanten. AnfangNummer .. Schleifenende loop
            
            null;
            
         end loop PlatzSchleife;
         
         exit SortierenSchleife;
         
      end loop SortierenSchleife;
      
      case
        Sortierungsnummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   EintragExtern              => LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer)));
      
            Transporternummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer));
      end case;
      
      case
        Transporternummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            EinheitentransporterLogik.LadungsnummerAnpassen (TransporterExtern      => (EinheitSpeziesNummerExtern.Spezies, Transporternummer),
                                                             LadungsnummerAltExtern => Sortierungsnummer,
                                                             LadungsnummerNeuExtern => EinheitSpeziesNummerExtern.Nummer);
      end case;
      
      EinheitentransporterLogik.LadungAnpassen (TransporterExtern => EinheitSpeziesNummerExtern);
      
      -- Das sollte nicht nötig sein, da SchreibeWeltkarte.EinheitSchreiben mit EinheitentauschExtern => True den Kartenwert überschreibt.
      -- SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer)),
      --                                     EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer));
      
      SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer),
                                             EintragExtern              => EinheitenRecordKonstanten.LeerEinheit);
      
      SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                          EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          EinheitentauschExtern      => True);
      
   end Einheitensortierung;

end EinheitenErzeugenEntfernenLogik;
