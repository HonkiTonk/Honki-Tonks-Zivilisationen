pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;
with TextKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenBeschreibungen;
with KampfwerteEinheitErmitteln;
with DebugPlatzhalter;
with TextAllgemeinSFML;
with GrafikEinstellungenSFML;
with StadtInformationenSFML;

package body InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionTextExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      PositionText := PositionTextExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      TextAllgemeinSFML.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                              FontAccessExtern   => GrafikEinstellungenSFML.SchriftartAccess,
                                              SchriftgrößeExtern => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße,
                                              FarbeExtern        => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer := Allgemeines (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
        or
          DebugPlatzhalter.FeindlicheInformationenSehen
      then
         Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer);
         Angriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Verteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Rang (EinheitRasseNummerExtern => EinheitRasseNummer);
         Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuelleVerteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuellerAngriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
      else
         null;
      end if;
      
      DebugInformationen (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      return PositionText;
      
   end Einheiten;
   
   
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin
            
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      return (EinheitRasseNummerExtern.Rasse, EinheitNummer);
      
   end Allgemeines;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringLebenspunkte
        (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                    IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugLebenspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen 
                                         & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal
        (KommazahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugBewegungspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringKampfwerte
        (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                   IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugErfahrungspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Erfahrungspunkte;
   
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugBeschäftigung)) & " "
                                         & EinheitenBeschreibungen.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Beschäftigung;
   
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringMaximaleEinheitenMitNullWert (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugBeschäftigungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Beschäftigungszeit;
   
   
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAngriff)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugVerteidigung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Verteidigung;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringKampfwerte
        (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugRang)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Rang;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
         
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerNummer =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugHeimatstadt)) & " "
                                               & To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugKeine)));
               
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugHeimatstadt)) & " " 
                                               & StadtInformationenSFML.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                              LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern))));
      end case;
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Heimatstadt;
   
   
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             AngreiferExtern          => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugGegenschlagskraftFeld)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                         AngreiferExtern          => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugGegenschlagskraft)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuellerAngriff;
   
   
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            null;
               
         when others =>
            ErsteAnzeige := True;
            
            LadungSchleife:
            for LadungSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => IDEinheit) loop
                  
               if
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
                 and
                   ErsteAnzeige
               then
                  ErsteAnzeige := False;
      
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleLadung)));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
                  
      
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
               elsif
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
               then
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
               else
                  null;
               end if;
            
            end loop LadungSchleife;
      end case;
      
   end Ladung;
   
   
   
   procedure DebugInformationen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        DebugPlatzhalter.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            DebugPlatzhalter.KarteInfosEinheiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);                     
      end case;
      
   end DebugInformationen;

end InformationenEinheitenSFML;
