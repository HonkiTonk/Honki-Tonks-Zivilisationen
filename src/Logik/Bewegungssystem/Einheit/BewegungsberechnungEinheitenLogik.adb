with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with SchreibeCursor;

with SichtbarkeitsberechnungssystemLogik;
with KennenlernenLogik;
with TransporterLadungsverschiebungLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body BewegungsberechnungEinheitenLogik is

   procedure Bewegungsberechnung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      BewegungspunkteAbzug := BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                                                             EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      -- Hier noch eine Erschöpfung einbauen? äöü
      if
        BewegungspunkteAbzug = EinheitenKonstanten.LeerBewegungspunkte
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                  BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                                  RechnenSetzenExtern        => False);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                  BewegungspunkteExtern      => -BewegungspunkteAbzug,
                                                  RechnenSetzenExtern        => True);
         
         IstLadung := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            SchreibeCursor.EAchseAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                          EAchseExtern  => NeueKoordinatenExtern.EAchse);
            
         when others =>
            null;
      end case;

      case
        IstLadung
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            TransporterBeladenEntladenLogik.EinheitAusladen (TransporterExtern => (EinheitSpeziesNummerExtern.Spezies, IstLadung),
                                                             LadungExtern      => EinheitSpeziesNummerExtern.Nummer);
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                           KoordinatenExtern          => NeueKoordinatenExtern,
                                           EinheitentauschExtern      => EinheitentauschExtern);
      
      TransporterLadungsverschiebungLogik.LadungVerschieben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             NeueKoordinatenExtern      => NeueKoordinatenExtern);
      
      NachBewegung (NeueKoordinatenExtern      => NeueKoordinatenExtern,
                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Bewegungsberechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      -- Prüft ob die Einheit jetzt auf einem Feld steht welches von einer fremden Spezies bereits aufgedeckt wurde und stellt entsprechend Kontakt her.
      -- Anders als die Berechnung in SichtbarkeitLogik, wo geprüft wird ob eine fremde Stadt oder Einheit auf einem neu aufgedecktem Feld steht.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSichtbarkeitSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => NeueKoordinatenExtern,
                                          SpeziesExtern     => FremdeSichtbarkeitSchleifenwert)
         then
            KennenlernenLogik.Erstkontakt (EigeneSpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                           FremdeSpeziesExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;

end BewegungsberechnungEinheitenLogik;
