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
with GrafikRecordKonstanten;
with GrafikDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenSFML;
with KampfwerteEinheitErmitteln;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with TextberechnungenBreiteSFML;

package body InformationenEinheitenSFML is
   
   procedure Leer
     (AnzeigebereichExtern : in Positive)
   is begin
      
      -- Diese Bereiche sicherheitshalber auch von außen hineingeben? äöü
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (4),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (AnzeigebereichExtern));
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
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
      
      Textposition := TextKonstanten.StartpositionText;
      AktuelleYPosition := Textposition.y;
      Textbreite := 0.00;
      EinheitRasseNummer.Rasse := EinheitRasseNummerExtern.Rasse;
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitRasseNummer.Nummer := EinheitRasseNummerExtern.Nummer;
                        
         when others =>
            null;
      end case;
      
      FestzulegenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer),
                                                                                                                       RasseExtern => EinheitRasseNummer.Rasse));
      FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
      
      if
        RasseExtern = EinheitRasseNummer.Rasse
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & " "
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)) & TextKonstanten.Trennzeichen
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern =>
                                                                            LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image
           & TextKonstanten.Trennzeichen & ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & " "
           & EinheitenbeschreibungenSFML.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer));
         FestzulegenderText (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugBeschäftigungszeit) & LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image;
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) 
           & LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummer.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer))'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) &
           LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummer.Rasse,
                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer))'Wide_Wide_Image;
         FestzulegenderText (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & TextKonstanten.Trennzeichen
           & ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (10) := Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (11) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGegenschlagskraftFeld) & KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                                  AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (12) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGegenschlagskraft) & KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                          AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (13) := Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
         VolleInformation := True;
         
      else
         VolleInformation := False;
      end if;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                          position => (Textposition.x, AktuelleYPosition));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         
            Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                              TextbreiteExtern => Textbreite);
            
            AktuelleYPosition := AktuelleYPosition + TextberechnungenHoeheSFML.Zeilenabstand;
            
            case
              TextSchleifenwert
            is
               when TextaccessVariablen.EinheitenInformationenAccess'Last =>
                  Textposition.y := Textposition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert)).height;
                  
               when others =>
                  null;
            end case;
         end if;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
      Debuginformationen (EinheitRasseNummerExtern => EinheitRasseNummer);
      
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Beladen := False;
            Ladungstext := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                        IDExtern    => IDEinheit) loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => LadungSchleifenwert);
         
         if
           Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
         then
            Beladen := True;
            -- Das hier überall/öfter einbauen? äöü
            Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
              & EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer)),
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
   
   
   
   -- Debuginformationen einfach in die Konsole ausgeben lassen.
   procedure Debuginformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        SpielVariablen.Debug.VolleInformation = False
        or
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.KI_Spieler_Enum
      then
         return;
         
      else
         null;
      end if;
      
   end Debuginformationen;

end InformationenEinheitenSFML;
