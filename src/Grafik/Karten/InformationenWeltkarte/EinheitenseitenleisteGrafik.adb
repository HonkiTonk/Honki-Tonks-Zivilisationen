pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with Meldungstexte;
with EinheitenKonstanten;
with StadtKonstanten;
with TextnummernKonstanten;
with Views;
with TextKonstanten;
with GrafikDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenGrafik;
with KampfwerteEinheitErmittelnLogik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;

package body EinheitenseitenleisteGrafik is
   
   procedure Leer
     (AnzeigebereichExtern : in Positive)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (AnzeigebereichExtern),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (AnzeigebereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StadtVorhandenExtern : in Boolean)
   is begin
      
      case
        StadtVorhandenExtern
      is
         when True =>
            Leer (AnzeigebereichExtern => 4);
            
         when False =>
            Leer (AnzeigebereichExtern => 4);
            Leer (AnzeigebereichExtern => 3);
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitRasseNummer := EinheitRasseNummerExtern;
                        
         when others =>
            EinheitRasseNummer.Rasse := EinheitRasseNummerExtern.Rasse;
      end case;
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      case
        IDEinheit
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            FestzulegenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => IDEinheit,
                                                                                                                               RasseExtern => EinheitRasseNummer.Rasse));
            FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
              & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                    IDExtern    => IDEinheit));
      end case;
      
      if
        RasseExtern = EinheitRasseNummer.Rasse
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & " "
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)) & TextKonstanten.Trennzeichen
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                             IDExtern    => IDEinheit));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringErfahrungspunkte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & " "
           & EinheitenbeschreibungenGrafik.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer));
         FestzulegenderText (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigungszeit) & LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image;
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) & LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                            IDExtern    => IDEinheit)'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                                      IDExtern    => IDEinheit)'Wide_Wide_Image;
         FestzulegenderText (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & TextKonstanten.Trennzeichen
           & ZahlAlsStringRang (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                    IDExtern    => IDEinheit));
         FestzulegenderText (10) := Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (11) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGegenschlagskraftFeld) & KampfwerteEinheitErmittelnLogik.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                                        AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (12) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGegenschlagskraft) & KampfwerteEinheitErmittelnLogik.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                                AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (13) := Ladung (EinheitRasseNummerExtern => EinheitRasseNummer,
                                            IDExtern                 => IDEinheit);
         
         VolleInformation := True;
         
      else
         VolleInformation := False;
      end if;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         if
           VolleInformation = False
           and
             TextSchleifenwert >= 3
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         
            
         end if;
         
         case
           TextSchleifenwert
         is
            when 10 =>
               null;
                  
            when others =>
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
         end case;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Einheiten;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin

      Stadtnummer := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      case
        Stadtnummer
      is
         when StadtKonstanten.LeerNummer =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & " " & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeine);
               
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & " " & LeseStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   function Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDExtern)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Beladen := False;
            Ladungstext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                        IDExtern    => IDExtern) loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => LadungSchleifenwert);
         
         if
           Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
         then
            Beladen := True;
            Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
              & EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer)),
                                                                RasseExtern => EinheitRasseNummerExtern.Rasse);
            
         else
            null;
         end if;
            
      end loop LadungSchleife;
      
      case
        Beladen
      is
         when True =>
            return Ladungstext;
            
         when False =>
            return Ladungstext & " " & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeine);
      end case;
      
   end Ladung;

end EinheitenseitenleisteGrafik;
