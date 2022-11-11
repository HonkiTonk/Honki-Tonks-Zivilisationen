with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;

with SichtbarkeitsberechnungssystemLogik;
with KennenlernenLogik;
with TransporterLadungsverschiebungLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body BewegungsberechnungEinheitenLogik is

   procedure Bewegungsberechnung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is begin
      
      BewegungspunkteAbzug := BewegungspunkteBerechnenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        BewegungspunkteAbzug = EinheitenKonstanten.EinheitUnbewegbar
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                  RechnenSetzenExtern      => False);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => -BewegungspunkteAbzug,
                                                  RechnenSetzenExtern      => True);
         
         IstLadung := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell.EAchse := NeueKoordinatenExtern.EAchse;
            
         when others =>
            null;
      end case;

      case
        IstLadung
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            TransporterBeladenEntladenLogik.EinheitAusladen (TransporterExtern => (EinheitRasseNummerExtern.Rasse, IstLadung),
                                                             LadungExtern      => EinheitRasseNummerExtern.Nummer);
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           KoordinatenExtern        => NeueKoordinatenExtern,
                                           EinheitentauschExtern    => EinheitentauschExtern);
      
      TransporterLadungsverschiebungLogik.LadungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeueKoordinatenExtern    => NeueKoordinatenExtern);
      
      NachBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Bewegungsberechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft ob die Einheit jetzt auf einem Feld steht welches von einer fremden Rasse bereits aufgedeckt wurde und stellt entsprechend Kontakt her.
      -- Anders als die Berechnung in SichtbarkeitLogik, wo geprüft wird ob eine fremde Stadt oder Einheit auf einem neu aufgedecktem Feld steht.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in SpielVariablen.RassenbelegungArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             SpielVariablen.Rassenbelegung (FremdeSichtbarkeitSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => NeueKoordinatenExtern,
                                          RasseExtern       => FremdeSichtbarkeitSchleifenwert)
         then
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                           FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;

end BewegungsberechnungEinheitenLogik;
