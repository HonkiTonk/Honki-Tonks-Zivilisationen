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
with Fehlermeldungssystem;

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



   procedure EinheitEntfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      EinheitEntfernenLadung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Entfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        SpeziesEntfernenLogik.SpeziesExistiertNoch (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when others =>
            null;
      end case;
      
   end EinheitEntfernen;
   
   
   
   procedure EinheitEntfernenLadung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
        
         EinheitNummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlatzExtern                => LadungSchleifenwert);
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
         then
            null;
            
         else
            Entfernen (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer));
         end if;
         
      end loop TransporterSchleife;
               
   end EinheitEntfernenLadung;
   
   
   
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
      
      EinheitenSortieren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Entfernen;
   
   
      
   -- Mit Sortierung sollte es möglich sein diverse Schleifen vorzeitig abzubrechen, die mal durchgehen. äöü
   procedure EinheitenSortieren
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Einheitengrenze := LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      if
        EinheitSpeziesNummerExtern.Nummer = Einheitengrenze
      then
         return;
         
      elsif
        EinheitSpeziesNummerExtern.Nummer > Einheitengrenze
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinheitenErzeugenEntfernenLogik.EinheitenSortieren - Platz außerhalb der Einheitengrenze");
         return;
            
      else
         Sortierungsnummer := EinheitenKonstanten.LeerNummer;
      end if;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in reverse EinheitSpeziesNummerExtern.Nummer + 1 .. Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
               
            when others =>
               Sortierungsnummer := EinheitenSchleifenwert;
               exit EinheitenSchleife;
         end case;
         
      end loop EinheitenSchleife;
      
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
      
      -- Das hier (und vermutlich auch das zeug darüber) bereitet Probleme, wenn man einen Transporter mit beladenen Transportern entfernt. äöü
      -- Oder überhaupt einen beladenen Transporter. äöü
      -- Erst alles entfernen und dann Sortieren? äöü
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
      
   end EinheitenSortieren;

end EinheitenErzeugenEntfernenLogik;
