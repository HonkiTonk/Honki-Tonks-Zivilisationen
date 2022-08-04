pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;
with TextKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenBeschreibungen;
with KampfwerteEinheitErmitteln;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;

package body InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      TextbreiteAktuell := 0.00;
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
      
      FestzulegenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
      FestzulegenderText (2) := GlobaleTexte.Zeug (TextKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & Trennzeichen
        & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
      
      if
        RasseExtern = EinheitRasseNummer.Rasse
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (3) := GlobaleTexte.Zeug (TextKonstanten.ZeugBewegungspunkte) & " "
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)) & Trennzeichen
           & UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern =>
                                                                            LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (4) := GlobaleTexte.Zeug (TextKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & Trennzeichen
           & ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (5) := GlobaleTexte.Zeug (TextKonstanten.ZeugBeschäftigung) & " "
           & EinheitenBeschreibungen.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer));
         FestzulegenderText (6) := GlobaleTexte.Zeug (TextKonstanten.ZeugBeschäftigungszeit) & LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image;
         FestzulegenderText (7) := GlobaleTexte.Zeug (TextKonstanten.ZeugAngriff) 
           & LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummer.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer))'Wide_Wide_Image;
         FestzulegenderText (8) := GlobaleTexte.Zeug (TextKonstanten.ZeugVerteidigung) &
           LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummer.Rasse,
                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer))'Wide_Wide_Image;
         FestzulegenderText (9) := GlobaleTexte.Zeug (TextKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummer)'Wide_Wide_Image & Trennzeichen
           & ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)));
         FestzulegenderText (10) := Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         FestzulegenderText (11) := GlobaleTexte.Zeug (TextKonstanten.ZeugGegenschlagskraftFeld) & KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                           AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (12) := GlobaleTexte.Zeug (TextKonstanten.ZeugGegenschlagskraft) & KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummer,
                                                                                                                                                   AngreiferExtern          => False)'Wide_Wide_Image;
         FestzulegenderText (13) := Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
         VolleInformation := True;
         
      else
         VolleInformation := False;
      end if;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            exit TextSchleife;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         
            TextbreiteNeu := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert)).width + 2.00 * TextpositionExtern.x;
         
            if
              TextbreiteAktuell < TextbreiteNeu
            then
               TextbreiteAktuell := TextbreiteNeu;
            
            else
               null;
            end if;
         end if;
      
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
      end loop TextSchleife;
      
      Textposition.x := TextbreiteAktuell;
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Debuginformationen (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      return Textposition;
      
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
            return GlobaleTexte.Zeug (TextKonstanten.ZeugHeimatstadt) & " " & GlobaleTexte.Zeug (TextKonstanten.ZeugKeine);
               
         when others =>
            return GlobaleTexte.Zeug (TextKonstanten.ZeugHeimatstadt) & " " & LeseStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   -- Das hier überall/öfter einbauen? äöü
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
            Ladungstext := GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleLadung);
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
            Ladungstext := Ladungstext & Ladungsabstand & EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer)));
                  
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
            return Ladungstext & " " & GlobaleTexte.Zeug (TextKonstanten.ZeugKeine);
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
